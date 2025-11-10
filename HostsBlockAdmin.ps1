Write-Host "This script runs the HostsBlock.ps1, requesting Admin permissions."
Write-Warning "(Warning) This script runs the HostsBlock.ps1, requesting Admin permissions."


Write-Host "Args : $args"

if ("--list" -in $args) {
   Start-Process powershell.exe  -Verb RunAs -ArgumentList "-NoExit -File $PSScriptRoot\HostsBlock.ps1 $args"
}
else {
   Start-Process powershell.exe  -Verb RunAs -ArgumentList "-File $PSScriptRoot\HostsBlock.ps1 $args"
}
