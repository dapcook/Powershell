<#
.SYNOPSIS
    Archives a website folder into a ZIP file at a network location.

.DESCRIPTION
    Creates a mapped network drive to a remote UNC path, removes any existing archive
    ZIP file at that location, compresses the specified website folder using the fastest
    compression level, and then removes the mapped drive.

.NOTES
    Author: David Cook
    - Update $goToLocation, $websiteFolder, and $name to match your environment before running.
    - Requires write access to the network path specified in $goToLocation.

.EXAMPLE
    .\Archive-Folder.ps1
    Archives the folder at $websiteFolder to the ZIP file defined by $goToLocation and $name.
#>
$goToLocation = "\\dcook2-z2\temp\sitecore_archive"
$websiteFolder = "c:\inetpub\wwwroot\xp0.sc"
$name = "xp0.sc.zip"
$ArchiveFile = Join-Path -Path $goToLocation -ChildPath $name

New-PSDrive -Name destination -PSProvider FileSystem -Root $goToLocation

if( Test-Path $ArchiveFile) { Remove-Item $ArchiveFile }

$compress = @{
    Path = $websiteFolder
    DestinationPath = $ArchiveFile
    CompressionLevel = "Fastest"
}

Compress-Archive @compress

Remove-PSDrive -Name destination