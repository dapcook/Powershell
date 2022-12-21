$DeployDirectory = "D:\Sitecore Deploy"
$DeployName = "$DeployDirectory\03232021 - GetCare"
$CMProdDeploy = "D:\Sitecore Production\Content Management\Current"
$CDProdDeploy = "D:\Sitecore Production\Content Delivery\Current"
$PageContentDirectory = "C:\Users\dcook2.KUHA\Source\repos\ukhs-kansashealthsystem-sitecore\src\Feature\PageContent\code"
$WebsiteDirectory = "C:\Users\dcook2.KUHA\Source\repos\ukhs-kansashealthsystem-sitecore\src\Project\TUKHS\code"

# Deploy
Copy-Item -Path "$PageContentDirectory\bin\TUKHS.Feature.PageContent.dll" -Destination "$DeployName\bin\"
Copy-Item -Path "$PageContentDirectory\bin\TUKHS.Feature.PageContent.pdb" -Destination "$DeployName\bin"
Copy-Item -Path "$PageContentDirectory\Views\PageContent\GetCare.cshtml" -Destination "$DeployName\Views\PageContent"

#Content Management
Copy-Item -Path "$PageContentDirectory\bin\TUKHS.Feature.PageContent.dll" -Destination "$CMProdDeploy\bin\"
Copy-Item -Path "$PageContentDirectory\bin\TUKHS.Feature.PageContent.pdb" -Destination "$CMProdDeploy\bin"
Copy-Item -Path "$PageContentDirectory\Views\PageContent\GetCare.cshtml" -Destination "$CMProdDeploy\Views\PageContent"

#Content Delivery
Copy-Item -Path "$PageContentDirectory\bin\TUKHS.Feature.PageContent.dll" -Destination "$CDProdDeploy\bin\"
Copy-Item -Path "$PageContentDirectory\bin\TUKHS.Feature.PageContent.pdb" -Destination "$CDProdDeploy\bin"
Copy-Item -Path "$PageContentDirectory\Views\PageContent\GetCare.cshtml" -Destination "$CDProdDeploy\Views\PageContent"
