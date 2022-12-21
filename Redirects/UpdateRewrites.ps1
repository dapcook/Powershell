## 1) Set up variables for directory locations
$archiveLoc = "C:\temp\Rewrite Maps\KHS\Archived"    # Archived Directory
$newFile = "C:\temp\Rewrite Maps\KHS\Current"        # Location of new RewriteMaps.config file
$currentLoc = "C:\inetpub\wwwroot\xp0.sc\config"     # Location that new file gets copied too
$rewriteFile = "RewriteMaps.config"                  # Name of RewriteMap file
$webConfig = "c:\inetpub\wwwroot\xp0.sc\web.config"  # Web.Config file that needs jiggled

# Formatted Current Date
$currentDate = (Get-Date).Month.ToString().PadLeft(2,'0') + 
               (Get-Date).Day.ToString().PadLeft(2,'0') +
               (Get-Date).Year.ToString()

## 2) If Backup Location exists, make a copy of the to the backup location with a datestamp
$todayArcFiles =  $archiveLoc + "\" + $rewriteFile + "." +  $currentDate + ".*"
$numberOfArchiveFilesForToday = (Get-ChildItem -Path $todayArcFiles | Measure-Object).Count
$numberOfArchiveFilesForToday += 1
$newArcFile = $archiveLoc + "\" + $rewriteFile + "." + $currentDate + "." + $numberOfArchiveFilesForToday.ToString().PadLeft(3,'0')
$existingFile = $currentLoc + "\" + $rewriteFile
Copy-Item -Path $existingFile -Destination $newArcFile 

## 3) Copy from the temp location the new file
$newFileFromTemp = $newFile + "\" + $rewriteFile
Copy-Item -Path $newFileFromTemp -Destination $currentLoc

## 4) Touch the web.config 
$(Get-Item $webConfig).LastWriteTime=$(Get-Date)

## 5) Clean Up Variables
Remove-Variable * -Force -ErrorAction SilentlyContinue