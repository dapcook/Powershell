Powershell
==========

My collection of useful PowerShell scripts for Sitecore administration, IIS log management,
certificate management, deployment automation, and general development utilities.

All scripts use [PowerShell comment-based help](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help).
Run `Get-Help .\ScriptName.ps1 -Full` for complete documentation on any script.

---

## Directory Structure

```
.
├── Root scripts            # General-purpose and Sitecore utility scripts
├── Deploys/                # One-off deployment scripts for specific feature releases
├── Redirects/              # Scripts for managing KHS URL rewrite map deployments
├── Test Redirects/         # Scripts for testing and inspecting URL redirect behavior
└── XConnect Client Cert Deployment/   # Scripts for xConnect SSL certificate management
```

---

## Root Scripts

| Script | Description |
|--------|-------------|
| `Archive-Folder.ps1` | Archives a website folder to a ZIP file on a network share. Creates a mapped drive, removes any prior archive, compresses the folder, then cleans up. |
| `check-rewriteurls.ps1` | Reads a redirect CSV file and outputs the destination (New) URL for each row — useful for previewing redirect targets before importing into Sitecore. |
| `CheckMySites.ps1` | Pings a list of servers and checks port 80 connectivity. Sends a notification email if any server is unreachable; otherwise exports results to CSV. |
| `create-json.ps1` | Reference snippet demonstrating how to define a JSON here-string and convert it to a PowerShell object with `ConvertFrom-Json`. |
| `Dev-Copy.ps1` | Copies compiled DLLs, Razor views, and JavaScript assets from build output to a Sitecore Content Delivery staging directory. |
| `diskspace.ps1` | Queries disk space on a list of servers via WMI and emails an HTML report. Accepts a server list file as a command-line argument. |
| `Display-Rewrites.ps1` | Displays name, size, and last-modified timestamp for the Cancer and KHS rewrite config files across local and remote front-end server paths. |
| `DisplayLogSizes.ps1` | Scans a Sitecore logs directory and outputs a hashtable of total log file sizes grouped by date (extracted from filenames). |
| `Export-WildCard-KHS-Certificate.ps1` | Exports a certificate from `Cert:\LocalMachine\My` to a PFX file on a network share using a specified thumbprint. |
| `Fix-xConnect.ps1` | Moves all non-self-signed certificates from the Root store to the CA store — fixes certificate chain issues in Sitecore XP0 xConnect environments. |
| `get-services.ps1` | Generates a styled HTML table of all local Windows services and opens it in the default browser. |
| `Get-UrlRedirections.ps1` | Defines `Get-UrlRedirections`: follows HTTP redirects for a URL and returns either the final destination or the full redirection chain (with `-Enumerate`). |
| `Log-Copy-To-Development.ps1` | Maps a network drive and copies Sitecore authoring log files from the local IIS site to a remote development log directory. |
| `Parse_SC_Logs_ByDate.ps1` | Moves log files from a directory into `YYYY-M\D` subfolders based on each file's last-write date. |
| `ParseIISLogs.ps1` | Provides functions to archive, import (via Log Parser 2.2), and delete IIS W3C log files. Imports logs into a SQL Server `WebsiteLog` table. |
| `ParseSitecoreLogsinTempDirectory.ps1` | Moves Sitecore log files in multiple temp directories into date-named subfolders (date extracted from the filename). |
| `ProcessAuthoringLogs.ps1` | Copies authoring log `.txt` files from a remote CM server share into prefix-named archive subfolders. |
| `Rename-File-Contents.ps1` | Backs up `Cognifide.PowerShell.config` and updates Console/ISE token expiration from 5 to 60 minutes. |
| `SC-ImportRewrites.ps1` | Imports redirect URL mappings from a CSV file into the Sitecore Redirect Module using Sitecore PowerShell Extensions cmdlets. |
| `Seach-Replace-In-Files.ps1` | Recursively finds all `.config` files under `C:\Projects` and replaces the Environment key value `Dev` with `Demo`. |
| `Sitecore-Import-Redirect-Mappings.ps1` | Reads a `RewriteMaps.config` XML file and outputs the name and count of redirect entries for each rewrite map group. |
| `source.ps1` | Navigation shortcut — changes the working directory to the local source code repositories root. |
| `SplitSitecoreLogs.ps1` | Creates type-named subdirectories (Client, Crawling, Exm, log, Owin, Publishing, Search, WebDAV, Fxm) and moves matching Sitecore log files into them. |
| `sql.ps1` | Navigation shortcut — changes the working directory to the SQL Server MSSQL data folder. |
| `su.ps1` | Navigation shortcut — changes the working directory to the KHS-Web app directory on the su (ukh-suscfront2) front-end server. |
| `Test-SQLDatabase-new.ps1` | Tests SQL Server connectivity for a list of database/username pairs using SQL or Windows authentication. Measures connection time and reports results. |
| `Test-SQLDatabase.ps1` | Tests connectivity to a list of Sitecore databases on a SQL Server listener using SQL authentication. |
| `Test-SQLDatabase.psm1` | Reusable module exporting `Test-SQLDatabase` — connects to a SQL Server database, measures connection time, and returns a result object. |
| `Test-XP0-XConnect.ps1` | Sends a GET request to `https://xp0.khs.local` and prints the response — quick connectivity check for a local Sitecore xConnect instance. |
| `TestObjects.ps1` | Reference snippet — demonstrates creating a `[PSCustomObject]` with Name, Language, and State properties. |
| `toast_notification.ps1` | Displays a Windows 10+ toast notification with a custom title and the current time using the Windows Runtime API. |
| `Untitled1.ps1` | Verifies SMTP connectivity on port 25 and sends a test email via `Send-MailMessage`. |
| `Untitled2.ps1` | Reference snippet — demonstrates creating a PSObject and adding multiple `NoteProperty` members with `Add-Member`. |
| `Untitled3.ps1` | Iterates over an array of Sitecore XP0 database/user name pairs and prints each pair to the console. |
| `Update-Solr-IP-For-Dev.ps1` | Resolves the current IP of the Solr dev VM and updates the matching entry in the Windows hosts file. Must be run as Administrator. |
| `Various Commands.ps1` | A reference collection of useful PowerShell one-liners: recursive file search, content search, bulk rename, and formatted output. |
| `WeatherFunctions.psm` | Defines `Get-Weather` — queries the CDYNE Weather SOAP web service and returns current weather data for a given US ZIP code. |
| `ww.ps1` | Navigation shortcut — changes the working directory to the KHS-Web app directory on the ww (ukh-wwscfront2) front-end server. |

---

## Deploys/

One-off deployment scripts for specific Sitecore feature releases. Each script copies
compiled binaries, views, and assets to staging and production Content Management (CM)
and Content Delivery (CD) directories.

| Script | Description |
|--------|-------------|
| `03112021-CorpHealth.ps1` | Deploys the Corporate Health Form feature (DLLs, Razor view, CSS, JS) to staging, CM, and CD. |
| `03232021-GetCare.ps1` | Deploys the GetCare feature (DLLs and Razor view) to staging, CM, and CD. |
| `04132021 - Find A Researcher.ps1` | Deploys the Find A Researcher feature (DLLs) to staging, CM, and CD. |

---

## Redirects/

Scripts for managing the deployment lifecycle of KHS URL rewrite map configuration files
(`RewriteMaps.config`) across local Sitecore and remote IIS front-end servers.

| Script | Description |
|--------|-------------|
| `Copy-Rewrites.ps1` | Copies the local KHS `RewriteMaps.config` to the ww and su front-end server temp directories. Shows before/after file metadata. |
| `Get-CurrentRewriteTimeStamps.ps1` | Displays current file info (name, size, timestamp) for the KHS rewrite config across local, staging, and production paths. |
| `Send-KHS-Rewrites-Email.ps1` | Sends an HTML notification email to the HITS Service Desk with instructions to deploy the updated rewrite map to production IIS servers. |
| `UpdateRewrites.ps1` | Archives the current `RewriteMaps.config`, deploys the updated file from staging, and touches `web.config` to trigger an IIS reload. |

---

## Test Redirects/

Scripts for testing and inspecting URL redirect behavior against live sites.

| Script | Description |
|--------|-------------|
| `Get-UrlRedirection.ps1` | Defines `Get-UrlRedirections` and calls it on a sample URL — follows HTTP 3xx redirects and returns either the final URL or the full chain. |
| `Untitled2.ps1` | Loads a `RewriteMaps.config` XML file and iterates over entries in a specific rewrite map node. |

---

## XConnect Client Cert Deployment/

Scripts for creating and deploying SSL client certificates used by Sitecore xConnect.

| Script | Description |
|--------|-------------|
| `Create-Client-Cert-For-Xconnect.ps1` | Creates a self-signed SSL certificate, exports it to PFX, installs it in the Trusted Root store, and updates `AppSettings.config` with the new thumbprint. |
| `Install-Client-Cert-In-Sitecore.ps1` | Imports an xConnect client PFX certificate into the local machine stores and updates the four xConnect connection string entries in `ConnectionStrings.config`. |

---

## Notes

- Most scripts contain hard-coded paths, server names, and credentials specific to the
  original development environment. **Update these values before running in your own environment.**
- Scripts that modify certificates, hosts files, or IIS configuration **require Administrator privileges**.
- Scripts that use Sitecore-specific cmdlets (`Get-Item`, `New-Item` with Sitecore paths) must be
  run from within the **Sitecore PowerShell Extensions** ISE or console.
- `ParseIISLogs.ps1` requires **Log Parser 2.2** and the **PSCX** PowerShell module.
- `Test-SQLDatabase.psm1` can be imported with `Import-Module .\Test-SQLDatabase.psm1` and used
  independently of the `.ps1` scripts.

