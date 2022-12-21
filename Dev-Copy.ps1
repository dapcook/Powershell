$currentLocation = Get-Location
$destination = "D:\Sitecore Production\sitecore.khs.local.07292019 - Content Delivery"
$source = "C:\Users\dcook2.KUHA\Source\repos\tukhs\src\Feature\PhysicianFinder\code"

Set-Location -Path $source
Write-Output "::: Copying files"
Copy-Item -Path "C:\acsysweb\KansasHealth\kansashealth.resultsbuilder.com\bin\TUKHS.Feature.Physicianfinder.*"  -Destination "$destination\bin"
Copy-Item -Path "C:\acsysweb\KansasHealth\kansashealth.resultsbuilder.com\Views\PhysicianFinder\RequestAppointmentForm.cshtml" -Destination "$destination\Views\PhysicianFinder"
Copy-Item -Path "C:\acsysweb\KansasHealth\kansashealth.resultsbuilder.com\ui\js\app.js" -Destination "$destination\ui\js"

Set-Location $currentLocation