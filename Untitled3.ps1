<#
.SYNOPSIS
    Iterates over a list of Sitecore database and user pairs and prints each one.

.DESCRIPTION
    Defines an array of (database name, username) pairs for Sitecore XP0 databases
    and iterates over them, printing each pair to the console. Useful as a reference
    for enumerating Sitecore database configurations.

.NOTES
    Author: David Cook
    - Update the $data array to match your own database and user configuration.

.EXAMPLE
    .\Untitled3.ps1
    Outputs each database/user pair in the format "DatabaseName-username".
#>
$data = @(("xp0_Core", "coreuser"),
          ("xp0_Master","masteruser"),
          ("xp0_Web","webuser"),
          ("xp0_Messaging","messaginguser"),
          ("xp0_ReferenceData", "referencedatuser"),
          ("xp0_Processing.Pools","poolsuser"),
          ("xp0_Reporting","reportinguser"),
          ("xp0_Processing.Tasks","tasksuser"),
          ("xp0_MarketingAutomation","marketingautomationuser"),
          ("xp0_ExperienceForms","formsuser"),
          ("xp0_EXM.Master","exmmasteruser"),
          ("xp0_Xdb.Collection.ShardMapManager","collectionuser")
         )

foreach($item in $data){
    Write-Host $item[0] + "-" + $item[1]
}