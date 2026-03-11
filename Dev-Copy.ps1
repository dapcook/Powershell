<#
.SYNOPSIS
    Copies specific deployment files from a build output location to a staging destination.

.DESCRIPTION
    Changes to the source repository directory and copies compiled DLL/PDB files,
    Razor view files, and JavaScript assets from the build output paths to a specified
    Content Delivery staging directory. Restores the original working directory when done.

.NOTES
    Author: David Cook
    - Update $destination, $source, and the individual Copy-Item paths to match your environment.
    - Intended for manual deployment of the TUKHS PhysicianFinder feature.

.EXAMPLE
    .\Dev-Copy.ps1
    Copies the PhysicianFinder binaries, views, and JS files to the staging destination.
#>
$currentLocation = Get-Location
$destination = "D:\Sitecore Production\sitecore.khs.local.07292019 - Content Delivery"
$source = "C:\Users\dcook2.KUHA\Source\repos\tukhs\src\Feature\PhysicianFinder\code"

Set-Location -Path $source
Write-Output "::: Copying files"
Copy-Item -Path "C:\acsysweb\KansasHealth\kansashealth.resultsbuilder.com\bin\TUKHS.Feature.Physicianfinder.*"  -Destination "$destination\bin"
Copy-Item -Path "C:\acsysweb\KansasHealth\kansashealth.resultsbuilder.com\Views\PhysicianFinder\RequestAppointmentForm.cshtml" -Destination "$destination\Views\PhysicianFinder"
Copy-Item -Path "C:\acsysweb\KansasHealth\kansashealth.resultsbuilder.com\ui\js\app.js" -Destination "$destination\ui\js"

Set-Location $currentLocation