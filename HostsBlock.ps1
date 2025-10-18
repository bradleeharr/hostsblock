param (
    [string[]]$block,
    [string[]]$unblock,
    [string]$outputFile
)
$hostsFilePath = "C:\Windows\System32\drivers\etc\hosts"
function _help() {
    Write-Host "HostsBlock.ps1 -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- "
    Write-Host " | A script utility for adding lines to block websites via hosts file / remove entries on host file by url "
    Write-Host " |  --block : List of entries to block"
    Write-Host " |  --unblock : List of entries to unblock"
    Write-Host " |  --outputFile : (Optional) the path for the hosts file to write to."
    Write-Host " |                 Otherwise will write to the path at '$hostsFilePath'"
    Write-Host " |  -h / --help : Print help"
    Write-Host " |  -l / --list : List host file content"
    Write-Host "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- "
}

if ("-h" -in $args -or $args.Length -lt 1) {
    _help; 
    exit
}
if ("-l" -in $args -or "--list" -in $args) {
    Write-Host "List in args"
    Get-Content $hostsFilePath
    exit
}
if (!$outputFile) {
    Write-Host "Output File Empty, Saving to Default"
    $outputFile = "hosts.txt"
}
Out-File $outputFile -Encoding UTF8

$block_entries = @("--block", "-b")
$unblock_entries = @("--unblock", "-u")

function remove_entry($url) {
}







blocked = @(
    "www.reddit.com",
    "www.discord.com"
)



ipconfig /flushdns