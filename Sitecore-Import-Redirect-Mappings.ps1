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