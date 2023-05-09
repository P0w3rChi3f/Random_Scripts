# Random_Scripts


[Miter CTI Training](MITER-ATTACK-CTI-Training/MITER-Readme.md)  
[Practical Malware Analysis]

## PowerShell 1 Liners

* Convert unix epoch miliseconds to human readable  
`([datetime]'01/01/1970').AddMilliseconds(1578076609595)`  
  * _Friday, January 3, 2020 6:36:49 PM_

* Hex to Decimal
  * [convert]::ToString(0x ,10)

* Decimal to binary
  * [convert]::ToString( ,2)

* Binary to Decimal
  * [convert]::ToInt32(10010000,2)

* look for files around the same time
  * `Get—ChildItem —path c:\ —Include log —Recurse —ErrorAction SilentlyContinue —force | Where—object {S_.CreationTime —ge "01/02/2018" —and $_.CreationTime —le "01/04/2018"} | Full name,Creationtime, lastwritetime`  

  * `get-childitem -path path -recurse -force -erroraction silentlycontinue | where-object {$_.CreationTime -gt "time" -and $_.CreationTime -lt "time"} select-object Name, CreationTime`

* Convert Log Dates to UTC
  * `Get-WinEvent -LogName Security | Where-Object {$_.id -eq "4672"} | select @{name="MyTime"; expression={(($_.TimeCreated).ToUniversalTime()).tostring("MM/dd/yyyy HH:mm:ss")}}, ID, LevelDisplayName, Message | select -First 150`

* Create Auto logon
`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon`
`DefaultUserName`
`DefaultPassword`

* Find Wireless Key by commandline
  `Netsh wlan show profiles name="169 CPT - Laurel MD - wireless W" key=clear`  

* check UAC status
  `Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System`  

* GPO UAC
  `Computer Configuration/Policies/Windows Settings/Security Settings/Local Policies/Security Options/`

* Disable Smart Screen
  `Administrative Templates\Windows Components\Windows Defender SmartScreen\Explorer\Configure Windows Defender SmartScreen`  

* Install AD Tools (RSAT)
  `Import-PSSession`
  `Get-WindowsCapability -Name RSAT* -Online | Select-Object -Property DisplayName, State`  
  `Get-WindowsCapability -Name RSAT* -Online | Add-WindowsCapability -Online`  

* Set Backgroud wallpaper
  `Set-ItemProperty -path "HKCU:\Control Panel\Desktop" -Name WallPaper -Value "C:\Users\169user\Pictures\questions.jpg"`
  `restart-computer`

* Seize FSMO roles from DC1 to DC2
  `Move-ADDirectoryServerOperationMasterRole -Identity dc2 -OperationMasterRole SchemaMaster, DomainNamingMaster, PDCEmulator, RIDMaster, InfrastructureMaster -Force`  

* Setting DHCP Scope Options
  `Foreach ($scope in ((Get-DHCPServerv4Scope).ScopeID)) {Set-DhcpServerv4OptionValue -ScopeID $scope -DnsServer 91.70.10.11,91.75.10.12}`  

* Steps to add new machines to the customer network

1. Force rebuild DC1
2. run commad on DC2
  `repadmin /syncall`
3. Force rebuild DHCP
4. Then build the new machine  

* Download and install Sysmon and Winlogbeats  

cd c:\users\rangecontrol\downloads
New-Item -ItemType Directory -Name Security
cd Security

Invoke-RestMethod -URI http://mirrors.it.com/mirrored/github.com/repositories/169CPT/sysmon-config/repository/sysmonconfig-export.xml -OutFile ./sysmon-config.xml  

Invoke-RestMethod -URI http://mirrors.it.com/mirrored/github.com/repositories/169CPT/Sysinternals/repository/Sysmon.exe -OutFile ./sysmon.exe  

Invoke-RestMethod -URI http://mirrors.it.com/mirrored/github.com/repositories/169CPT/winlogbeat-6.8.8/repository/winlogbeat-6.8.8-windows-x86_64.zip -OutFile ./winlogbeats.zip  

Invoke-RestMethod -URI http://mirrors.it.com/mirrored/github.com/repositories/169CPT/winlogbeat-6.8.8/repository/winlogbeat.yml -OutFile ./winlogbeat.yml  

sysmon.exe -accepteula -i sysmonconfig-export.xml

((Get-content .\winlogbeat.yml -raw) -replace "seconion_ip", "91.73.30.75") | set-content .\winlogbeat.yml  

((Get-content .\winlogbeat.yml -raw) -replace "seconion_ip", "91.73.30.75") | set-content .\winlogbeat.yml  

Expand-archive .\winlogbeats.zip -destination .\winlogbeat
move-item .\winlogbeat\winlogbeat-6.8.8-windows.x86_64\* .\winlogbeat
move-item .\winlogbeat "c:\program files\"  

& "c:\Program Files\winlogbeat\install-service-winlogbeat.ps1"  

* Ben ORR Artifacts

New-Item -ItemType Directory -path c:\users\$env:USERNAME\Documents -name "Security Onion"

New-Item -ItemType Directory -path c:\users\$env:USERNAME\Documents -name "Security Onion\Admin\Things TODO" -force

New-Item -ItemType Directory -path c:\users\$env:USERNAME\Documents -name "Security Onion\Scripts"

New-Item -ItemType Directory -path c:\users\$env:USERNAME\Documents -name "Security Onion\Filebeats"

New-Item -ItemType Directory -path c:\users\$env:USERNAME\Documents -name "Security Onion\Sysmon"

New-Item -ItemType Directory -path c:\users\$env:USERNAME\Documents -name "Security Onion\Winlogbeats"  

New-Item -ItemType File -Path "C:\Users\169user\Documents\Security Onion\Admin\Things to do" -Name "ThingsToDo.txt"

* Create the text documents

Add-Content "C:\Users\169user\Documents\Security Onion\Admin\Things to do\ThingsToDo.txt" "user: bStar"  
Add-Content "C:\Users\169user\Documents\Security Onion\Admin\Things to do\ThingsToDo.txt" "password: P@ssword01"
Add-Content "C:\Users\169user\Documents\Security Onion\Admin\Things to do\ThingsToDo.txt" " "
Add-Content "C:\Users\169user\Documents\Security Onion\Admin\Things to do\ThingsToDo.txt" "Add CentOS Boxes in IT-User space to allow SO-Allow as Analyst"
Add-Content "C:\Users\169user\Documents\Security Onion\Admin\Things to do\ThingsToDo.txt" "Add Beats config for the Pfsence and CentOS boxes"
Add-Content "C:\Users\169user\Documents\Security Onion\Admin\Things to do\ThingsToDo.txt" "Update WinlogBeats Config on the domain controllers to ship PowerShell Logs"
Add-Content "C:\Users\169user\Documents\Security Onion\Admin\Things to do\ThingsToDo.txt" "Update Winlogbeats to ship top events only"
Add-Content "C:\Users\169user\Documents\Security Onion\Admin\Things to do\ThingsToDo.txt" "Open Firewall on the Seconion to ingest firewall logs from Pfsence"
Add-Content "C:\Users\169user\Documents\Security Onion\Admin\Things to do\ThingsToDo.txt" "Setup Repo to be able to update Seconion and APT packages"

New-Item -ItemType File -Path "C:\Users\169user\Documents\Security Onion\FileBeats" -Name "ThingsToDo.txt"  -value "Install FileBeats on Pfsence"

Add-Content "C:\Users\169user\Documents\Security Onion\FileBeats\ThingsToDo.txt" "INstall FileBeats on the 2 CentOS Boxes in the IT user group"

Expand-archive .\winlogbeats.zip -destination .\winlogbeat  
move-item .\winlogbeat\winlogbeat-6.8.8-windows-x86_64\* .\winlogbeat
move-item .\winlogbeat "c:\Users\$env:UserName\Documents\Security Onion\Winlogbeats"  

move-item .\sysmon.exe "c:\users\$env:UserName\Documents\Security Onion\Sysmon"  

move-item .\sysmon-config.xml "c:\users\$env:UserName\Documents\Security Onion\Sysmon"

Move-Item .\Install-notes.ps1 "c:\users\$env:UserName\Documents\Security Onion\Scripts"  

## Set passworrd for BenOrr

Set-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name DefaultPassword -value P@ssword01  

* Add local users and add them to admistrators group
`New-LocalUser -Name Admin -Password (ConvertTo-SecureString -AsPlainText 'Admin' -Force); Add-LocalGroupMember -Group Administrators -Member Admin`

* Unregister Powershell Logging
`$PSHOME\RegisterManifest.ps1 -Unregister`  

* Scriptblock logging

## WMI commands to get syteminfo

* (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).sum /1gb

* Get-WmiObject -class win32_bios | Select-Object SerialNumber

iex "& { $(irm https://aka.ms/install-powershell.ps1) } -UseMSI"

* Win Server downloads
[WinSVR2022](https://software-download.microsoft.com/download/sg/20348.169.210806-2348.fe_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso)
[WinSVR2019](https://software-download.microsoft.com/download/pr/17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso)
[WinSVR2016](https://software-download.microsoft.com/download/pr/Windows_Server_2016_Datacenter_EVAL_en-us_14393_refresh.ISO)  

## Desired Configuration State Registry Key

* HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System  
  `DSCAutomationHostEnabled`

Value | Description
---|---
0 | Disable configuring the machine at boot-up.
1 | Enable configuring the machine at boot-up.
2 | Enable configuring the machine only if DSC is in pending or current state. This is the default value.  

## Add Windows SSH keys to Linux machines

  'Get-Content C:\Users\honey\.ssh\id_ed25519.pub | ssh admin@10.4.1.103 "cat >> .ssh/authorized_keys"'

## Add SSH KEY

cat C:\Users\169user\.ssh\id_ed25519.pub | ssh jay@10.4.1.235 "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"

## Listening Process Name
Get-NetTCPConnection | Where-Object {$_.state -eq "Listen" -or $_.state -eq "Established"} | 
  select LocalAddress, LocalPort, RemoteAddress, RemotePort, state, @{name="ProcessID"; expression={($_.OwningProcess)}} ,@{name="Process"; expression={($_.OwningProcess | 
  foreach {get-process -id $_}).ProcessName}}, @{name="UserName"; expression={$_.OwningProcess | 
  foreach {get-process -id $_ -IncludeUserName | Select -ExpandProperty UserName}}}
