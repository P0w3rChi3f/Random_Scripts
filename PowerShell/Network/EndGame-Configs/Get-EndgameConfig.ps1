$uri = "https://ec2-18-222-227-54.us-east-2.compute.amazonaws.com/api/v1"

$token =  (Invoke-RestMethod -Uri "$uri/auth/login" -SkipCertificateCheck -Method POST -Body "{`"username`":`"honeycutt.james@gmail.com`",`"password`":`"Smp+3ndg@m3`"}" -ContentType "application/json").metadata.token

$policies = invoke-RestMethod -Uri "$uri/policies" -SkipCertificateCheck -Method GET -ContentType "application/json"  -Headers @{"Authorization" = "JWT $token"}

$investigations = invoke-RestMethod -Uri "$uri/investigations" -SkipCertificateCheck -Method GET -ContentType "application/json"  -Headers @{"Authorization" = "JWT $token"}

$EndGameUsers = invoke-RestMethod -Uri "$uri/users" -SkipCertificateCheck -Method GET -ContentType "application/json"  -Headers @{"Authorization" = "JWT $token"}

invoke-RestMethod -Uri "$uri/license/status" -SkipCertificateCheck -Method GET -ContentType "application/json"  -Headers @{"Authorization" = "JWT $token"}

(invoke-RestMethod -Uri "$uri/event_search/parent_process_tree" -SkipCertificateCheck -Method GET -ContentType "application/json"  -Headers @{"Authorization" = "JWT $token"}).definitions.pid.items

curl -X GET $uri/policies -H "Content-Type: application/json" -H "Authorization: JWT $token" -k

####################################################################################

(invoke-RestMethod -Uri "$uri/chat" -SkipCertificateCheck -Method POST -ContentType "application/json"  -Headers @{"Authorization" = "JWT $token"} -Body "{`"raw_text`":`"show me malicious PowerShell`"}").conversation

