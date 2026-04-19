# HostsBlock
* This is a simple PowerShell command-line utility for adding and clearing entries quickly to your Hosts file

# Alias Install
* You can install this script to have an Alias 'HBlock' with the Install.ps1 Script. This will add an entry to the Powershell $PROFILE, which runs on startup.
* Usage is then `HBlock -help`, etc.


# ExecutionPolicy
* This uses a powershell script for functionality. 
* Please configure your ExecutionPolicy if it is not alreayd configured
* You may do this by opening an administrator powershell window and entering:
    * `Set-ExecutionPolicy -RemoteSigned` 

# Usage
* ` .\HostsBlock.ps1 -help ` for help
* ` .\HostsBlock.ps1 -list ` to list the hosts file
* ` .\HostsBlock.ps1 -t -block "www.amazon.com" ` to test what the hosts file would look like with the added entry

### Admin Scripts (With Elevated Permission to Edit Actual Hosts File)
* ` .\HostsBlockAdmin.ps1 -block "www.tiktok.com" `
* ` .\HostsBlockAdmin.ps1 -block "www.reddit.com" `
* ` .\HostsBlockAdmin.ps1 -clear `    

