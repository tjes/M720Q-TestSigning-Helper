# SDK Tools
$SDKPath = "C:\Program Files (x86)\Windows Kits\10\bin\10.0.22621.0\"

$paths = @{
	'inf2cat' = "$SDKPath\x86\Inf2Cat.exe";
	'makecert' = "$SDKPath\x86\MakeCert.exe";
	'signtool' = "$SDKPath\x86\signtool.exe"
}

$driverPath = ".\driver\"

#

# Validate all the tools are where we left them
foreach ($tool in $paths.Values) {
	if (-not (Test-Path $tool)) {
		throw "Missing required tool: $tool"
	}
}

# MakeCert: Create self-signed certificate for driver signing
if (-not (Test-Path ".\DriverSigning.cer")) {
	$certcn = Read-Host -Prompt "Please enter the desired certificate CN"
	& $paths['makecert'] -r -pe -ss PrivateCertStore -n CN=$certcn -eku 1.3.6.1.5.5.7.3.3 DriverSigning.cer
} 

# INF2CAT: Validate the OS Version signing requirements and generate cat files
$osver = "ServerFE_X64" # Server 2022 / Azure Stack HCI
Remove-Item -Path $driverPath\*.cat -Force
& $paths['inf2cat'] /driver:$driverPath /os:$osver 

# Sign all of the cat files in the driver folder
foreach ($driver in (Get-Childitem -Path "$driverPath\*.cat")) {
	& $paths['signtool'] sign /v /fd sha256 /s PrivateCertStore /n $certcn /t http://timestamp.digicert.com $driver
}