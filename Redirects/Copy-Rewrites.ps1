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

Write-Host -ForegroundColor Yellow "Copy KHS Rewrite map to web front ends"
Write-Host -ForegroundColor Yellow "Before:"
Write-FileInfo -FileName $localkhsPath -Prefix "Local File"
Write-FileInfo -FileName "$wwRemKhspath\RewriteMaps.config" -Prefix "Remote ww"
Write-FileInfo -FileName "$suRemKhspath\RewriteMaps.config" -Prefix "Remote su"
Copy-Item -Path $localkhsPath -Destination $wwRemKhspath
Copy-Item -Path $localkhsPath -Destination $suRemKhspath
Write-Host -ForegroundColor Yellow "After:"
Write-FileInfo -FileName $localkhsPath -Prefix "Local File"
Write-FileInfo -FileName "$wwRemKhspath\RewriteMaps.config" -Prefix "Remote ww"
Write-FileInfo -FileName "$suRemKhspath\RewriteMaps.config" -Prefix "Remote su"
Write-Line


#$localCancerPath = "C:\Inetpub\wwwroot\Cancer.Rewrite\Config\RewriteMaps.config"
#$wwRemCancerPath = "\\ukh-wwscfront2\temp\Rewrite Maps\Cancer\Current"
#$suRemCancerPath = "\\ukh-suscfront2\temp\Rewrite Maps\cancer\Current"

#Write-Host -ForegroundColor Yellow "Copying Cancer Rewrite Map to web front ends"
#Write-Host -ForegroundColor Yellow "Before:"
#Write-FileInfo -FileName $localCancerPath  -Prefix "Local File"
#Write-FileInfo -FileName "$wwRemCancerPath\RewriteMaps.config" -Prefix "Remote ww"
#Write-FileInfo -FileName "$suRemCancerPath\RewriteMaps.config"  -Prefix "Remote su"
#Copy-Item -Path $localCancerPath -Destination $wwRemCancerPath
#Copy-Item -Path $localCancerPath -Destination $suRemCancerPath
#Write-Host -ForegroundColor Yellow "After:"
#Write-FileInfo -FileName $localCancerPath  -Prefix "Local File"
#Write-FileInfo -FileName "$wwRemCancerPath\RewriteMaps.config" -Prefix "Remote ww"
#Write-FileInfo -FileName "$suRemCancerPath\RewriteMaps.config"  -Prefix "Remote su"
#Write-Line

