param (
    [Parameter()]
    [string[]]$block,
    [Parameter()]
    [string[]]$unblock,
    [Parameter()]
    [string]$outputFile
)
$hostsFilePath = "C:\Windows\System32\drivers\etc\hosts"
$backupDir = "./backup/($(Get-Date -Format 'yyyy-MM-dd_HH-mm-ss'))"
function _help() {
    Write-Host "HostsBlock.ps1 -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- "
    Write-Host " | A script utility for adding lines to block websites via hosts file / remove entries on host file by url "
    Write-Host " |  --block : List of entries to block"
    Write-Host " |  --unblock : List of entries to unblock"
    Write-Host " |  --outputFile : (Optional) the path for the hosts file to write to. "
    Write-Host " |                 Otherwise will write to the path at '$hostsFilePath'"
    Write-Host " |  -t / --test : Test mode, forces output file to local: './hosts.txt'       " 
    Write-Host " |  -h / --help : Print help"
    Write-Host " |  -l / --list : List host file content"
    Write-Host "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- "
}
Write-Host "Block: $block"
Write-Host "Unblock: $unblock"
Write-Host "OutputFile: $outputFile"
if ("-h" -in $args) {
    _help; 
    exit
}
elseif ("-l" -in $args -or "--list" -in $args) {
    Write-Host "List in args"
    Get-Content $hostsFilePath
    exit
}
elseif ("-t" -in $args -or "--test" -in $args) {
    Write-Host "Output File Empty, Saving to Default"
    $outputFile = "hosts.txt"
}
elseif (!$outputFile) {
    $outputFile = $hostsFilePath
}

function backup_file($outputFile) {
    if (-not (Test-Path -Path $backupDir)) {
        New-Item -Path "$backupDir" -ItemType Directory -Force
    }
    try {
        Copy-Item "$outputFile" "$backupDir" -ErrorAction Stop
    } catch {
        Write-Error "$($_.Exception.Message)"
        Write-Error "Failed to copy output hosts file $outputFile into backups dir $backupDir"
        exit(1);
    }
}
function add_entry($url) {

}
function remove_entry($url) {
}

backup_file($outputFile)
# Out-File $outputFile -Encoding UTF8

foreach ($entry in $block) {
    add_entry($outputFile, $entry)
}
foreach ($entry in $unblock) {
    remove_entry($outputFile, $entry)
}

ipconfig /flushdns