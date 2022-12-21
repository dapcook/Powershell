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