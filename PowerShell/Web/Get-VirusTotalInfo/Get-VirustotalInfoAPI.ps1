# https://www.virustotal.com/gui/file/f50e42c8dfaab649bde0398867e930b86c2a599e8db83b8260393082268f2dba/detection

$apiKey = Get-Content '<Path/to/Your/API/Key>'
$hash = "9dce39ac1bd36d877fdb0025ee88fdaff0627cdb"

$headers=@{}
$headers.Add("Accept", "application/json")
$headers.add("x-apikey", $apiKey)

$response = Invoke-WebRequest -Uri "https://www.virustotal.com/api/v3/files/$hash" -Method GET -Headers $headers

$objresponse = $response | ConvertFrom-json

$objResponse.data.attributes
