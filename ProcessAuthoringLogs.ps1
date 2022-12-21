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
        Write-Host "Does not exist   " + $newFolder
    }
    else
    {
        New-Item -Path $newFolder -ItemType "directory"
    }
}