<#
.SYNOPSIS
    Tests SQL Server database connectivity for a list of Sitecore databases.

.DESCRIPTION
    Defines a Test-SQLDatabase function that attempts to open a SqlClient connection to
    a SQL Server instance using either SQL authentication or Windows authentication.
    Iterates over a predefined list of Sitecore database names and usernames, testing
    connectivity to each one against the configured SQL Server listener.

.PARAMETER Server
    The SQL Server instance name or address.

.PARAMETER Database
    The name of the database to connect to.

.PARAMETER UserName
    SQL login username (used with SQLAuth parameter set).

.PARAMETER Password
    SQL login password (used with SQLAuth parameter set).

.PARAMETER UseWindowsAuthentication
    Switch. When specified, uses Windows (integrated) authentication instead of SQL auth.

.NOTES
    Author: David Cook
    - Update $sqlServer, $password, and $data to match your Sitecore database environment.
    - Warning: Credentials are stored in plain text. Consider using secure credential handling.

.EXAMPLE
    .\Test-SQLDatabase.ps1
    Tests connectivity to all Sitecore databases in the $data array.
#>
#David Cook
$sqlServer = "SQL12LISTENER3"
$password = "S!t3c0r3db"
$data = @(("Sitecore_Core_upg","sitecoredb"),
          ("Sitecore_Master_upg","sitecoredb"),
          ("Sitecore_Weblive_upg","sitecoredb"),
          ("Sitecore_Web_upg","sitecoredb"),
          ("Sitecore_Webintranet_upg","sitecoredb")
         )

function Test-SQLDatabase{
    param(
        [Parameter(Position=0, Mandatory=$True, ValueFromPipeline=$True)] [string] $Server,
        [Parameter(Position=1, Mandatory=$True)] [string] $Database,
        [Parameter(Position=2, Mandatory=$True, ParameterSetName="SQLAuth")] [string] $UserName,
        [Parameter(Position=3, Mandatory=$True, ParameterSetName="SQLAuth")] [string] $Password,
        [Parameter(Position=2, Mandatory=$True, ParameterSetName="WindowsAuth")] [switch] $UseWindowsAuthentication
    )

   
    $dbConnection = New-Object System.Data.SqlClient.SqlConnection
    if (!$UseWindowsAuthentication){
        $dbConnection.ConnectionString = "Data Source=$Server; uid=$UserName; pwd=$Password; Database=$Database;Integrated Security=False"
        Write-Host $dbConnection.ConnectionString
        $authentication = "SQL ($Username)"
    }
    else{
        $dbConnection.ConnectionString = "Data Source=$Server; Database=$Database;Integrated Security=True;"
        Write-Host $dbConnection.ConnectionString
        $authentication = "Windows ($env:USERNAME)"
    }

    try{
        $connectionTime = Measure-Command {$dbConnection.Open()}
        $Result = @{
            Connection = "Successful"
            ElapsedTime = $connectionTime.TotalSeconds
            Server = $Server
            Database = $Database
            User = $authentication
        }
    }
    catch{
        $Result = @{
            Connection = "Failed"
            ElapsedTime = $connectionTime.TotalSeconds
            Server = $Server
            Database = $Database
            User = $authentication
        }
        Write-Host $_.Exception.GetType().Fullname, $_.Exception.Message -ForegroundColor Green
    }
    Finally{
        # Close the database connection
        $dbConnection.Close()
        # Return the results as an object
        $outputObject = New-Object -Property $Result -TypeName psobject
        #Write-Output $outputObject
    }
}

foreach($item in $data){
    $d = $item[0]
    $p = $item[1]

    Test-SQLDatabase -Server $sqlServer -Database $d -UserName $p -Password $password
}

