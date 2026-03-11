<#
.SYNOPSIS
    Generates a styled HTML table of Windows services and opens it in the browser.

.DESCRIPTION
    Queries all Windows services on the local machine, selects Status, Name, and DisplayName,
    converts the output to an HTML page with inline CSS styling, writes it to a temp HTML file,
    and opens it in the default browser.

.NOTES
    Author: David Cook
    - Writes a temporary file named tmp.html in the current directory.
    - The file is opened using Invoke-Expression which runs the .html file association.

.EXAMPLE
    .\get-services.ps1
    Creates tmp.html with a styled table of all local Windows services and opens it.
#>
$a = "<style>"
$a = $a + "TABLE{font-family:sans-serif;font-size:12px;margin:45px;width:480px;text-align:left;border-collapse:collapse;}"
$a = $a + "TH{padding:8px;font-weight:normal;font-size:13px;color:#039;background:#b9c9fe}";
$a = $a + "TD{padding:8px;background:#e8edff;border-top:1px solid #fff;color:#669;}";
$a = $a + "</style>"
Get-Service | Select-Object Status, Name, DisplayName | ConvertTo-HTML -head $a | Out-File tmp.html
Invoke-Expression .\tmp.html
