# By David Cook
# 09/16/2019
# Web Developer 2 - Marketing Department
# Splits out the log files in Sitecore and modifies config files to write logs to 
##############################################################################################################

# seperate directories

# Client | Crawling | Exm | log | Owin | Publishing | Search | WebDave

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

