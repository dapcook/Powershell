<#
.SYNOPSIS
    PowerShell module that exports a Test-SQLDatabase function for testing SQL Server connectivity.

.DESCRIPTION
    Provides the Test-SQLDatabase function which attempts to open a SqlClient connection to a
    specified SQL Server instance and database. Supports both SQL authentication and Windows
    (integrated) authentication. Measures the time taken to connect and returns a result object
    indicating success or failure, elapsed time, server name, database name, and authentication type.

.PARAMETER Server
    The SQL Server instance name or address.

.PARAMETER Database
    The name of the database to connect to.

.PARAMETER UserName
    SQL login username (used with the SQLAuth parameter set).

.PARAMETER Password
    SQL login password (used with the SQLAuth parameter set).

.PARAMETER UseWindowsAuthentication
    Switch. When specified, uses Windows (integrated) authentication instead of SQL auth.

.NOTES
    Author: David Cook
    Import this module with: Import-Module .\Test-SQLDatabase.psm1
    Then call: Test-SQLDatabase -Server "MyServer" -Database "MyDB" -UserName "user" -Password "pass"

.EXAMPLE
    Import-Module .\Test-SQLDatabase.psm1
    Test-SQLDatabase -Server "localhost" -Database "MyDB" -UserName "sa" -Password "P@ss"
    Tests a SQL Server connection using SQL authentication and returns a result object.

.EXAMPLE
    Import-Module .\Test-SQLDatabase.psm1
    Test-SQLDatabase -Server "localhost" -Database "MyDB" -UseWindowsAuthentication
    Tests a SQL Server connection using the current Windows user's credentials.
#>
function Test-SQLDatabase{
    param(
        [Parameter(Position=0, Mandatory=$True, ValueFromPipeline=$True)] [string] $Server,
        [Parameter(Position=1, Mandatory=$True)] [string] $Database,
        [Parameter(Position=2, Mandatory=$True, ParameterSetName="SQLAuth")] [string] $UserName,
        [Parameter(Position=3, Mandatory=$True, ParameterSetName="SQLAuth")] [string] $Password,
        [Parameter(Position=2, Mandatory=$True, ParameterSetName="WindowsAuth")] [switch] $UseWindowsAuthentication
    )

    # Connect to the database, then immediately close the connection. If an exception occurs, it indicates the connection
    # was not successfull
    Write-Host "Setting up Database Connection"


    $dbConnection = New-Object System.Data.SqlClient.SqlConnection
    if (!$UseWindowsAuthentication){
        $dbConnection.ConnectionString = "Data Source=$Server; uid=$UserName; pwd=$Password; Database=$Database;Integrated Security=False"
        $authentication = "SQL ($Username)"
    }
    else{
        $dbConnection.ConnectionString = "Data Source=$Server; Database=$Database;Integrated Security=True;"
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
        Write-Host $_.Exception.GetType().Fullname, $_.Exception.Message
    }
    Finally{
        # Close the database connection
        $dbConnection.Close()
        # Return the results as an object
        $outputObject = New-Object -Property $Result -TypeName psobject
        Write-Output $outputObject
    }
}
Export-ModuleMember -Function Test-SQLDatabase