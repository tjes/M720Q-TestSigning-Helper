# M720q TestSigning Helper
This repository contains a collection of scripts for preparing and installing test signed NIC drivers on Lenovo M720q's running Server 2022. This can be used for other drivers/versions of Windows with minor modifications.

## DISCLAIMER
Using modified drivers can cause unexpected behavior with your computer. These scripts are provided AS-IS with no guarantees or warranties.

## Requirements
- A system to run the `prepare.ps1` script from - it should be setup with the latest version of the following:
    - Windows Software Development Kit
    - Windows Driver Kit
- Windows Server 2022 Core/Desktop Edition or similar running on your target system.
- Git-SCM with Git Bash or Cygwin for the `diff` tool.
- A copy of the latest Intel Ethernet Adapter Complete Driver pack
    - At time of writing: https://www.intel.com/content/www/us/en/download/15084/intel-ethernet-adapter-complete-driver-pack.html

## 1. Modifying the Driver
1. Extract the driver zip, copy the 'e1d*' driver files from 'PRO1000\Winx64\WS2022' to 'driver\'
2. Apply the diff from drivers/e1d-m720q.diff in Git Bash: `patch e1d.inf < e1d-m720q.diff`

## 2. Test Signing
Run `.\prepare.ps1` in powershell to test sign the driver. Follow the prompts.

## 3. Installing
Run `.\install.ps1` in powershell on the target system to install the test signed driver.

## References
- Test Signing: https://learn.microsoft.com/en-us/windows-hardware/drivers/install/how-to-test-sign-a-driver-package
- Driver Modification: https://learn.microsoft.com/en-us/windows-hardware/drivers/install/inf-manufacturer-section