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