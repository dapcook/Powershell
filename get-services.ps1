$a = "<style>"
$a = $a + "TABLE{font-family:sans-serif;font-size:12px;margin:45px;width:480px;text-align:left;border-collapse:collapse;}"
$a = $a + "TH{padding:8px;font-weight:normal;font-size:13px;color:#039;background:#b9c9fe}";
$a = $a + "TD{padding:8px;background:#e8edff;border-top:1px solid #fff;color:#669;}";
$a = $a + "</style>"
Get-Service | Select-Object Status, Name, DisplayName | ConvertTo-HTML -head $a | Out-File tmp.html
Invoke-Expression .\tmp.html
