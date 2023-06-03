# TESTSIGNING Helper
This repository contains a collection of scripts for preparing and installing test signed drivers on Windows Server Core systems.

## Requirements
The latest version of:
- Windows Software Development Kit
- Windows Driver Kit

## Usage
1. Store the modified driver files in the driver\ folder.
2. Run `.\prepare.ps1` to test sign the driver.
3. Run `.\install.ps1` on the target system to install the test signed driver.