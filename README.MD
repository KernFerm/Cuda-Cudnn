# CUDA 11.8 - CUDNN 8.9.7 Auto Installer Script

This PowerShell script automates the installation of CUDA and cuDNN on Windows systems. It is designed to simplify the setup process for developers working with NVIDIA's CUDA technology.

## how to download the repo first time users

  - click link to read [**Instructions**](https://www.fnbubbles420.org/Instructions-On-How-To-Download-Repo)

## Features

- **Automatic Download**: Downloads the specified version of CUDA directly from NVIDIA's servers.
- **Installation**: Silently installs CUDA without requiring user interaction during the process.
- **Cleanup**: Removes temporary files and directories created during the installation process.
- **cuDNN Setup**: Searches for a specified cuDNN zip file on the system and extracts it to the appropriate directory.

## Prerequisites

- Windows Operating System
- PowerShell 5.1 or higher
- Internet connection for downloading CUDA
- 7-Zip installed for extracting cuDNN archive
- You need to have PowerShell installed on your system. This is used to run the script.
- `Both` MSI are from the official github page of [Official-PowerShell-Github](https://github.com/PowerShell)

# v7.4.4 Release of PowerShell - Latest (recommended)
      choose your recommended pc specs either 32bit or 64bit 

    - For `64-bit systems`, download the `64-bit installer`: [Download 64-Bit Installer](https://github.com/PowerShell/PowerShell/releases/download/v7.4.4/PowerShell-7.4.4-win-x64.msi)
    - For `32-bit systems`, download the `32-bit installer`: [Download 32-Bit Installer](https://github.com/PowerShell/PowerShell/releases/download/v7.4.4/PowerShell-7.4.4-win-x86.msi)


# Logging Functionality in CUDA Installation PowerShell Script

This document describes the logging functionality implemented in the CUDA installation PowerShell script. The script includes a custom logging mechanism that records various events and actions during its execution.

## Log File

The log file is created on the user's Desktop and is named `cuda_install_log.txt`. This file captures all logged messages along with their timestamps.

## Log Function

### Definition

The `Log` function is defined at the beginning of the script. It takes a single parameter, `message`, which is the string to be logged. The function appends this message to the log file with a timestamp.

```powershell
# Define log file
$logFile = "$env:UserProfile\Desktop\cuda_install_log.txt"

function Log {
    param ([string]$message)
    Add-Content -Path $logFile -Value "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - $message"
}
```

## Usage
- The `Log` function is called throughout the script to log important events, errors, and actions. Each call to `Log` includes a descriptive message that is appended to the log file.

## Example Usages

1. Logging the creation of a directory:
```
if (-not (Test-Path -Path $destDir)) {
    New-Item -ItemType Directory -Path $destDir | Out-Null
    Log "Created directory: $destDir"
} else {
    Log "Directory already exists: $destDir"
}
```

2. Logging the download of the CUDA installer:
```
try {
    Invoke-WebRequest -Uri $cudaUrl -OutFile $cudaInstaller
    Log "Downloaded CUDA installer to: $cudaInstaller"
} catch {
    Log "Error downloading CUDA installer: $_"
    exit
}
```

3. Logging the execution of the CUDA installer:
```
try {
    Start-Process -FilePath $cudaInstaller -ArgumentList "-s -n" -Wait
    Log "Executed CUDA installer: $cudaInstaller"
} catch {
    Log "Error executing CUDA installer: $_"
    exit
}
```

4. Logging errors during various operations:
```
catch {
    Log "Error removing read-only attributes: $_"
}
```

## Complete Example
- Below is an excerpt from the script showing the `Log` function in action:
```
# Define log file
$logFile = "$env:UserProfile\Desktop\cuda_install_log.txt"

function Log {
    param ([string]$message)
    Add-Content -Path $logFile -Value "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - $message"
}

# Example usage of the Log function
$destDir = "$env:UserProfile\Desktop\tempcudav11.8"
Log "Destination directory: $destDir"

if (-not (Test-Path -Path $destDir)) {
    New-Item -ItemType Directory -Path $destDir | Out-Null
    Log "Created directory: $destDir"
} else {
    Log "Directory already exists: $destDir"
}

$cudaUrl = "https://developer.download.nvidia.com/compute/cuda/11.8.0/network_installers/cuda_11.8.0_windows_network.exe"
$cudaInstaller = "$destDir\cuda_11.8.0_windows_network.exe"

try {
    Invoke-WebRequest -Uri $cudaUrl -OutFile $cudaInstaller
    Log "Downloaded CUDA installer to: $cudaInstaller"
} catch {
    Log "Error downloading CUDA installer: $_"
    exit
}

Start-Process "explorer.exe" -ArgumentList $destDir
Log "Opened directory in Explorer: $destDir"

try {
    Start-Process -FilePath $cudaInstaller -ArgumentList "-s -n" -Wait
    Log "Executed CUDA installer: $cudaInstaller"
} catch {
    Log "Error executing CUDA installer: $_"
    exit
}
```

## Usage

1. **Ensure Prerequisites**: Make sure you have 7-Zip installed on your system.
2. **Download Script**: Download the `Cuda-Cudnn-Auto-Installer.ps1` script to your local machine.
3. **Run Script**: Right-click the script and select "Run with PowerShell". Administrator privileges may be required.
4. **Follow Instructions**: The script will guide you through the necessary steps, including downloading and installing CUDA, and setting up cuDNN.

```
cd your/path/of/the/ps1/file
```
### if usage doesnt work use this first run it then select `Y` thats it click enter then run the script again 
```
Set-ExecutionPolicy Bypass -Scope Process
```
then repeat the process you can leave powershell open in admin mode to do this you dont have to close it

## run script 

```
.\Cuda-Cudnn-Auto-Installer.ps1
```

## Customization

You can modify the script to download different versions of CUDA or cuDNN by changing the `$cudaUrl` and `$zipName` variables respectively.

## Troubleshooting

- **7-Zip Not Found**: Ensure 7-Zip is installed and the path in the script points to the correct location of `7z.exe`.
- **Download Issues**: Check your internet connection and the availability of the CUDA download link.
- **Permission Errors**: Run the script with administrator privileges.

## Disclaimer

This script is provided as-is without any warranty. It is recommended to review the script before running it on your system.

## License

This script is released under the MIT License.
