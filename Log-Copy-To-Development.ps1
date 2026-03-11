<#
.SYNOPSIS
    Copies Sitecore authoring log files from a remote server to a local development directory.

.DESCRIPTION
    Maps a network drive to a remote UNC path where authoring log files are stored,
    copies all files matching "Log.*" from the local IIS authoring site to that mapped
    drive, and then removes the mapped drive.

.NOTES
    Author: David Cook
    - Update the UNC path in New-PSDrive and the Copy-Item source path to match your environment.
    - Requires read access to the local authoring site logs and write access to the remote share.

.EXAMPLE
    .\Log-Copy-To-Development.ps1
    Copies authoring log files to the remote development log directory.
#>
New-PSDrive -Name dcook2 -PSProvider FileSystem -Root \\dcook2-z2\temp\authoring-logs
Set-Location -Path dcook2:
Copy-Item -Path c:\inetpub\wwwroot\authoring.khs.local\app_Data\Log.* -Destination .
Set-Location -Path Master:
Remove-PSDrive -Name dcook2