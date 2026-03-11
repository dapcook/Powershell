<#
.SYNOPSIS
    Imports redirect URL mappings from a CSV file into Sitecore using the Redirect Module.

.DESCRIPTION
    Reads a CSV file containing Original and New URL columns, then creates Sitecore Redirect
    URL items under a specified path in the Sitecore master database. For each row, it
    constructs the Request URL by prepending the base URL to the original path, creates the
    item if it doesn't already exist, and sets the Requested URL and Redirect to Url fields.

.NOTES
    Author: David Cook
    - Must be run from the Sitecore PowerShell ISE or console, as it uses Sitecore-specific
      cmdlets (Get-Item, New-Item with Sitecore paths, and item field editing).
    - Update $csvFile, $importPath, $baseUrl, and $fileBase to match your environment.
    - $fileBase is used as a prefix for generated item names (e.g., "06012022_01").

.EXAMPLE
    .\SC-ImportRewrites.ps1
    Imports all redirect mappings from the configured CSV into the Sitecore Redirect Module.
#>
$importPath = "master:/sitecore/system/Modules/Redirect Module/Redirects/KansashealthSystem"
$csvFile = "C:\Users\DAPCO\OneDrive\My Documents\Redirects CSV Files\Kansashealthsystem Redirects.csv"
$baseUrl = "https://www.kansashealthsystem.com"
$itemCount = 1
$fileBase = "06012022_"
$itemType = "/sitecore/templates/Redirect Module/Redirect Url"

$importList = Import-CSV $csvFile


foreach($row in $importList)
{
    $RequestUrl = $baseUrl + $row.Original
    $newItemName = $fileBase + $itemCount.toString().PadLeft(2,'0')
    Write-Host $newItemName
    
    $itemPath = $importPath + "/" + $newItemName
    $currentItem = Get-Item -Path $itemPath -ErrorAction SilentlyContinue
    if($currentItem -eq $null){
        try{
            $item = New-Item -Path $itemPath -ItemType $itemType
            Write-Host "Item Created: " + $itemPath
        }
        catch{
            Write-Host "Failed to create Item: " + $itemPath
            Write-Host $_.Exception.Message
            continue
        }
        
        $item.Editing.BeginEdit()
        $item["Requested URL"] = $RequestUrl
        $item["Redirect to Url"] = $row.New
        $item.Editing.EndEdit()
    }
    
    $itemCount += 1
}