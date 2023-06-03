param(
	[switch]$MDT # this is untested
)

if (Confirm-SecureBootUEFI) {
	Write-Warning "Please reboot into UEFI and disable secure boot."
	pause
	exit 1
}

if ((bcdedit | select-string -pattern "TESTSIGNING") -match "testsigning.*Yes") {
	& 'bcdedit' '/set' 'LOADOPTIONS' 'DISABLE_INTEGRITY_CHECKS'
	& 'bcdedit' '/set' 'TESTSIGNING' 'ON'
	& 'bcdedit' '/set' 'nointegritychecks' 'off'
	
	if ($MDT.IsPresent) {
		$TS = New-Object -ComObject Microsoft.SMS.TSEnvironment
		$TS.Value('SMSTSRebootRequested') = $true
		$TS.Value('SMSTSRetryRequested') = $true
		exit 1607
	}

	throw "TESTSIGNING has been configured, please restart your computer and run this script again."
	exit 1
}

# Load test signing certificate
#& 'certmgmt' '/add' 'DriverSigning.cer' '/s' '/r' 'localMachine' 'root'
& 'certutil' '-addstore' 'Root' 'DriverSigning.cer'

# Load driver
& 'pnputil' '/a' "driver\*.inf" "/install"