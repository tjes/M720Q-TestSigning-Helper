# TESTSIGNING Helper for M720q/M920q
This repository contains a collection of scripts for preparing and installing test signed NIC drivers on Lenovo M720q's running Server 2022. This can be used for other drivers/versions of Windows with minor modifications.

## Requirements
- A system to run the `prepare.ps1` script from - it should be setup with the latest version of the following:
    - Windows Software Development Kit
    - Windows Driver Kit
- Windows Server 2022 Core/Desktop Edition or similar running on your target system.
- GitSCM with Git Bash or Cygwin for the `diff` tool.
- A copy of the latest Intel Ethernet Adapter Complete Driver pack - https://www.intel.com/content/www/us/en/download/15084/intel-ethernet-adapter-complete-driver-pack.html

## 1. Modifying the Driver
1. Create the 'driver' folder. This will hold the modified driver.
2. Extract the driver zip, copy the 'e1d*' driver files from 'PRO1000\Winx64\WS2022' to 'driver\'
3. Apply the diff from diffs/m720 in Git Bash: `patch e1d.inf < e1d-m720q.diff`

## 2. Test Signing
1. Store the modified driver files in the driver\ folder.
2. Run `.\prepare.ps1` in powershell to test sign the driver. Follow the prompts.

## 3. Installing
1. Run `.\install.ps1` in powershell on the target system to install the test signed driver.

## References
- Test Signing: https://learn.microsoft.com/en-us/windows-hardware/drivers/install/how-to-test-sign-a-driver-package
- Driver Modification: https://learn.microsoft.com/en-us/windows-hardware/drivers/install/inf-manufacturer-section