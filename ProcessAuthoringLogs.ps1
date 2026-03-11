<#
.SYNOPSIS
    Archives authoring log files from a remote CM server into prefix-named subfolders.

.DESCRIPTION
    Iterates over all .txt files in a remote Content Management (CM) log directory.
    For each file, extracts the filename prefix (text before the first dot) and moves
    it into a corresponding subfolder in the local archive directory. Creates the
    destination subfolder if it does not already exist.

.NOTES
    Author: David Cook
    - Update $ArchiveFolder and $CMLogFolder to match your environment.
    - Requires read access to the remote CM log share.

.EXAMPLE
    .\ProcessAuthoringLogs.ps1
    Copies .txt log files from \\ukh-cm01\Logs\KHS-Web into prefix-named subfolders
    under D:\Content Authoring Log Files.
#>
$ArchiveFolder = "D:\Content Authoring Log Files"
$CMLogFolder = "\\ukh-cm01\Logs\KHS-Web"

# Cycle all files in directory
#    create destination folder based on prefix
#    if file does not exist
#       copy file
Get-ChildItem $CMLogFolder -Filter *.txt |
ForEach-Object{
    $fileName = $_.Name
    $filePrefix = $fileName.Split('.')[0]

    $newFolder = $ArchiveFolder + "/" + $filePrefix

    $TestPath = Test-Path -Path $newFolder
    if( -Not $TestPath)
    {
        New-Item -Path $newFolder -ItemType "directory"
    }
    else
    {
        Write-Host "Already exists   " + $newFolder
    }
}