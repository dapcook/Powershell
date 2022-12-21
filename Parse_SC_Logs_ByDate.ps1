$files = Get-ChildItem 'C:\temp\authoring-logs' | where {!$_.PsIsContainer}
$targetPath = 'C:\temp\authoring-logs'

foreach($file in $files){
    $year = $file.LastWriteTime.Year.ToString()
    $month = $file.LastWriteTime.Month.ToString()
    $day = $file.LastWriteTime.Day.ToString()

    $directory = $targetPath + "\" + $year + "-" + $month + "\" + $day

    if(!(Test-Path $directory)){
        New-Item $directory -ItemType directory
    }

    $file | Move-Item -Destination $directory
}