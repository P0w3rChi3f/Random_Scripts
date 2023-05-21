<# NOTES
https://social.technet.microsoft.com/Forums/windows/en-US/8e33bac3-6907-40c5-84cb-06a8065d8193/virus-total-hash-scan?forum=winserverpowershell

https://p0w3rsh3ll.wordpress.com/2013/01/17/searching-virustotal-com-with-powershell/

invoke-webrequest https://www.virustotal.com/gui/file/$hash/detection
#>

$hash = "a4b35de71ca20fe776dc72d12fb2886736f43c22"
$hash2 = "9dce39ac1bd36d877fdb0025ee88fdaff0627cdb"

$Query = Invoke-WebRequest -Uri "https://www.virustotal.com/search" -Method Post -Body "query=$hash"


# PowerShell v7 

$page = Invoke-WebRequest -Method GET -Uri $Query.BaseResponse.RequestMessage.RequestUri.OriginalString

# PowerShell v5 

$page = Invoke-WebRequest -Method GET -Uri $Query.BaseResponse.ResponseUri.OriginalString
$obj = New-Object -TypeName PSObject 
    ($page.allelements | where-object {($_.TagName -eq "TBODY") -and ($_.outerHTML -match "$checksum")}).OuterText -split "`n" |  ForEach-Object {$obj | Add-Member -MemberType NoteProperty -Name ($_ -split ":")[0] -Value (-join($_ -split ":" )[1..($_ -split ":" ).count])                        
}
$obj
#>