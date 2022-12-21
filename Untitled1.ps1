$SMTPSvr = ‘smtp.kumed.com'
$from = ‘noreply@kumc.edu’
$to = ‘dcook2@kumc.edu’
#testing connection to server:
Test-NetConnection $SMTPSvr -port 25

Send-MailMessage –From $from –To $to –Subject “Test Email” –Body “Test E-mail (body)” -SmtpServer $SMTPSvr