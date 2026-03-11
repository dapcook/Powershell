<#
.SYNOPSIS
    Updates token expiration values in the Cognifide PowerShell config file.

.DESCRIPTION
    Creates a backup of the Cognifide.PowerShell.config file, then updates the expiration
    time for both the Console and ISE tokens from 5 minutes ("00:05:00") to 60 minutes
    ("00:60:00"). This extends the session timeout for PowerShell ISE and Console tools
    within Sitecore.

.NOTES
    Author: David Cook
    - Update $path to point to the App_Config\Include directory of your Sitecore instance.
    - A .backup file is created before modification; delete it manually after verifying changes.

.EXAMPLE
    .\Rename-File-Contents.ps1
    Backs up Cognifide.PowerShell.config and updates both token expiration values to 60 minutes.
#>
$path = "C:\inetpub\wwwroot\xp0.sc\App_Config\Include"
$file = "\Cognifide.PowerShell.config"
Set-Location -Path $path

#<token name="Console" expiration="00:05:00" elevationAction="Password"/>
#<token name="ISE" expiration="00:05:00" elevationAction="Password"/>

Copy-Item ".$file" -Destination ".$file.backup"
(Get-Content ".$file" | Out-String) -Replace '<token name="Console" expiration="00:05:00" elevationAction="Password"/>', '<token name="Console" expiration="00:60:00" elevationAction="Password"/>' | Out-File ".$file"
(Get-Content ".$file" | Out-String) -Replace '<token name="ISE" expiration="00:05:00" elevationAction="Password"/>', '<token name="ISE" expiration="00:60:00" elevationAction="Password"/>' | Out-File ".$file"