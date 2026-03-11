<#
.SYNOPSIS
    Sets the working directory to the KHS-Web application directory on the su front-end server.

.DESCRIPTION
    Changes the current PowerShell working directory to the KHS-Web application directory
    on the ukh-suscfront2 (su) front-end web server. Intended as a quick navigation shortcut
    for deployment and maintenance tasks on the su server.

.NOTES
    Author: David Cook
    - Requires network access and appropriate permissions to the UNC path.
    - Update the path to match the correct server and application directory.

.EXAMPLE
    .\su.ps1
    Changes the working directory to \\ukh-suscfront2\suscfront2\Apps\KHS\KHS-Web.
#>
Set-Location -Path "\\ukh-suscfront2\suscfront2\Apps\KHS\KHS-Web"
