param (
    [string[]]$block,
    [string[]]$unblock
)
function _help() {
    Write-Host " Block Hosts File "
    Write-Host " $block_entries   : Block Entries"
    Write-Host " $unblock_entries  : Unblock Entires"
}
if ("-h" -in $args) {
    _help;
    exit
}


$block_entries = @("--block", "-b")
$unblock_entries = @("--unblock", "-u")
$hostsFilePath = "C:\Windows\System32\drivers\etc\hosts"

function remove_entry($url) {

}

if ($args.Length -lt 1) {
    _help
    exit
}






blocked = @(
    "www.reddit.com",
    "www.discord.com"
)



ipconfig /flushdns