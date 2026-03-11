<#
.SYNOPSIS
    Sends a test email via SMTP and verifies connectivity to the SMTP server.

.DESCRIPTION
    Tests the TCP connection to the configured SMTP server on port 25, then sends a
    simple test email message to verify that the SMTP relay is functioning correctly.

.NOTES
    Author: David Cook
    - Update $SMTPSvr, $from, and $to with valid addresses for your environment.
    - Requires network access to the SMTP server on port 25.

.EXAMPLE
    .\Untitled1.ps1
    Checks SMTP connectivity on port 25 and sends a test email.
#>
$SMTPSvr = ‘smtp.kumed.com'
$from = ‘noreply@kumc.edu’
$to = ‘dcook2@kumc.edu’
#testing connection to server:
Test-NetConnection $SMTPSvr -port 25

Send-MailMessage –From $from –To $to –Subject “Test Email” –Body “Test E-mail (body)” -SmtpServer $SMTPSvr