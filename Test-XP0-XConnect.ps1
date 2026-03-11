<#
.SYNOPSIS
    Tests HTTP connectivity to a local Sitecore XP0 xConnect instance.

.DESCRIPTION
    Sends an HTTP GET request to the local xConnect server (https://xp0.khs.local) and
    outputs the response content. Useful for quickly verifying that the xConnect service
    is running and reachable.

.NOTES
    Author: David Cook
    - Requires that the xConnect site is running and the local SSL certificate is trusted.
    - Update the URI if your xConnect instance is at a different address.

.EXAMPLE
    .\Test-XP0-XConnect.ps1
    Outputs the HTTP response body from https://xp0.khs.local.
#>
$response = Invoke-WebRequest -Uri "https://xp0.khs.local"
$response.Content