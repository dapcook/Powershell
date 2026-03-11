<#
.SYNOPSIS
    Deploys the Find A Researcher feature files to staging and production environments.

.DESCRIPTION
    Copies the compiled DLL and PDB files for the TUKHS.Feature.Import feature to three
    destinations: a local deploy folder (for record-keeping), the Content Management
    production directory, and the Content Delivery production directory.

.NOTES
    Author: David Cook
    Date:   04/13/2021
    - Update $DeployDirectory, $CMProdDeploy, $CDProdDeploy, and $PageContentDirectory
      to match your environment before running.
    - Destination folders must already exist; Copy-Item will fail if they do not.

.EXAMPLE
    .\'04132021 - Find A Researcher.ps1'
    Deploys the Find A Researcher feature binaries to staging and both production Sitecore instances.
#>
$DeployDirectory = "D:\Sitecore Deploy"
$DeployName = "$DeployDirectory\04132021 - Find A Researcher"
$CMProdDeploy = "D:\Sitecore Production\Content Management\Current"
$CDProdDeploy = "D:\Sitecore Production\Content Delivery\Current"
$PageContentDirectory = "C:\Users\dcook2.KUHA\Source\repos\ukhs-kansashealthsystem-sitecore\src\Feature\Import\code\code"
$WebsiteDirectory = "C:\Users\dcook2.KUHA\Source\repos\ukhs-kansashealthsystem-sitecore\src\Project\TUKHS\code"

# Deploy
Copy-Item -Path "$PageContentDirectory\bin\TUKHS.Feature.Import.dll" -Destination "$DeployName\bin\"
Copy-Item -Path "$PageContentDirectory\bin\TUKHS.Feature.PageContent.pdb" -Destination "$DeployName\bin"

#Content Management
Copy-Item -Path "$PageContentDirectory\bin\TUKHS.Feature.Import.dll" -Destination "$CMProdDeploy\bin\"
Copy-Item -Path "$PageContentDirectory\bin\TUKHS.Feature.PageContent.pdb" -Destination "$CMProdDeploy\bin"


