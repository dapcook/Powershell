<#
.SYNOPSIS
    Updates the hosts file with the current IP address of the Solr development server.

.DESCRIPTION
    Resolves the IPv4 address of the remote Solr server (dcook2-solr.mshome.net), finds
    the existing hosts file entry for dcook2-solr.khs.local, and replaces it with the
    newly resolved IP address. Useful for keeping the local hosts file in sync when the
    Solr VM's IP address changes.

.NOTES
    Author: David Cook
    - Must be run as Administrator to modify the hosts file.
    - Update $solrServer to match your Solr VM hostname.

.EXAMPLE
    .\Update-Solr-IP-For-Dev.ps1
    Resolves the Solr server IP and updates the corresponding hosts file entry.
#>
$hostFile = "c:\windows\system32\drivers\etc\hosts"
$solrServer = "dcook2-solr.mshome.net"
$solrIP = (Test-Connection -ComputerName $solrServer -count 1 | Select IPV4Address)
$line = Get-Content -Path $hostFile | Select-String "dcook2-solr.khs.local" | Select-Object -ExpandProperty Line
$ip = $solrIP.IPV4Address
$newLine = "$ip dcook2-solr.khs.local"

$content = Get-Content $hostFile
$content | ForEach-Object {$_ -replace $line, $newLine} | Set-Content $hostFile

