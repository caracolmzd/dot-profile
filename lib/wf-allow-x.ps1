# powershell script to create Windows Defender (firewall) rule for X Server (allow)

# https://github.com/marchaesen/vcxsrv/releases
# Set correct path to VcXSrv:
$exe = "C:\VcXsrv\vcxsrv.exe"

if (!(Test-Path $exe)) {
    Write-Host "Executable not found at $exe"
    exit 1
}

New-NetFirewallRule -DisplayName "VcXsrv X-Server" `
    -Direction Inbound -Program $exe -Action Allow -Profile Any
