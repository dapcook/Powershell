<#
.SYNOPSIS
    Sets the working directory to the KHS-Web application directory on the ww front-end server.

.DESCRIPTION
    Changes the current PowerShell working directory to the KHS-Web application directory
    on the ukh-wwscfront2 (ww) front-end web server. Intended as a quick navigation shortcut
    for deployment and maintenance tasks on the ww server.

.NOTES
    Author: David Cook
    - Requires network access and appropriate permissions to the UNC path.
    - Update the path to match the correct server and application directory.

.EXAMPLE
    .\ww.ps1
    Changes the working directory to \\ukh-wwscfront2\wwscfront2\Apps\KHS\KHS-Web.
#>
Set-Location -Path "\\ukh-wwscfront2\wwscfront2\Apps\KHS\KHS-Web"