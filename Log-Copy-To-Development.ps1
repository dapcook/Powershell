New-PSDrive -Name dcook2 -PSProvider FileSystem -Root \\dcook2-z2\temp\authoring-logs
Set-Location -Path dcook2:
Copy-Item -Path c:\inetpub\wwwroot\authoring.khs.local\app_Data\Log.* -Destination .
Set-Location -Path Master:
Remove-PSDrive -Name dcook2