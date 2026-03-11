<#
.SYNOPSIS
    Moves non-self-signed certificates from the Root store to the CA store.

.DESCRIPTION
    Finds all certificates in Cert:\LocalMachine\root where the Issuer differs from
    the Subject (i.e. certificates not issued by themselves), and moves them to
    Cert:\LocalMachine\CA. This corrects certificate chain issues that can affect
    xConnect and other Sitecore components.

.NOTES
    Author: David Cook
    - Must be run with administrator privileges.
    - Intended to fix xConnect certificate validation issues on Sitecore XP0 environments.

.EXAMPLE
    .\Fix-xConnect.ps1
    Moves all intermediate CA certificates from the Root store to the CA store.
#>
Get-ChildItem Cert:\LocalMachine\root -Recurse | Where-Object {$_.Issuer -ne $_.Subject} | Move-Item -Destination Cert:\LocalMachine\CA