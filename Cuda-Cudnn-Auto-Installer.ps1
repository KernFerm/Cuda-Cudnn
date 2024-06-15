# Define the destination directory
$destDir = "$env:UserProfile\Desktop\tempcudav11.8"

# Create the folder if it doesn't exist
if (-not (Test-Path -Path $destDir)) {
    New-Item -ItemType Directory -Path $destDir
}

# Download the file to the specified directory
$cudaUrl = "https://developer.download.nvidia.com/compute/cuda/11.8.0/network_installers/cuda_11.8.0_windows_network.exe"
Invoke-WebRequest -Uri $cudaUrl -OutFile "$destDir\cuda_11.8.0_windows_network.exe"

# Open the folder (optional, for viewing)
Start-Process "explorer.exe" -ArgumentList $destDir

# Execute the installation (user must wait for completion manually)
Start-Process -FilePath "$destDir\cuda_11.8.0_windows_network.exe" -ArgumentList "-s -n" -Wait

# Remove the read-only attribute from the folder and its contents
Get-ChildItem -Path $destDir -Recurse | ForEach-Object { $_.Attributes = 'Normal' }

# Cleanup: Delete the tempcudav11.8 folder
Remove-Item -Path $destDir -Recurse -Force

# Set ZIP name and destination paths
$zipName = "cudnn-windows-x86_64-8.9.7.29_cuda11-archive.zip"
$destPath = "$env:UserProfile\Desktop"
$finalDest = "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.8"

# Search for the ZIP file
$found = Get-ChildItem -Path "C:\" -Recurse -Filter $zipName -ErrorAction SilentlyContinue

if (-not $found) {
    Write-Output "File $zipName not found."
    exit
}

Write-Output "Found $zipName at $($found.FullName)"

# Check for 7-Zip
$sevenZipPath = "C:\Program Files\7-Zip\7z.exe"
if (-not (Test-Path -Path $sevenZipPath)) {
    Write-Output "7-Zip not found. Please install it or check the path."
    exit
}

# Extract the ZIP file
& $sevenZipPath x $found.FullName "-o$destPath" -y
Write-Output "Files extracted to $destPath."

$extractedFolder = "$destPath\cudnn-windows-x86_64-8.9.7.29_cuda11-archive"
if (Test-Path -Path $extractedFolder) {
    Write-Output "Moving extracted files to $finalDest"
    Copy-Item -Path "$extractedFolder\*" -Destination $finalDest -Recurse -Force
    Write-Output "Files moved."
    Remove-Item -Path $extractedFolder -Recurse -Force
    Write-Output "Extracted folder deleted from Desktop."
} else {
    Write-Output "Extracted folder not found."
}

# Uninstall torch, torchvision, and torchaudio
Write-Output "Uninstalling torch, torchvision, and torchaudio..."
pip uninstall torch torchvision torchaudio -y

# Install the nightly versions of torch, torchvision, and torchaudio (CUDA 11.8)
Write-Output "Installing the nightly versions of torch, torchvision, and torchaudio..."
pip install torch==2.0.1 torchvision==0.15.2 torchaudio==2.0.2 --index-url https://download.pytorch.org/whl/cu118

Write-Output "Operation completed."
Pause
