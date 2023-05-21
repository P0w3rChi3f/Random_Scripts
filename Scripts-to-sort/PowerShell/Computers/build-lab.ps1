


function build-lab {

    [CmdletBinding()]
    
    param(
        [Parameter(Mandatory=$true)]
        [string] $NewName)

$currentIP = Get-NetIPAddress | Where-Object {$_.InterfaceAlias -like "Ethernet0"} | Where-Object {$_.AddressFamily -like "IPv4"}

Set-NetIPAddress -IPAddress $currentIP.IPAddress -PrefixLength $currentIP.PrefixLength

Get-DnsClientServerAddress | Where-Object {$_.AddressFamily -like "IPv4"} #| Where-Object{$_.InterfaceAlias -like "Ethernet0"}
Rename-Computer -NewName $NewName

}