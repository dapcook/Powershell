#$startFolder = "C:\temp\authoring-logs"
<#
.SYNOPSIS
    Aggregates and displays Sitecore log file sizes grouped by date.

.DESCRIPTION
    Scans a Sitecore logs directory for files whose names begin with "log",
    extracts the 8-character date portion from each filename, and accumulates
    the total file size for each date. Outputs a hashtable showing total bytes
    per date.

.NOTES
    Author: David Cook
    - Update $startFolder to point to the appropriate Sitecore logs directory.
    - Assumes log filenames follow the Sitecore convention: log.YYYYMMDD.*.txt

.EXAMPLE
    .\DisplayLogSizes.ps1
    Outputs a hashtable of dates and their total log sizes (in bytes).
#>
$startFolder = "C:\inetpub\wwwroot\sitecore.khs.local.20190708\App_Data\Logs"
Set-Location -Path $startFolder
$files = Get-ChildItem -Path log*
$logFileStuff = @{}

foreach($file in $files){
    $logDate = $file.Name.Substring(4,8)
    $logSize = $file.Length

    if( $logFileStuff.ContainsKey($logDate) ){
        $logFileStuff[$logDate] += $logSize
    }
    else{
        $logFileStuff.Add($logDate, $logSize)
    }
}

$logFileStuff