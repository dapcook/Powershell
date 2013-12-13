# this is the t-sql table that needs to be created.
#CREATE TABLE [dbo].[WebsiteLog](
#	[LogFilename] [varchar](255) NOT NULL,
#	[RowNumber] [int] NOT NULL,
#	[EntryTime] [datetime] NOT NULL,
#	[ServerIpAddress] [varchar](255) NOT NULL,
#	[Method] [varchar](255) NOT NULL,
#	[UriStem] [varchar](255) NOT NULL,
#	[UriQuery] [varchar](255) NULL,
#	[Port] [int] NOT NULL,
#	[Username] [varchar](255) NULL,
#	[ClientIpAddress] [varchar](255) NOT NULL,
#	[UserAgent] [varchar](255) NOT NULL,
#	[Referrer] [varchar](255) NULL,
#	[HttpStatus] [int] NOT NULL,
#	[HttpSubstatus] [int] NOT NULL,
#	[Win32Status] [int] NOT NULL,
#	[TimeTaken] [int] NOT NULL
#) ON [PRIMARY]


$ErrorActionPreference = "Stop"

Import-Module Pscx -EA 0

function ArchiveLogFiles($httpLogPath)
{
    [string] $ArchiveFile = "c:\inetpub\logs\LogFiles\Archives\" + $(get-date -f MMddyyyy) + ".zip"

    if([string]::IsNullOrEmpty($httpLogPath) -eq $true)
    {
        Throw "ArchiveLogFiles:::The log path must be specified."
    }

    Write-Zip -OutputPath $ArchiveFile (dir $httpLogPath -Recurse)
    
}

function ImportLogFiles([string] $httpLogPath)
{
    if([string]::IsNullOrEmpty($httpLogPath) -eq $true)
    {
        Throw "ImportLogFiles:::The log path must be specified."
    }

    [string] $logParser = "${env:ProgramFiles(x86)}" + "\Log Parser 2.2\LogParser.exe"
    
    Write-Host "building query sql"
    
    [string] $query = `
        [string] $query = `
             "select" `
            + " LogFilename " `
            + ", RowNumber" `
            + ", TO_TIMESTAMP(date, time) AS EntryTime" `
            + ", s-ip AS ServerIPAddress" `
            + ", cs-method AS Method" `
            + ", cs-uri-stem AS UriStem" `
            + ", cs-uri-query AS UriQuery" `
            + ", s-port AS Port" `
            + ", cs-username AS Username" `
            + ", c-ip AS ClientIpAddress" `
            + ", cs(User-Agent) AS UserAgent" `
            + ", cs(Referer) AS Referrer" `
            + ", sc-status AS HttpStatus" `
            + ", sc-substatus AS HttpSubstatus" `
            + ", sc-win32-status AS Win32Status" `
            + ", time-taken AS TimeTaken" `
            + " INTO WebsiteLog" `
            + " FROM $httpLogPath\*.log"
            
    #[string] $connectionString = "Driver={SQL Server Native Client 10.0};Server=dcook2-sql;Database=dcook2-sql;User Id:loganalyzer;Password=p@ssw0rd"
    [string] $connectionString = "DRIVER=SQL Server;UID=dcook2;DATABASE=dcook2-web;Trusted_Connection=Yes;SERVER=dcook2-sql"


    [string[]] $parameters = $()

    $parameters += $query
    $parameters += "-i:W3C"
    $parameters += "-o:SQL"
    $parameters += "-oConnString:$connectionString"

    Write-Host "Importing log files to database..."
    & $logParser $parameters

}

function RemoveLogFiles([string] $httpLogPath)
{
    if([string]::IsNullOrEmpty($httpLogPath) -eq $true)
    {
        Throw "RemoveLogFiles:::The log path must be specified"
    }

    Write-Host "Removing log files..."
    Remove-Item ($httpLogPath + "\*.log")
}

function Main
{
    [string] $httpLogPath = "c:\inetpub\logs\LogFiles\w3svc1"
    
    ImportLogFiles $httpLogPath

    ArchiveLogFiles($httpLogPath);

    RemoveLogFiles $httpLogPath

    Write-Host -Fore Green "Successfully imported log files."
}

Main
