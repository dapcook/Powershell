<#
.SYNOPSIS
    Creates a self-signed SSL certificate for Sitecore xConnect and configures the AppSettings.config.

.DESCRIPTION
    Generates a new self-signed SSL certificate, exports it to a PFX file, installs it in the
    Trusted Root Certification Authorities store, and updates the xConnect AppSettings.config with
    the new certificate thumbprint. Also performs a test HTTP request to the xConnect endpoint to
    verify the configuration.

.NOTES
    Author: David Cook
    - Must be run as Administrator to install certificates and modify IIS/xConnect config files.
    - Update $certificatesLocation, $appConfigLocation, and $xConnectURI to match your environment.
    - The password "P@ssw0rd!" is hard-coded; change it to a secure value before use.
    - The certificate is valid for 60 months from the date of creation.

.EXAMPLE
    .\Create-Client-Cert-For-Xconnect.ps1
    Creates a new self-signed cert, installs it, updates AppSettings.config, and tests xConnect.
#>
$secure_String_Pwd = ConvertTo-SecureString "P@ssw0rd!" -AsPlainText -Force
$certificatesLocation = "c:\Certificates"
$appConfigLocation = "c:\inetpub\wwwroot\xp0.xconnect\App_Config"
$xConnectURI = "https://xp0.khs.local"

# Check to see if certificate Path exists, if not create it before changing to that directory
$PathExists = Test-Path $certificatesLocation -PathType Any
if(-not $PathExists )
{
   New-Item -ItemType Directory -Path $certificatesLocation
}
Set-Location -Path $certificatesLocation

# Create Self Signed Certificate
$thumbprint = (New-SelfSignedCertificate `
  -Subject "CN=$env:COMPUTERNAME @ Sitecore, Inc." `
  -Type SSLServerAuthentication `
  -NotAfter (Get-Date).AddMonths(60) `
  -FriendlyName "$env:USERNAME Certificate").Thumbprint

$newCertFile = "$certificatesLocation\$thumbprint.pfx"

Export-PfxCertificate `
 -cert Cert:\LocalMachine\My\$thumbprint `
 -FilePath "$newCertFile" `
 -Password $secure_String_Pwd

# Install new cert to Trusted Root Certification Authorities
Import-PfxCertificate -FilePath $newCertFile -Password $secure_String_Pwd -CertStoreLocation Cert:\LocalMachine\Root

# Modify the xconnect config file
Set-Location -Path $appConfigLocation
$xml = [xml](Get-Content "AppSettings.config")
$xml.SelectSingleNode("//appSettings/add[@key='validateCertificateThumbprint']").Value = $thumbprint
$xml.Save("$appConfigLocation\AppSettings.config")


# Test the xconnect server
$response = Invoke-WebRequest -Uri $xConnectURI
$response.Content


