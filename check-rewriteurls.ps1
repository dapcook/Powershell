$csvFile = "C:\Users\DAPCO\OneDrive\My Documents\Redirects CSV Files\Kansashealthsystem Redirects.csv"
$NumberOfBadUrls = 0
$importList = Import-CSV $csvFile

foreach($row in $importList)
{
    Write-Host $row.New

    
}