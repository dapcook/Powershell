[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] > $null
$template = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText02)

$toastXml = [xml] $template.GetXml()


$toastXml.GetElementsByTagName(“text”)[0].AppendChild($toastXml.CreateTextNode(“Script test”)) > $null

$toastXml.GetElementsByTagName(“text”)[1].AppendChild($toastXml.CreateTextNode(“Customizated notification: ” + [DateTime]::Now.ToShortTimeString())) > $null

 

# Convert back to WinRT type

$xml = New-Object Windows.Data.Xml.Dom.XmlDocument

$xml.LoadXml($toastXml.OuterXml)

$toast = [Windows.UI.Notifications.ToastNotification]::new($xml)

 

# Unique Application id/tag and group

$toast.Tag = “PowerShell UI”

$toast.Group = “PowerShell UI”

#$toast.ExpirationTime = [DateTimeOffset]::Now.AddMinutes(50)

 

# This will suppress the popup/toast, and should only view the toast in the Action Center, but it does not work with PowerShell

#$toast.SuppressPopup = $true

 

# Use this to register an event, but it does not work on PowerShell. This example should display a messagebox if you click the toast in the Action Center

#Register-ObjectEvent -InputObject $toast -EventName Activated -SourceIdentifier Activated_Event -Action {[System.Windows.Forms.MessageBox]::Show(“Clicked”,”Information”);}

 

# Create the toats and show the toast. Make sure to include the AppId

$notifier = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($toast.Tag)

$notifier.Show($toast);
