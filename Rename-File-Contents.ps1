$path = "C:\inetpub\wwwroot\xp0.sc\App_Config\Include"
$file = "\Cognifide.PowerShell.config"
Set-Location -Path $path

#<token name="Console" expiration="00:05:00" elevationAction="Password"/>
#<token name="ISE" expiration="00:05:00" elevationAction="Password"/>

Copy-Item ".$file" -Destination ".$file.backup"
(Get-Content ".$file" | Out-String) -Replace '<token name="Console" expiration="00:05:00" elevationAction="Password"/>', '<token name="Console" expiration="00:60:00" elevationAction="Password"/>' | Out-File ".$file"
(Get-Content ".$file" | Out-String) -Replace '<token name="ISE" expiration="00:05:00" elevationAction="Password"/>', '<token name="ISE" expiration="00:60:00" elevationAction="Password"/>' | Out-File ".$file"