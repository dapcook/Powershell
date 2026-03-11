<#
.SYNOPSIS
    Checks connectivity to a list of servers and sends a notification email if any are down.

.DESCRIPTION
    Iterates over a predefined list of server names, pinging each one and attempting a TCP
    connection on port 80. For servers that respond, it downloads the HTTP content and records
    the content length. If any server is unreachable or port 80 is not accessible, a notification
    email is sent via SMTP. If all servers are up, results are exported to a CSV file.

.NOTES
    Author: David Cook
    - Update $smtpServer, $servers, $msg.From, $msg.ReplyTo, and $msg.To.Add() with real values
      before running.
    - Requires network access to the target servers and to the SMTP server.

.EXAMPLE
    .\CheckMySites.ps1
    Checks all servers in $servers and either sends an alert email or writes ServerStatus.csv.
#>
$smtpServer = "*******"
$servers = "*******", "*******", "*******"
$collection = $()
$SendEmail = $false

$web = New-Object Net.WebClient
$tcp = New-Object Net.Sockets.TcpClient
$msg = New-Object Net.Mail.MailMessage
$smtp = New-Object Net.Mail.SmtpClient($smtpServer)

$msg.From = "*******"
$msg.ReplyTo = "*******"
$msg.To.Add("*******")
$msg.Subject = "CheckMySites Notification"

foreach($server in $servers)
{ 
    $status = @{ "ServerName" = $server; "TimeStamp" = (Get-Date -f s) }
    if( Test-Connection $server -Count 1 -ea 0 -Quiet)
    {
        $status["Results"] = "Up"

        try{
            $tcp.Connect($server, 80)
        }
        catch{}

        if( $tcp.Connected ){
            $status["Port80 Ok"] = "yes"
            $url = "http://" + $server
            $SiteContent = $web.DownloadString($url)
            $status["ContentLength"] = $SiteContent.Length.ToString()
        }else{
            $status["Port80 Ok"] = "no"
            $status["contentLength"] = 0
            $SendEmail = $true
        }
        $tcp = New-Object Net.Sockets.TcpClient
    }
    else
    {
        $status["Results"] = "Down"
        $SendEmail = $true
    }
    New-Object -TypeName PSObject -Property $status -OutVariable serverStatus
    $collection += $serverStatus
}
if($SendEmail)
{
    $msg.Body = $collection | Out-String
    $smtp.Send($msg)
}
else{
    $collection | Export-Csv -LiteralPath .\ServerStatus.csv -NoTypeInformation
}


