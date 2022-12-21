$PageToTest = "https://www.kansashealthsystem.com/patient-visitor/policies-procedures/hospital-visitor-guidelines2"
$RequestResults = Invoke-WebRequest $PageToTest -MaximumRedirection 0

#$request = [System.Net.WebRequest]::Create($PageToTest)
#$request.AllowAutoRedirect = $false
#$request.GetResponse()