Set-Location Cert:\LocalMachine\My
$mypwd = ConvertTo-SecureString -String "secret" -Force -AsPlainText
New-PSDrive -Name dcook2 -PSProvider FileSystem -Root \\dcook2\temp
Get-ChildItem -Path .\C8D542BCBB9E2C9663D1E9345B09EE033F601E4B | Export-PfxCertificate -FilePath dcook2:\\mypfx.pfx -Password $mypwd
