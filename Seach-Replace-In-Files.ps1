<#
.SYNOPSIS
    Recursively replaces a string value in all .config files under a directory.

.DESCRIPTION
    Searches all .config files under C:\Projects recursively, and replaces any occurrence
    of the Environment key value "Dev" with "Demo". Writes the updated content back to each
    file using Windows-style CRLF line endings.

.NOTES
    Author: David Cook
    - Update the root path (C:\Projects) and the search/replace strings as needed.
    - Overwrites files in place; consider making backups before running.

.EXAMPLE
    .\Seach-Replace-In-Files.ps1
    Replaces 'value="Dev"' with 'value="Demo"' in all .config files under C:\Projects.
#>
Get-ChildItem C:\Projects *.config -recurse |
    Foreach-Object {
        $c = ($_ | Get-Content) 
        $c = $c -replace '<add key="Environment" value="Dev"/>','<add key="Environment" value="Demo"/>'
        [IO.File]::WriteAllText($_.FullName, ($c -join "`r`n"))
    }