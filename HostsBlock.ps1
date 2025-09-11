
$block_entries = @("--block", "-b")
$unblock_entires = @("--unblock", "-u")
function _help() {
    Write-Host " Block Hosts File "
    Write-Host " $block_entries   : Block Entries"
    Write-Host " $unblock_entries  : Unblock Entires"
}

if ($args.Length -lt 1) {
    _help
    exit
}

$flag = $($args[1])
if ( $flag -in $block_entries) {
    Write-Host "ARGS: $($args[1])"
    Write-Host "Block Items"
}

# cat C:\Windows\System32\drivers\etc\hosts

blocked = @(
    "www.reddit.com",
    "www.discord.com"
)



ipconfig /flushdns