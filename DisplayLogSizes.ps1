#$startFolder = "C:\temp\authoring-logs"
$startFolder = "C:\inetpub\wwwroot\sitecore.khs.local.20190708\App_Data\Logs"
Set-Location -Path $startFolder
$files = Get-ChildItem -Path log*
$logFileStuff = @{}

foreach($file in $files){
    $logDate = $file.Name.Substring(4,8)
    $logSize = $file.Length

    if( $logFileStuff.ContainsKey($logDate) ){
        $logFileStuff[$logDate] += $logSize
    }
    else{
        $logFileStuff.Add($logDate, $logSize)
    }
}

$logFileStuff