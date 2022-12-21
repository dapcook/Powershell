$DeployDirectory = "D:\Sitecore Deploy"
$DeployName = "$DeployDirectory\03112021 - Corp Health Form"
$CMProdDeploy = "D:\Sitecore Production\Content Management\Current"
$CDProdDeploy = "D:\Sitecore Production\Content Delivery\Current"
$PageContentDirectory = "C:\Users\dcook2.KUHA\Source\repos\ukhs-kansashealthsystem-sitecore\src\Feature\PageContent\code"
$WebsiteDirectory = "C:\Users\dcook2.KUHA\Source\repos\ukhs-kansashealthsystem-sitecore\src\Project\TUKHS\code"

# Deploy
Copy-Item -Path "$PageContentDirectory\bin\TUKHS.Feature.PageContent.dll" -Destination "$DeployName\bin\"
Copy-Item -Path "$PageContentDirectory\bin\TUKHS.Feature.PageContent.pdb" -Destination "$DeployName\bin"
Copy-Item -Path "$PageContentDirectory\Views\PageContent\CorperateHealthForm.cshtml" -Destination "$DeployName\Views\PageContent"
Copy-Item -Path "$WebsiteDirectory\ui\css\main.css" -Destination "$DeployName\ui\css\"
Copy-Item -Path "$WebsiteDirectory\ui\css\main.css.map" -Destination "$DeployName\ui\css\"
Copy-Item -Path "$WebsiteDirectory\ui\js\app.js" -Destination "$DeployName\ui\js\"
Copy-Item -Path "$WebsiteDirectory\ui\js\app.js.map" -Destination "$DeployName\ui\js\"

#Content Management
Copy-Item -Path "$PageContentDirectory\bin\TUKHS.Feature.PageContent.dll" -Destination "$CMProdDeploy\bin\"
Copy-Item -Path "$PageContentDirectory\bin\TUKHS.Feature.PageContent.pdb" -Destination "$CMProdDeploy\bin"
Copy-Item -Path "$PageContentDirectory\Views\PageContent\CorperateHealthForm.cshtml" -Destination "$CMProdDeploy\Views\PageContent"
Copy-Item -Path "$WebsiteDirectory\ui\css\main.css" -Destination "$CMProdDeploy\ui\css\"
Copy-Item -Path "$WebsiteDirectory\ui\css\main.css.map" -Destination "$CMProdDeploy\ui\css\"
Copy-Item -Path "$WebsiteDirectory\ui\js\app.js" -Destination "$CMProdDeploy\ui\js\"
Copy-Item -Path "$WebsiteDirectory\ui\js\app.js.map" -Destination "$CMProdDeploy\ui\css\"

#Content Delivery
Copy-Item -Path "$PageContentDirectory\bin\TUKHS.Feature.PageContent.dll" -Destination "$CDProdDeploy\bin\"
Copy-Item -Path "$PageContentDirectory\bin\TUKHS.Feature.PageContent.pdb" -Destination "$CDProdDeploy\bin"
Copy-Item -Path "$PageContentDirectory\Views\PageContent\CorperateHealthForm.cshtml" -Destination "$CDProdDeploy\Views\PageContent"
Copy-Item -Path "$WebsiteDirectory\ui\css\main.css" -Destination "$CDProdDeploy\ui\css\"
Copy-Item -Path "$WebsiteDirectory\ui\css\main.css.map" -Destination "$CDProdDeploy\ui\css\"
Copy-Item -Path "$WebsiteDirectory\ui\js\app.js" -Destination "$CDProdDeploy\ui\js\"
Copy-Item -Path "$WebsiteDirectory\ui\js\app.js.map" -Destination "$CDProdDeploy\ui\css\"