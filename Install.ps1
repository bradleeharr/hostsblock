
$Script = "$PSScriptRoot\HostsBlockAdmin.ps1"
Write-Host $Script
Add-Content -Path $PROFILE -Value "`nSet-Alias -Name HBlock -Value $Script"
