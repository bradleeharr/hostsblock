


$Script = "$PSScriptRoot\HostsBlockAdmin.ps1"
Write-Host $Script


Write-Host "Adding HBlock to Profile..."
if (!(Test-Path -Path $PROFILE)) {
    Write-Host "    Profile Does not Exist... Creating new File $PROFILE"
    New-Item -ItemType File -Path $PROFILE
}

Write-Host "    Adding item to Profile..."
Add-Content -Path $PROFILE -Value "`nSet-Alias -Name HBlock -Value $Script"
