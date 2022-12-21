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


