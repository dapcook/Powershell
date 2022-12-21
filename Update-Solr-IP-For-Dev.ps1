$hostFile = "c:\windows\system32\drivers\etc\hosts"
$solrServer = "dcook2-solr.mshome.net"
$solrIP = (Test-Connection -ComputerName $solrServer -count 1 | Select IPV4Address)
$line = Get-Content -Path $hostFile | Select-String "dcook2-solr.khs.local" | Select-Object -ExpandProperty Line
$ip = $solrIP.IPV4Address
$newLine = "$ip dcook2-solr.khs.local"

$content = Get-Content $hostFile
$content | ForEach-Object {$_ -replace $line, $newLine} | Set-Content $hostFile

