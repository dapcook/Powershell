<#
.SYNOPSIS
    Organizes Sitecore log files in multiple temp directories into date-named subfolders.

.DESCRIPTION
    Iterates over a list of directories (UAT authoring logs and authoring logs), and for
    each directory, moves every non-folder file into a subfolder whose name is derived
    from characters 4–11 of the filename (the date portion of Sitecore log filenames).
    Creates the subfolder if it does not already exist.

.NOTES
    Author: David Cook
    - Update $processDirectories to include the paths relevant to your environment.
    - Assumes Sitecore log filenames follow the convention: log.YYYYMMDD.*.txt

.EXAMPLE
    .\ParseSitecoreLogsinTempDirectory.ps1
    Moves all log files in the configured directories into YYYYMMDD-named subfolders.
#>
$processDirectories = @("C:\temp\uatauthoring-logs", "C:\temp\authoring-logs")

foreach($pathToParse in $processDirectories){
   
    Set-Location -Path $pathToParse
    Echo "::: $pathToParse"
    $files = Get-ChildItem -Path $pathToParse | where { ! $_.PSIsContainer }
    if($files -ne $null){
        foreach($file in $files){

           $dirOutput = $file.Name.Substring(4,8)

           if( (Test-Path ".\$dirOutput" -PathType Container) -eq $false ){
              Echo ":::::: Dir does not exist .\$dirOutput"
              New-Item -Path ".\$dirOutput" -ItemType "directory"
           }
       
           Echo ":::::::: Copying file .\$file"

           Move-Item -Path ".\$file" -Destination ".\$dirOutput" -Force 
        }
    }

   
}





