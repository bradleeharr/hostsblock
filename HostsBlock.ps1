param (
    [Parameter()]
    [string[]]$block,
    [Parameter()]
    [string[]]$unblock,
    [Parameter()]
    [string]$outputFile,
    [Parameter()]
    [string]$redirect,
    [Alias("h")][switch]$help,
    [Alias("l")][switch]$list,
    [Alias("t")][switch]$test,
    [Alias("c")][switch]$clear
    
)

function _help() {
    Write-Host "HostsBlock.ps1 -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- "
    Write-Host " | A script utility for adding lines to block websites via hosts file / remove entries on host file by url "
    Write-Host " |  --block : List of blocking entries to add to hosts file "
    Write-Host " |            (This will add a comment on these entries ' # Added by HostsBlock.ps1')"
    Write-Host " |  --unblock : List of URL entries to remove from hosts file"
    Write-Host " |  --outputFile : (Optional) the path for the hosts file to write to. "
    Write-Host " |                 Otherwise will write to the path at '$hostsFilePath'"
    Write-Host " |  --redirect : Redirect to IP address (default 127.0.0.1)"

    Write-Host " |  -t / --test : Test mode, forces output file to local: './hosts.txt'       " 
    Write-Host " |  -h / --help : Print help"
    Write-Host " |  -l / --list : List host file content"
    Write-Host " |  -c / --clear : Clear host file entries that have the comment ' # Added by HostsBlock.ps1'"
    Write-Host "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- "
}

$COMMENT = "# Added by HostsBlock.ps1"
function backup_file($backupDir, $outputFile) {
    if (-not (Test-Path -Path $backupDir)) {
        New-Item -Path "$backupDir" -ItemType Directory -Force
    }
    try {
        Copy-Item "$outputFile" "$backupDir" -ErrorAction Stop
    } catch {
        Write-Error "$($_.Exception.Message)"
        Write-Error "Failed to copy output hosts file ($outputFile) into backups dir $backupDir"
        exit(1);
    }
}
function add_entry($outputFile, $url, $redirect) {
    $line = "$redirect      $url    $COMMENT"
    Write-Output "Adding Line: $line"
    $line | Out-File -FilePath $outputFile -Append -Encoding UTF8
}
function remove_entry($outputFile, $url) {
    $hostsLines = Get-Content -Path $outputFile -Encoding UTF8 
    Write-Output "Host Lines: `n$( ($hostsLines | Foreach-Object { "`t$_"}) -join "`n" )"
    Write-Output ""
    $filteredLines = $hostsLines | Where-Object { $_ -notmatch "$url" } 
    $removedLines = $hostsLines | Where-Object { $_ -match "$url" }
    Write-Output "Removing Lines: `n$( ($removedLines | Foreach-Object { "`t$_"}) -join "`n"  )"
    Write-Output "Filtered Lines: `n$( ($filteredLines | Foreach-Object { "`t$_"}) -join "`n" )"
    Write-Output  ""
    $filteredLines | Set-Content -Path "$outputFile.updated" -Encoding UTF8
    mv $outputFile "$outputFile.backup" -Force
    mv "$outputFile.updated" $outputFile -Force
}
function clear_entries($outputFile) {
    $hostsLines = Get-Content -Path $outputFile -Encoding UTF8 
    Write-Output "Host Lines: `n$( ($hostsLines | Foreach-Object { "`t$_"}) -join "`n" )"
    Write-Output
    $filteredLines = $hostsLines | Where-Object { $_ -notmatch "$COMMENT" } 
    Write-Output "Filtered Lines: `n$( ($filteredLines | Foreach-Object { "`t$_"}) -join "`n" )"
    Write-Output ""
    $filteredLines | Set-Content -Path "$outputFile.updated" -Encoding UTF8
    mv $outputFile "$outputFile.backup" -Force
    mv "$outputFile.updated" $outputFile -Force
}

###########################################################################
$hostsFilePath = "C:\Windows\System32\drivers\etc\hosts"
$backupDir = "./backup/($(Get-Date -Format 'yyyy-MM-dd_HH-mm-ss'))"
if ($help) {
    _help; 
    exit
}
if ($list) {
    Write-Host "List in args"
    Get-Content $hostsFilePath
    exit
}

if ($test) {
    Write-Host "Output File Empty, Saving to Default"
    $outputFile = "hosts.txt"
}
elseif (!$outputFile) {
    $outputFile = $hostsFilePath
}
else {
    # validate outputFile
}

if (!$redirect) {
    $redirect = "127.0.0.1"    
}
else {
    # validate redirect
}

Write-Host "Block: $block"
Write-Host "Unblock: $unblock"
Write-Host "OutputFile: $outputFile"
backup_file -BackupDir $backupDir -OutputFile $outputFile
if ($clear) {
    clear_entries -outputFile $outputFile
}

foreach ($url in $block) {
    Write-Host "URL: $url"
    add_entry -OutputFile "$outputFile" -Url "$url"
}
foreach ($url in $unblock) {
    remove_entry -OutputFile "$outputFile" -Url "$url"
}

ipconfig /flushdns
