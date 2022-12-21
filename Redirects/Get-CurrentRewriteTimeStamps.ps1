function Write-FileInfo{
    param(
        [string]$FileName,
        [string]$Prefix
    )
    $tmp = Get-ChildItem -Path $Filename

    $fno = $tmp.Name
    $fs = $tmp.Length
    $fd = $tmp.LastWriteTime

    $FormatedString = "$Prefix => File => $fno is $fs changed on $fd"

    Write-Host -BackgroundColor Blue -ForegroundColor Green $FormatedString
}

function Write-Line{
    Write-Host "--------------------------------------------------------------------------------------------------"
}

$localkhsPath = "D:\Sitecore Production\Content Delivery\Current\Config\RewriteMaps.config"
$wwRemKhspath = "\\ukh-wwscfront2\temp\Rewrite Maps\KHS\Current"
$suRemKhspath = "\\ukh-suscfront2\temp\Rewrite Maps\KHS\Current"

$wwProdPath = "\\ukh-wwscfront2\wwscfront2\Apps\KHS\KHS-Web\Config"
$suProdPath = "\\ukh-suscfront2\suscfront2\Apps\KHS\KHS-Web\Config"

Write-Host -ForegroundColor Yellow "Current:"
Write-FileInfo -FileName $localkhsPath -Prefix "Local File"
Write-FileInfo -FileName "$wwRemKhspath\RewriteMaps.config" -Prefix "Remote ww"
Write-FileInfo -FileName "$suRemKhspath\RewriteMaps.config" -Prefix "Remote su"
Write-Line -ForegroundColr Yellow "Production:"
Write-FileInfo -FileName "$wwProdPath\RewriteMaps.config" -Prefix "Remote wwProd"
Write-FileInfo -FileName "$suProdPath\RewriteMaps.config" -Prefix "Remote suProd"