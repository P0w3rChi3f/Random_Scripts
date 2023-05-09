$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.Cookies.Add((New-Object System.Net.Cookie("token", "`"2|1:0|10:1683115158|5:token|220:ZXlKaGJHY2lPaUpJVXpJMU5pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SnBaQ0k2SW1GaVl6UTNOak00TFRWallUa3RORGRqTVMxaU5qUXpMV1U0T0dFeE5XWTRZV1EzWkNJc0ltVjRjQ0k2TVRZNE16RTBNemsxT0gwLlpHVGlQRHA1ZjVwTW5KSURIclpsbEFfc0hpUDJ1dnEyOTVHa0RqUThrc0E=|41084fdbc67b0027a84b36bcfcbe79fa402be09e7fe02927b9d9736e68eabebe`"", "/", "i-02a22da1484576964.elasticlabs.training")))
Invoke-WebRequest -UseBasicParsing -Uri "https://i-02a22da1484576964.elasticlabs.training/api/v1/policies" `
-WebSession $session `
-ContentType "application/json" `
-SkipCertificateCheck

##########################################################################################

Invoke-RestMethod -Uri "https://pve.honeycutthomenet.local:8006/api2/json/access/domains" -Method GET -Headers @{"PVEAPIToken" = "terraform-prov@pve!TerraformProvisioning=7df19234-6fab-4e2c-aed2-bbfd755e7346"} -SkipCertificateCheck 