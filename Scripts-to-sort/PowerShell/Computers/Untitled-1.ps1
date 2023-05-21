
$env:COMPUTERNAME
New-Item -ItemType Directory -Name $env:COMPUTERNAME -Path C:\Scripts\

#Get local neighbors
Get-NetNeighbor | Select-Object IPAddress,LinkLayerAddress,State | Where-Object { $($_.state) -eq "Reachable" -or $($_.state) -eq "Stale" } | export-csv C:\Scripts\$env:COMPUTERNAME\Neighbors.csv -NoTypeInformation

#Get installed software
Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | export-csv C:\Scripts\$env:COMPUTERNAME\Software.csv -NoTypeInformation

#Get Running Processes
Get-Process | Select-Object ProcessName,Id,StartTime,Path,Description | export-csv C:\Scripts\$env:COMPUTERNAME\Processes.csv -NoTypeInformation

#Get Firewall Rules
Get-NetFirewallRule * | Select-Object Name,DisplayName,Enabled,Profile,Direction,Action,Status | export-csv C:\Scripts\$env:COMPUTERNAME\FirewallRules.csv -NoTypeInformation
 
#Get local users and Groups with Members
Get-LocalUser *
foreach ($localgroup in $localgroups) {Get-LocalGroupMember -Group $localgroup | export-csv C:\Scripts\$env:COMPUTERNAME\LocalUsers.csv -NoTypeInformation}

#AutoRuns

#Has Sys32Folder

#network ips

#netstat




#100..255 | foreach-object {"192.168.121.$($_) : $(Test-Connection -count 1 -comp 192.168.1.$($_) -quiet)"}

#Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table –AutoSize

#Get-ChildItem HKLM:\ -recurse | Out-file -Append C:\Intel\hklm.txt