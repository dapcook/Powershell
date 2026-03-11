<#
.SYNOPSIS
    A collection of useful PowerShell command snippets and examples.

.DESCRIPTION
    Contains annotated one-liners and short code examples for common PowerShell tasks,
    including recursive file search, file content search, removing items recursively,
    formatting output, and bulk file renaming. Intended as a quick reference.

.NOTES
    Author: David Cook
    These are reference examples, not a standalone executable script.

.EXAMPLE
    # Search all directories for a file
    Get-ChildItem . -filter "filename" -recurse | Format-List -property directory, name

.EXAMPLE
    # Recursively search file contents
    Get-ChildItem -Recurse | Select-String -pattern "search term"
#>
# Search all directories for a file
gci . -filter "file to search for" -recurse | format-list -property directory, name

# Removes items recursively
Get-ChildItem -path * -filter *.vss -Recurse | ForEach {$_}{Remove-Item $_.FullName}

# Search file content recursively
Get-ChildItem -Recurse | Select-String -pattern "What do I search for"

# Format lenght field on ls command
ls | Select-Object name, @{Name="Length"; Expression={ "{0:N0}" -f ($_.Length) }

# Rename files and append text 
Get-ChildItem | Rename-Item -NewName {"text in file name" + $_.Name}
