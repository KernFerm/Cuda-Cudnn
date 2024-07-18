# Define log file
$logFile = "$env:UserProfile\Desktop\cuda_install_log.txt"
function Log {
    param ([string]$message)
    Add-Content -Path $logFile -Value "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - $message"
}

# Define the destination directory
$destDir = "$env:UserProfile\Desktop\tempcudav11.8"
Log "Destination directory: $destDir"

# Create the folder if it doesn't exist
if (-not (Test-Path -Path $destDir)) {
    New-Item -ItemType Directory -Path $destDir | Out-Null
    Log "Created directory: $destDir"
} else {
    Log "Directory already exists: $destDir"
}

# Download the file to the specified directory
$cudaUrl = "https://developer.download.nvidia.com/compute/cuda/11.8.0/network_installers/cuda_11.8.0_windows_network.exe"
$cudaInstaller = "$destDir\cuda_11.8.0_windows_network.exe"

try {
    Invoke-WebRequest -Uri $cudaUrl -OutFile $cudaInstaller
    Log "Downloaded CUDA installer to: $cudaInstaller"
} catch {
    Log "Error downloading CUDA installer: $_"
    exit
}

# Open the folder (optional, for viewing)
Start-Process "explorer.exe" -ArgumentList $destDir
Log "Opened directory in Explorer: $destDir"

# Execute the installation (user must wait for completion manually)
try {
    Start-Process -FilePath $cudaInstaller -ArgumentList "-s -n" -Wait
    Log "Executed CUDA installer: $cudaInstaller"
} catch {
    Log "Error executing CUDA installer: $_"
    exit
}

# Remove the read-only attribute from the folder and its contents
try {
    Get-ChildItem -Path $destDir -Recurse | ForEach-Object { $_.Attributes = 'Normal' }
    Log "Removed read-only attributes from files in: $destDir"
} catch {
    Log "Error removing read-only attributes: $_"
}

# Cleanup: Delete the tempcudav11.8 folder
try {
    Remove-Item -Path $destDir -Recurse -Force
    Log "Deleted directory: $destDir"
} catch {
    Log "Error deleting directory: $destDir"
}

# Set ZIP name and destination paths
$zipName = "cudnn-windows-x86_64-8.9.7.29_cuda11-archive.zip"
$destPath = "$env:UserProfile\Desktop"
$finalDest = "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.8"
Log "ZIP name: $zipName, Destination path: $destPath, Final destination: $finalDest"

# Search for the ZIP file
$found = Get-ChildItem -Path "C:\" -Recurse -Filter $zipName -ErrorAction SilentlyContinue

if (-not $found) {
    Log "File $zipName not found."
    exit
}

Log "Found $zipName at $($found.FullName)"

# Check for 7-Zip
$sevenZipPath = "C:\Program Files\7-Zip\7z.exe"
if (-not (Test-Path -Path $sevenZipPath)) {
    Log "7-Zip not found. Please install it or check the path."
    exit
}

# Extract the ZIP file
try {
    & $sevenZipPath x $found.FullName "-o$destPath" -y
    Log "Extracted ZIP file to: $destPath"
} catch {
    Log "Error extracting ZIP file: $_"
    exit
}

$extractedFolder = "$destPath\cudnn-windows-x86_64-8.9.7.29_cuda11-archive"
if (Test-Path -Path $extractedFolder) {
    try {
        Copy-Item -Path "$extractedFolder\*" -Destination $finalDest -Recurse -Force
        Log "Moved extracted files to: $finalDest"
        Remove-Item -Path $extractedFolder -Recurse -Force
        Log "Deleted extracted folder from Desktop: $extractedFolder"
    } catch {
        Log "Error moving or deleting extracted files: $_"
    }
} else {
    Log "Extracted folder not found: $extractedFolder"
}

# Uninstall torch, torchvision, and torchaudio
Log "Uninstalling torch, torchvision, and torchaudio..."
try {
    pip uninstall torch torchvision torchaudio -y
    Log "Uninstalled torch, torchvision, and torchaudio"
} catch {
    Log "Error uninstalling packages: $_"
}

# Update pip to the latest version
Log "Updating pip to the latest version..."
try {
    python -m pip install --upgrade pip
    Log "Updated pip to the latest version"
} catch {
    Log "Error updating pip: $_"
}

# Install the nightly versions of torch, torchvision, and torchaudio (CUDA 11.8)
Log "Installing the nightly versions of torch, torchvision, and torchaudio..."
try {
    pip install torch==2.0.1 torchvision==0.15.2 torchaudio==2.0.2 --index-url https://download.pytorch.org/whl/cu118
    Log "Installed nightly versions of torch, torchvision, and torchaudio"
} catch {
    Log "Error installing nightly versions of packages: $_"
}

Log "Operation completed."
Pause
