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