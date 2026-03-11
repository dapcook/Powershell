<#
.SYNOPSIS
    Organizes log files in a directory into year-month/day subfolders based on last-write time.

.DESCRIPTION
    Scans a log directory for all non-folder files, then moves each file into a subfolder
    path structured as YYYY-M\D based on the file's last-write date. Creates the target
    folder hierarchy if it does not already exist.

.NOTES
    Author: David Cook
    - Update $targetPath to point to the directory containing the log files.
    - The destination folder path format is: <targetPath>\<year>-<month>\<day>

.EXAMPLE
    .\Parse_SC_Logs_ByDate.ps1
    Moves all log files in C:\temp\authoring-logs into year-month\day subfolders.
#>
$files = Get-ChildItem 'C:\temp\authoring-logs' | where {!$_.PsIsContainer}
$targetPath = 'C:\temp\authoring-logs'

foreach($file in $files){
    $year = $file.LastWriteTime.Year.ToString()
    $month = $file.LastWriteTime.Month.ToString()
    $day = $file.LastWriteTime.Day.ToString()

    $directory = $targetPath + "\" + $year + "-" + $month + "\" + $day

    if(!(Test-Path $directory)){
        New-Item $directory -ItemType directory
    }

    $file | Move-Item -Destination $directory
}