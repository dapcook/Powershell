# Written By David Cook
# 12-21-2022

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

