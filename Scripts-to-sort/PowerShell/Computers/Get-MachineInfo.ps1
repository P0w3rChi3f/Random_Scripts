<#
get-acls 

get-autostarts
get-installed software

# Computer System 
Get-WmiObject -Class Win32_ComputerSystem
Get-CimInstance -ClassName Win32_computersystem | select domain,Name,InstallDate,HypervisorPresent,Manufacturer,Model

# BIOS
Get-WmiObject -Class Win32_BIOS 

# Environment Variables
dir env:\ 

# Users
Get-WmiObject -Class Win32_UserAccount 

# Groups
Get-WmiObject -Class Win32_Group 

# Group Members
Get-WmiObject -Class Win32_GroupUser 

# Password And Lockout Policies
net.exe accounts 

# Local Audit Policy
auditpol.exe /get /category:* 

# SECEDIT Security Policy Export
secedit.exe /export /cfg SecEdit-Security-Policy.txt 

# Shared Folders
Get-SmbShare 

# Networking Configuration
Get-NetAdapter -IncludeHidden
Get-NetIPAddress 
Get-NetTCPConnection -State Listen | Sort-Object LocalPort 
Get-NetUDPEndpoint | Sort-Object LocalPort 
Get-NetRoute 
nbtstat.exe -n  
netsh.exe winsock show catalog 

# Windows Firewall and IPSec 
Get-NetConnectionProfile 
Get-NetFirewallProfile 
Get-NetFirewallRule 
Get-NetIPsecRule 
netsh.exe advfirewall export Network-Firewall-Export.wfw 

# Processes
Get-Process -IncludeUserName 

# Drivers
Get-WmiObject -Class Win32_SystemDriver | WriteOut -FileName Drivers


# Services
Get-Service | WriteOut -FileName Services


# Generate an MSINFO32.EXE report, which includes lots of misc info.
msinfo32.exe /report MSINFO32-Report.txt


# Registry Exports (Add more as you wish)
reg.exe export hklm\system\CurrentControlSet Registry-CurrentControlSet.reg /y | out-null 
reg.exe export hklm\software\microsoft\windows\currentversion Registry-WindowsCurrentVersion.reg /y | out-null 


# Hidden Files and Folders 
Get-ChildItem -Path c:\ -Hidden -Recurse -ErrorAction SilentlyContinue | Select-Object FullName,Length,Mode,CreationTime,LastAccessTime,LastWriteTime | Export-Csv -Path FileSystem-Hidden-Files.csv


# Non-Hidden Files and Folders
Get-ChildItem -Path c:\ -Recurse -ErrorAction SilentlyContinue | Select-Object FullName,Length,Mode,CreationTime,LastAccessTime,LastWriteTime | Export-Csv -Path FileSystem-Files.csv

# NTFS Permissions And Integrity Labels
# This file can reach 100's of MB in size, so
# we'll limit this example to just System32:
icacls.exe c:\windows\system32 /t /c /q 2>$null | Out-File -FilePath FileSystem-NTFS-Permissions.txt


# Save hashes of the snapshot files to README.TXT.
"`n`n"   | Out-File -Append -FilePath README.TXT
"-" * 50 | Out-File -Append -FilePath README.TXT
Get-ChildItem      | Out-File -Append -FilePath README.TXT
"`n`n"   | Out-File -Append -FilePath README.TXT
"-" * 50 | Out-File -Append -FilePath README.TXT

#########   sha256deep.exe -s * | Out-File -Append -FilePath README.TXT

# But exclude the hash of README.TXT itself, which will be wrong of course.
# Ideally, the README file would be digitally signed now too.
(Get-Content -Path README.TXT) | Select-String -Pattern 'README' -NotMatch | Set-Content -Path README.TXT

##########################################################################################
#
#  Perform final tasks, such as writing to an event log, cleaning up temp files, 
#  compressing the folder into an archive, moving the archive into a shared folder, etc.
#
##########################################################################################

# Delete any leftover temp files?  (del *.tmp) 

# Set read-only bit on files created?  (attrib.exe +R *.txt)

# Go back up to parent directory.
Set-Location ..

Get-installed software - need to research because of mis-match output.
Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Sort-Object |  export-csv c:\intel\InstalledApplications.csv

Get-WmiObject -Class Win32_Product | select-object Name, Version, IdentifyingNumber | Sort-Object |  export-csv c:\intel\InstalledApplications2.csv

get-autoRuns

get-neighbors (network discovery)

get-schedualedtasks

HKEY-Root
    HKCR\Comfile\shell\open\command
    HKCR\Batfile\Shell\Open\Command
    HKCR\htafile\Shell\Open\Command
    HKCR\Exefile\Shell\Open\Command
    HKCR\Exefile\Shell\Open\Command
    HKCR\piffile\shell\open\command

current users auto run registry keys
    HKCU\Control Panel\Desktop
    HKCU\Software\Microsoft\Windows\CurrentVersion\
    HKCU\Software\Microsoft\Windows\CurrentVersion\Run
    HKCU\Software\Microsoft\Windows\CurrentVersion\Runonce
    HKCU\Software\Microsoft\Windows\CurrentVersion\RunonceEx
    HKCU\Software\Microsoft\Windows\CurrentVersion\RunServices
    HKCU\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce
    HKCU\Software\Microsoft\Windows\CurrentVersion\Windows\Run
    HKCU\Software\Microsoft\Windows\CurrentVersion\Windows\Load
    HKCU\Software\Microsoft\Windows\CurrentVersion\Windows\Scripts
    HKCU\Software\Microsoft\Windows\Windows NT\CurrentVersion\Windows /f run
    HKCU\Software\Microsoft\Windows\Windows NT\CurrentVersion\Windows /f load
    HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run
    HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs
    HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\LastVisitedMRU
    HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\LastvisitedPIDMRU
    HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\OpenSavePidlMRU /s
    HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU
    HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders
    HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders
    HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\RegEdit /v LastKey
    HKCU\Software\Microsoft\Internet Explorer\TypedURLSs
    HKCU\Software\Policies\Microsoft\Windows\Control Panel\Desktop

HKey_Local_Machine
    HKLM\Software\Microsoft\Active Setup\Installed Components /s
    HKLM\Software\Microsoft\Windows\CurrentVersion\explorer\User Shell Folders
    HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders
    HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\ShellExecuteHooks
    HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\SBrowser Helper Objects /s
    HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run
    HKLM\Software\Microsoft\Windows\CurrentVersion\Run
    HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce
    HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnceEx
    HKLM\Software\Microsoft\Windows\CurrentVersion\RunServices
    HKLM\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce
    HKLM\Software\Microsoft\Windows\CurrentVersion\Userinit
    HKLM\Software\Microsoft\Windows\CurrentVersion\shell\ServiceObjectDelayLoad
    HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks /s
    HKLM\Software\Microsoft\Windows NT\CurrentVersion\Windows
    HKLM\Software\Microsoft\Windows NT\CurrentVersion\Windows /f AppInit_DLLs
    HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon /f Shell
    HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon /f UserInit
    HKLM\Software\Policies\Microsoft\Windows\System\Scripts
    HKLM\Software\Classes\Batfile\shell\Open\command
    HKLM\Software\Classes\Comfile\shell\open\command
    HKLM\Software\Classes\exefile\shell\open\command
    HKLM\Software\Classes\htafile\shell\open\command
    HKLM\Software\Classes\piffile\shell\open\command
    HKLM\Software\Wow6432Node\Microsoft\Windows\Current Version\Explorer\Browser Helper Objects /s
    HKLM\System\CurrentControlSet\Control\Session Manager
    HKLM\System\CurrentControlSet\Control\Session Manager\KnownDLLs
    HKLM\System\CurrentControlSet001\Control\Session Manger\KnownDLLS



#>

function Get-ComputerInfo {
    param (
        
        [string[]] $computerName = $env:COMPUTERNAME
    ) # Parameters


   # Need to check if PSRemoting is enabled

    # Command gets basic computer information
    Get-CimInstance -ClassName Win32_computersystem -ComputerName $computerName | 
        Select-Object domain,Name,InstallDate,HypervisorPresent,Manufacturer,Model 
        
    # Command to get all services
        get-service -ComputerName $computerName | Sort-Object -Property Name | Format-Table -AutoSize
    
    
    } # Function

