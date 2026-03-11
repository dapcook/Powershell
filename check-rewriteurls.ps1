<#
.SYNOPSIS
    Reads a CSV of redirect URLs and outputs the destination (New) URL for each row.

.DESCRIPTION
    Imports a CSV file containing redirect mapping data and iterates over each row,
    printing the New URL value to the console. Intended as a utility to quickly preview
    the destination URLs in a redirect CSV before importing them into Sitecore.

.NOTES
    Author: David Cook
    - Update $csvFile to point to your redirect mappings CSV file.
    - The CSV is expected to have at minimum a "New" column with destination URLs.

.EXAMPLE
    .\check-rewriteurls.ps1
    Prints the New URL for every row in the configured redirect CSV file.
#>
$csvFile = "C:\Users\DAPCO\OneDrive\My Documents\Redirects CSV Files\Kansashealthsystem Redirects.csv"
$NumberOfBadUrls = 0
$importList = Import-CSV $csvFile

foreach($row in $importList)
{
    Write-Host $row.New

    
}