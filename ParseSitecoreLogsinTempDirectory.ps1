$processDirectories = @("C:\temp\uatauthoring-logs", "C:\temp\authoring-logs")

foreach($pathToParse in $processDirectories){
   
    Set-Location -Path $pathToParse
    Echo "::: $pathToParse"
    $files = Get-ChildItem -Path $pathToParse | where { ! $_.PSIsContainer }
    if($files -ne $null){
        foreach($file in $files){

           $dirOutput = $file.Name.Substring(4,8)

           if( (Test-Path ".\$dirOutput" -PathType Container) -eq $false ){
              Echo ":::::: Dir does not exist .\$dirOutput"
              New-Item -Path ".\$dirOutput" -ItemType "directory"
           }
       
           Echo ":::::::: Copying file .\$file"

           Move-Item -Path ".\$file" -Destination ".\$dirOutput" -Force 
        }
    }

   
}





