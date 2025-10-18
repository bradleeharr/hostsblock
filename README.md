# HostsBlock
* This is a simple PowerShell command-line utility for adding and clearing entries quickly to your Hosts file

# Usage
* ` .\HostsBlock.ps1 -help ` for help
* ` .\HostsBlock.ps1 -list ` to list the hosts file
* ` .\HostsBlock.ps1 -t -block "www.amazon.com" ` to test what the hosts file would look like with the added entry

### Admin Scripts (With Elevated Permission to Edit Actual Hosts File)
* ` .\HostsBlockAdmin.ps1 -block "www.tiktok.com"    `
* ` .\HostsBlockAdmin.ps1 -block "www.reddit.com"    `
* ` .\HostsBlockAdmin.ps1 -clear `    