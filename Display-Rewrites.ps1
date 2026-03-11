<#
.SYNOPSIS
    Displays file information for the Cancer and KHS rewrite map and rule configuration files.

.DESCRIPTION
    Defines helper functions Write-FileInfo and Write-Line, then uses them to display the
    name, size, and last-modified timestamp of the RewriteMaps.config and RewriteRules.config
    files for both the Cancer and KHS Sitecore sites. Checks both the local IIS path and two
    remote front-end server shares (ww and su).

.NOTES
    Author: David Cook
    - Paths are hard-coded to specific server shares. Update them to match your environment.
    - Requires read access to \\ukh-wwscfront2 and \\ukh-suscfront2 shares.

.EXAMPLE
    .\Display-Rewrites.ps1
    Outputs a color-coded list showing each rewrite config file's size and last-write time.
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

Write-Host -ForegroundColor Yellow "Cancer Rewrite Map to web front ends"
Write-Host -ForegroundColor Yellow "Existing:"
Write-FileInfo -FileName "c:\inetpub\wwwroot\Cancer.Rewrite\Config\RewriteMaps.config" -Prefix "Local File"
Write-FileInfo -FileName "\\ukh-wwscfront2\temp\Rewrite Maps\Cancer\Current\RewriteMaps.config" -Prefix "Remote ww"
Write-FileInfo -FileName "\\ukh-suscfront2\temp\Rewrite Maps\Cancer\Current\RewriteMaps.config" -Prefix "Remote su"
Write-FileInfo -FileName "c:\inetpub\wwwroot\Cancer.Rewrite\Config\RewriteRules.config" -Prefix "Local File"
Write-FileInfo -FileName "\\ukh-wwscfront2\temp\Rewrite Maps\Cancer\Current\RewriteRules.config" -Prefix "Remote ww"
Write-FileInfo -FileName "\\ukh-suscfront2\temp\Rewrite Maps\Cancer\Current\RewriteRules.config" -Prefix "Remote su"


Write-Host -ForegroundColor Yellow "KHS Rewrite map to web front ends"
Write-Host -ForegroundColor Yellow "Existing:"
Write-FileInfo -FileName "c:\inetpub\wwwroot\khs.Rewrite\Config\RewriteMaps.config" -Prefix "Local File"
Write-FileInfo -FileName "\\ukh-wwscfront2\temp\Rewrite Maps\khs\Current\RewriteMaps.config" -Prefix "Remote ww"
Write-FileInfo -FileName "\\ukh-suscfront2\temp\Rewrite Maps\khs\Current\RewriteMaps.config" -Prefix "Remote su"
Write-FileInfo -FileName "c:\inetpub\wwwroot\khs.Rewrite\Config\RewriteRules.config" -Prefix "Local File"
Write-FileInfo -FileName "\\ukh-wwscfront2\temp\Rewrite Maps\khs\Current\RewriteRules.config" -Prefix "Remote ww"
Write-FileInfo -FileName "\\ukh-suscfront2\temp\Rewrite Maps\khs\Current\RewriteRules.config" -Prefix "Remote su"
