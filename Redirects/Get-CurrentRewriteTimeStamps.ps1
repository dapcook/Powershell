<#
.SYNOPSIS
    Displays current timestamps and sizes for KHS rewrite config files across all environments.

.DESCRIPTION
    Defines helper functions Write-FileInfo and Write-Line, then displays the name, size,
    and last-modified time of the RewriteMaps.config file for the local Sitecore instance,
    the ww and su staging temp locations, and the ww and su production config directories.
    Useful for confirming which version of the rewrite config is deployed to each environment.

.NOTES
    Author: David Cook
    - Update the path variables to match your environment.
    - Requires read access to all listed network paths.

.EXAMPLE
    .\Get-CurrentRewriteTimeStamps.ps1
    Outputs file info for all KHS rewrite config locations (local, ww, su, and production).
#>
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