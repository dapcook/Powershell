$ccUsers = "dcook2@kumc.edu", "jcarpenter2@kumc.edu", "mfrancis3@kumc.edu, bmedlin@kumc.edu", "ccasteel2@kumc.edu", "eray2@kumc.edu", "lleesmann@kumc.edu", "cpoindexter@kumc.edu"

$HITSEmail = "HITS_ServiceDesk@kumc.edu"

## Test
#
#
#$ccUsers = "dcook2@kumc.edu"
#$HITSEmail = "dcook2@kumc.edu"

$Header = "Create a ticket for DMS Sitecore</br></br>"

$khsBody =
"I updated the rewrite map for the KansasHealthSystem site</br>
<ul>
    <li>\\ukh-wwscfront2\temp\Rewrite Maps\khs\Current</li>
    <li>\\ukh-suscfront2\temp\Rewrite Maps\khs\Current</li>
</ul>
<p>
Just copy the RewriteMaps.config to c:\inetpub\wwwroot\www.khs.local.20190708\configs
</p>
<p>
After the file is copied, the file c:\inetpub\wwwroot\www.khs.local.20190708\web.config needs to be opened and a space added to the end of a line and saved so it forces IIS to reload.
</p>
"

$BodyHtml = "$Header $khsBody"
$Subject = "KansasHealthSystem rewrites have changed"


$paramHash = @{
  To = $HITSEmail
  Cc = $ccUsers
  from = "dcook2@kumc.edu"
  BodyAsHtml = $true
  Body = $BodyHtml
  Subject = $Subject
  SmtpServer = "smtp.kumc.edu"
}

Send-MailMessage @paramHash -WarningAction Ignore