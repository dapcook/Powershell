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