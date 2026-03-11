<#
.SYNOPSIS
    Demonstrates creating a simple PSCustomObject in PowerShell.

.DESCRIPTION
    Creates a PSCustomObject with Name, Language, and State properties as an example
    of the [PSCustomObject] type accelerator syntax. Useful as a reference snippet.

.NOTES
    Author: David Cook
    This is a basic example/reference script. No output is produced unless $myObject
    is explicitly printed.

.EXAMPLE
    .\TestObjects.ps1
    Creates $myObject with Name='Dave', Language='Powershell', State='Missouri'.
#>
$myObject = [PSCustomObject]@{
    Name = 'Dave'
    Language = 'Powershell'
    State = 'Missouri'
}