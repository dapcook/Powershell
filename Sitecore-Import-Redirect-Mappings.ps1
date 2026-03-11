<#
.SYNOPSIS
    Counts and displays the number of redirect mappings in each rewrite map group.

.DESCRIPTION
    Reads a RewriteMaps.config XML file, iterates over each top-level rewriteMap node,
    and outputs the name and count of child redirect entries for each group. Useful for
    auditing how many redirects are configured per site section.

.NOTES
    Author: David Cook
    - Update $RewriteMap to point to the RewriteMaps.config file you want to inspect.
    - The commented-out $RewriteMap line points to a Cancer site config; uncomment as needed.

.EXAMPLE
    .\Sitecore-Import-Redirect-Mappings.ps1
    Outputs each rewrite map group name and the number of redirect entries it contains.
#>
#$RewriteMap = "c:\inetpub\wwwroot\Cancer.Rewrite\config\RewriteMaps.config"
$RewriteMap = "D:\Sitecore Production\sitecore.khs.local.07292019 - Content Delivery\Config\RewriteMaps.config"

[xml]$maps = Get-Content $RewriteMap

$TopNodes = $maps.SelectSingleNode("rewriteMaps")

foreach($TopNode in $TopNodes.ChildNodes){
    $NodeName = $TopNode.Name.Replace(" Redirects","")

    $MyCount = 0
    foreach($MapNode in $TopNode.ChildNodes){
        $MyCount += 1
    }


    Write-Host $NodeName ": " $MyCount
}



#$nameOfRewrite = $TopNode.Name.Replace(" Redirects","")
#foreach($node in $TopNode.ChildNodes){
#    $MyKey = $node.key
#    $MyValue = $node.value
#}