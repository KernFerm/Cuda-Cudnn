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

# v7.4.3 Release of PowerShell - Latest (recommended)
      choose your recommended pc specs either 32bit or 64bit 

- [64-Bit-Installer](https://github.com/PowerShell/PowerShell/releases/download/v7.4.3/PowerShell-7.4.3-win-x64.msi)
- [32-Bit-Installer](https://github.com/PowerShell/PowerShell/releases/download/v7.4.3/PowerShell-7.4.3-win-x86.msi)

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
