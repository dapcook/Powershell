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
