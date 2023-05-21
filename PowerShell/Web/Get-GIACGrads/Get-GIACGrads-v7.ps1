[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$Uri = "https://www.giac.org/certified-professionals/directory/grem"
$HTML = Invoke-WebRequest -Uri $Uri

#($HTML.ParsedHtml.getElementsByTagName("td") | Where-Object {$_.classname -eq "table_data table_data_name"}).innertext

$Names = (($HTML.Links.outerHTML | Select-String -Pattern '^(<a href="/certified-professional/)').Line).Trim('<a href="/certified-professional/') -replace '^[\d|\w].+">' -replace '</a>'

foreach ($Name in $Names) {
    $DisplayName = $Name.split(',')[1] + " " + $Name.split(",")[0]
    $DisplayName
}
