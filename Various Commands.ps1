# Search all directories for a file
gci . -filter "file to search for" -recurse | format-list -property directory, name

# Removes items recursively
Get-ChildItem -path * -filter *.vss -Recurse | ForEach {$_}{Remove-Item $_.FullName}

# Search file content recursively
Get-ChildItem -Recurse | Select-String -pattern "What do I search for"

# Format lenght field on ls command
ls | Select-Object name, @{Name="Length"; Expression={ "{0:N0}" -f ($_.Length) }
