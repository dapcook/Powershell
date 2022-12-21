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
