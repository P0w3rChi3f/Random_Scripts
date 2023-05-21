


<# WinRM Notes

$creds = Get-Credential
$ipAddress = "192.168.121.129"

try {
    enter-pssession $ipAddress -UseSSL -Credential $creds
}
catch {
    Write-Host "$ipaddress does not have PowerShell remoting enabled"
}

    Set Trused hosts
    Set-Item WSMan:localhost\client\trustedhosts -value *
 
    Set start mode to automatic
    Set-Service WinRM -StartMode Automatic

    Verify start mode and state - it should be running
    Get-WmiObject -Class win32_service | Where-Object {$_.name -like "WinRM"}

    Verify Trusted Hosts
    Get-Item WSMan:\localhost\Client\TrustedHosts
 #>
$path = Get-Location
$workingPath = "$path\$env:COMPUTERNAME"

Start-Transcript -Path $workingPath\WindowsEnumerationTranscript.txt -IncludeInvocationHeader
Write-Verbose "Script requires AutoRuns from Sysinternals to be located"
# Need to create a working folder and move into it.  Here is where we will store the script along with other needed executables



New-Item -ItemType Directory -Name $compterName -Path $path\

#Get local neighbors
Get-NetNeighbor | Select-Object IPAddress,LinkLayerAddress,State | Where-Object { $($_.state) -eq "Reachable" -or $($_.state) -eq "Stale" } #| export-csv $workingPath\Neighbors.csv -NoTypeInformation

#Get installed software
Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | export-csv $workingPath\Software.csv -NoTypeInformation

#Get Running Processes
Get-Process | Select-Object ProcessName,Id,StartTime,Path,Description | export-csv $workingPath\Processes.csv -NoTypeInformation

#Get Firewall Rules
Get-NetFirewallRule * | Select-Object Name,DisplayName,Enabled,Profile,Direction,Action,Status | export-csv $workingPath\FirewallRules.csv -NoTypeInformation
 
#Get local users and Groups with Members

$LocalGroups = Get-LocalGroup
foreach ($localgroup in $localgroups) 
    {
        $group = $localgroup
        $member = Get-LocalGroupMember -Group $group
        #$null = $foreach.movenext()
        #$member = $foreach.Current

       [PSCustomObject]@{
            "Local Group" = $group
            Member = $Member

       } | Format-Table -AutoSize |Out-File $workingPath\LocalGroups.csv -Append

    } 


#AutoRuns
C:\Scripts\_InProgress\AutoRuns\autorunsc.exe -accepteula -a * -ct | Out-file $workingPath\AutoRuns.csv 

#Hash Sys32 and Sig Check Folder


Get-ChildItem -Path c:\windows\system32\* -Recurse | Get-FileHash -Algorithm MD5 | export-csv $workingPath\Sys32Hashes.csv


#network addresses

$NIC = Get-NetAdapter
 
ForEach ($adapter in $NIC){

    $IP = Get-NetIPAddress -InterfaceIndex $($adapter).ifIndex

    [PSCustomObject]@{
        Name = $adapter.Name
        "Interface Description" = $adapter.InterfaceDescription
        Index = $adapter.ifIndex
        MAC = $adapter.MacAddress
        Speed = $adapter.LinkSpeed
        Address = $IP
    } | out-file $workingPath\NetworkAdapter.csv -append #PSCustom Object close

}# ForEeach Close



#netstat
Get-NetTCPConnection | Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort, State, CreationTime, OperatingStatus, AppliedSetting, OwningProcess |
    Export-Csv $workingPath\NetStat.csv -NoTypeInformation



#100..255 | foreach-object {"192.168.121.$($_) : $(Test-Connection -count 1 -comp 192.168.1.$($_) -quiet)"}

#Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table –AutoSize

#Get-ChildItem HKLM:\ -recurse | Out-file -Append C:\Intel\hklm.txt




Stop-Transcript



<#


More notes
############################################################################
Resolve Hostname for set of IP addresses from text file:

Get-Content C:\ip-addresses.txt | ForEach-Object{
$hostname = ([System.Net.Dns]::GetHostByAddress($_)).Hostname
if($? -eq $True) {
  $_ +": "+ $hostname >> "C:\machinenames.txt"
}
else {
   $_ +": Cannot resolve hostname" >> "C:\machinenames.txt"
}}

#############################################################################

Find Computer name for set of IP addresses from CSV:

Import-Csv C:\ip-Addresses.csv | ForEach-Object{
$hostname = ([System.Net.Dns]::GetHostByAddress($_.IPAddress)).Hostname
if($? -eq $False){
$hostname="Cannot resolve hostname"
}
New-Object -TypeName PSObject -Property @{
      IPAddress = $_.IPAddress
      HostName = $hostname
}} | Export-Csv C:\machinenames.csv -NoTypeInformation -Encoding UTF8


#>