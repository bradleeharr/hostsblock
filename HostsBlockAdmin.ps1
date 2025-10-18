Write-Host "This script runs the HostsBlock.ps1, requesting Admin permissions."
Write-Warning "(Warning) This script runs the HostsBlock.ps1, requesting Admin permissions."

Write-Host "Args : $args"
Start-Process powershell.exe  -Verb RunAs -ArgumentList "-NoExit -File $(pwd)\HostsBlock.ps1 $args"  
