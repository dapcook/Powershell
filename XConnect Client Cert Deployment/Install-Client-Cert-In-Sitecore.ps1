# By David Cook
# 09/12/2019
# Web Developer 2 - Marketing Department
# Installs the Client Certs for xconnect connectivity
# Intended to be executed on both Content Managment and Content Delivery Servers.
##############################################################################################################
$certificatesLocation = "c:\Certificates"
$certFileName = "$certificatesLocation\65774FBD8146D6D585A4B99403D9E084D4C3DE39.pfx"
$secure_String_Pwd = ConvertTo-SecureString "P@ssw0rd!" -AsPlainText -Force
$sitecoreConfigLocation = "c:\inetpub\wwwroot\xp0.sc\App_Config"

$certificateObject = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2
$certificateObject.Import($certFileName, $secure_String_Pwd, [System.Security.Cryptography.X509Certificates.X509KeyStorageFlags]::DefaultKeySet)
$thumbprint = $certificateObject.Thumbprint

# Install pfx to Cert:\LocalMachine\My and Cert:\LocalMachine\Cert
Import-PfxCertificate -FilePath $certFileName -Password $secure_String_Pwd -CertStoreLocation Cert:\LocalMachine\My
Import-PfxCertificate -FilePath $certFileName -Password $secure_String_Pwd -CertStoreLocation Cert:\LocalMachine\Root

# Modify the connection string file

function Replace-Thumbprint{
    param(
        [string] $connectionString,
        [string] $thumbprint
    )
    
    $f = "FindValue="
    $sl = $connectionString.IndexOf($f) + $f.Length
    $g = $connectionString.Substring($sl, $connectionString.Length - $sl)

    return $connectionString.Replace($g, $thumbprint)
}

$elements = @("xconnect.collection.certificate","xdb.referencedata.client.certificate","xdb.marketingautomation.reporting.client.certificate","xdb.marketingautomation.operations.client.certificate")

Set-Location -Path $sitecoreConfigLocation
$xml = [xml](Get-Content "ConnectionStrings.config")

foreach($element in $elements)
{
    $tmp = $xml.SelectSingleNode("//connectionStrings/add[@name='$element']").Attributes["connectionString"].Value
    $tmp = Replace-Thumbprint -connectionString $tmp -thumbprint $thumbprint
    $xml.SelectSingleNode("//connectionStrings/add[@name='$element']").Attributes["connectionString"].Value = $tmp
}

$xml.Save(" $sitecoreConfigLocation\ConnectionStrings.config")
