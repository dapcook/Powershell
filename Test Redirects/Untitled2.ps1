<#
.SYNOPSIS
    Loads a RewriteMaps.config XML file and iterates over a specific rewriteMap node.

.DESCRIPTION
    Changes to the C:\Scripts directory, reads the local RewriteMaps.config file as XML,
    and iterates over the children of the fourth rewriteMap node, printing "test" for each
    entry. Useful as a starting point for processing specific sections of a rewrite config.

.NOTES
    Author: David Cook
    - Update $AppLocation to the directory containing your RewriteMaps.config.
    - Adjust the XPath selector (rewriteMaps[4]) to target the correct rewrite map group.

.EXAMPLE
    .\Untitled2.ps1
    Loads RewriteMaps.config and outputs "test" for each entry in the fourth rewrite map.
#>
$AppLocation = "C:\Scripts"
Set-Location -Path $AppLocation

[xml]$in = Get-Content -Path "RewriteMaps.config"

$data = foreach($name in $in.SelectSingleNode("//rewriteMaps/rewriteMaps[4]")){
   Write-Host "test"
}