$AppLocation = "C:\Scripts"
Set-Location -Path $AppLocation

[xml]$in = Get-Content -Path "RewriteMaps.config"

$data = foreach($name in $in.SelectSingleNode("//rewriteMaps/rewriteMaps[4]")){
   Write-Host "test"
}