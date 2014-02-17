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


