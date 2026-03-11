# By David Cook
# 09/16/2019
# Web Developer 2 - Marketing Department
<#
.SYNOPSIS
    Splits Sitecore log files into separate subdirectories by log type.

.DESCRIPTION
    Creates subdirectories for each Sitecore log type (Client, Crawling, Exm, log, Owin,
    Publishing, Search, WebDAV, Fxm) within the Sitecore logs directory, then moves all
    matching log files into the corresponding subdirectory. Restores the original working
    directory when complete.

.NOTES
    Author: David Cook
    Date:   09/16/2019
    Role:   Web Developer 2 - Marketing Department
    - Update $PathToSitecore to point to the App_Data\logs directory of your Sitecore instance.
    - Only moves files with a .txt extension matching each log type prefix.

.EXAMPLE
    .\SplitSitecoreLogs.ps1
    Creates type subdirectories and moves all Sitecore log .txt files into them.
#>
$CurrentLocation = (Get-Location).Path

$PathToSitecore = "D:\Sitecore Production\sitecore.khs.local.07292019 - Content Delivery\App_Data\logs"
Set-Location -Path $PathToSitecore

$elements = @("Client", "Crawling", "Exm", "log", "Owin", "Publishing", "Search", "WebDAV", "Fxm")

# Create Directories
foreach($element in $elements)
{
    $FullPath = "$PathToSitecore\$element"
    if(-not (Test-Path -Path $FullPath -PathType Any))
    {
        New-Item -ItemType Directory -Path $FullPath
    }

    $filesToActOn = ".\$element*.txt"
    $fileCount = (Get-ChildItem -Path $filesToActOn).Length
    echo "Files in $filesToActOn = $fileCount"
    if($fileCount -gt 0)
    {
        Move-Item -Path ".\$element*.txt" -Destination ".\$element"
    }
} 

Set-Location -Path $CurrentLocation

