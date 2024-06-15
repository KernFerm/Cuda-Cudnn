# CUDA-CUDNN 11.8 Auto Installer Script

This PowerShell script automates the installation of CUDA and cuDNN on Windows systems. It is designed to simplify the setup process for developers working with NVIDIA's CUDA technology.

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

## Usage

1. **Ensure Prerequisites**: Make sure you have 7-Zip installed on your system.
2. **Download Script**: Download the `Cuda-Cudnn-Auto-Installer.ps1` script to your local machine.
3. **Run Script**: Right-click the script and select "Run with PowerShell". Administrator privileges may be required.
4. **Follow Instructions**: The script will guide you through the necessary steps, including downloading and installing CUDA, and setting up cuDNN.

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