# Written By David Cook
# 12-21-2022
<#
.SYNOPSIS
    Tests SQL Server database connectivity using provided credentials.

.DESCRIPTION
    Defines a Test-SQLDatabase function that attempts to open a SqlClient connection
    to a specified SQL Server instance and database, using either SQL authentication
    or Windows authentication. Measures the connection time and outputs the result.
    Iterates over a predefined list of database/username pairs and tests each one.

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
    Date:   12-21-2022
    - Update $sqlServer, $password, and $data to match your target databases.
    - Warning: $password is stored in plain text. Consider using secure credential handling.

.EXAMPLE
    .\Test-SQLDatabase-new.ps1
    Tests connectivity to all databases in the $data array against $sqlServer.

.EXAMPLE
    Test-SQLDatabase -Server "localhost" -Database "MyDB" -UserName "sa" -Password "P@ss"
    Tests a single database connection using SQL authentication.
#>
$sqlServer = "localhost"
$password = "Aimee0725!!"
$data = @(("ChuckTVShow","sa"),("ENDOFLINE","ENDOFLINE"))

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
        Write-Host "Successfull Connection" -ForegroundColor Green
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
    if(! ($item[0] -eq "ENDOFLINE"))
    {
        $d = $item[0]
        $p = $item[1]
    
        Test-SQLDatabase -Server $sqlServer -Database $d -UserName $p -Password $password
    }
}

