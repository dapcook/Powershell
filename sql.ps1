<#
.SYNOPSIS
    Sets the working directory to the SQL Server data directory.

.DESCRIPTION
    Changes the current PowerShell working directory to the SQL Server MSSQL data folder.
    Intended as a quick navigation shortcut for SQL Server administration tasks.

.NOTES
    Author: David Cook
    - Update the path to match the SQL Server version and instance on your machine.

.EXAMPLE
    .\sql.ps1
    Changes the working directory to the MSSQL data folder.
#>
Set-Location -Path "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL"