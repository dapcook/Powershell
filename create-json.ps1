<#
.SYNOPSIS
    Demonstrates creating a JSON string and converting it to a PowerShell object.

.DESCRIPTION
    Defines a here-string containing a JSON structure, then converts it to a PowerShell
    object using ConvertFrom-Json. Useful as a reference snippet for working with JSON
    data in PowerShell.

.NOTES
    Author: David Cook
    - The JSON in this script is malformed (missing colons after property names in the
      nested objects). Fix the JSON syntax before using ConvertFrom-Json in production.

.EXAMPLE
    .\create-json.ps1
    Converts the $MyJsonVariable here-string from JSON to a PowerShell object.
#>
$MyJsonVariable = @"
{
    "MyList"{
        "Item1"{
            "Name": "AMD Ryzen 5 3600x",
            "Type": "CPU",
            "Price": "$69.99",
            "Where": "Amazon.com",
        }
    }
}
"@

$MyJsonVariable = $MyJsonVariable | ConvertFrom-Json
