[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$Uri = "https://www.giac.org/certified-professionals/directory/gcwn"
$HTML = Invoke-WebRequest -Uri $Uri

($HTML.ParsedHtml.getElementsByTagName("td") | Where-Object {$_.classname -eq "table_data table_data_name"}).innertext

