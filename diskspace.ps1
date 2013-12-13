#########################################################
#
# Disk space monitoring and reporting script
#
#########################################################
 
$users = "dcook2@kumc.edu" # List of users to email your report to (separate by comma)
$fromemail = "noreply@kumc.edu"
$server = "smtp.kumc.edu" #enter your own SMTP server DNS name / IP address here
$list = $args[0] #This accepts the argument you add to your scheduled task for the list of servers. i.e. list.txt
$computers = get-content $list #grab the names of the servers/computers to check from the list.txt file.
# Set free disk space threshold below in percent (default at 10%)
[decimal]$thresholdspace = 5
 
#assemble together all of the free disk space data from the list of servers and only include it if the percentage free is below the threshold we set above.
$tableFragment= Get-WMIObject  -ComputerName $computers Win32_LogicalDisk `
| select __SERVER, DriveType, VolumeName, Name, @{n='Size (Gb)' ;e={"{0:n2}" -f ($_.size/1gb)}},@{n='FreeSpace (Gb)';e={"{0:n2}" -f ($_.freespace/1gb)}}, @{n='PercentFree';e={"{0:n2}" -f ($_.freespace/$_.size*100)}} `
| Where-Object {$_.DriveType -eq 3} `
| ConvertTo-HTML -fragment
#| Where-Object {$_.DriveType -eq 3 -and [decimal]$_.PercentFree -lt [decimal]$thresholdspace} `
 
# assemble the HTML for our body of the email report.
$HTMLmessage = @"
<font color=""black"" face=""Arial, Verdana"" size=""3"">
<u><b>Disk Space Storage Report</b></u>
<br>
<style type=""text/css"">body{font: .8em ""Lucida Grande"", Tahoma, Arial, Helvetica, sans-serif;}
ol{margin:0;padding: 0 1.5em;}
table{font-family:sans-serif;font-size:12px;width:480px;text-align:left;border-collapse:collapse;}
th{padding:8px;font-weight:normal;font-size:13px;color:#039;background:#b9c9fe}
td{padding:8px;background:#e8edff;border-top:1px solid #fff;color:#669;}
#middle{background-color:#900;}
</style>
<body BGCOLOR=""white"">
$tableFragment
</body>
"@
 
# Set up a regex search and match to look for any <td> tags in our body. These would only be present if the script above found disks below the threshold of free space.
# We use this regex matching method to determine whether or not we should send the email and report.  
$regexsubject = $HTMLmessage
$regex = [regex] '(?im)<td>'
 
# if there was any row at all, send the email
if ($regex.IsMatch($regexsubject)) {
   send-mailmessage -from $fromemail -to $users -subject "Disk Space Monitoring Report" -BodyAsHTML -body $HTMLmessage -priority High -smtpServer $server
}
 
# End of Script
