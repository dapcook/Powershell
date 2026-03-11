<#
.SYNOPSIS
    Exports a wildcard certificate from the local machine certificate store to a PFX file.

.DESCRIPTION
    Navigates to the LocalMachine\My certificate store, creates a mapped drive to a
    remote network share, then exports the certificate identified by the specified
    thumbprint to a PFX file on that share, secured with a password.

.NOTES
    Author: David Cook
    - Replace the thumbprint value (C8D542BC...) with the thumbprint of the certificate
      you want to export.
    - Update the password in ConvertTo-SecureString and the network path in New-PSDrive
      to match your environment.
    - Requires access to the Cert:\LocalMachine\My store and the network share.

.EXAMPLE
    .\Export-WildCard-KHS-Certificate.ps1
    Exports the certificate with the specified thumbprint to \\dcook2\temp\mypfx.pfx.
#>
Set-Location Cert:\LocalMachine\My
$mypwd = ConvertTo-SecureString -String "secret" -Force -AsPlainText
New-PSDrive -Name dcook2 -PSProvider FileSystem -Root \\dcook2\temp
Get-ChildItem -Path .\C8D542BCBB9E2C9663D1E9345B09EE033F601E4B | Export-PfxCertificate -FilePath dcook2:\\mypfx.pfx -Password $mypwd
