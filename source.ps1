<#
.SYNOPSIS
    Sets the working directory to the local source code repositories folder.

.DESCRIPTION
    Changes the current PowerShell working directory to the configured source repository
    root path. Intended as a quick navigation shortcut for developer workflows.

.NOTES
    Author: David Cook
    - Update the path in Set-Location to match your local source repository location.

.EXAMPLE
    .\source.ps1
    Changes the working directory to C:\Users\dcook2.KUHA\Source\repos.
#>
Set-Location -Path "C:\Users\dcook2.KUHA\Source\repos"
