# Volatility must be installed and have an entry in the environment varialbles

<# Notes

volatility.exe -f U:\FIWE-Scenarios\Images\SC-WKS03\Memory\SC-WKS03-Snapshot1.vmsn imageinfo  >> imageinfo.txt

volatility -f U:\FIWE-Scenarios\Images\SC-WKS03\Memory\SC-WKS03-Snapshot1.vmsn --profile=Win7SP1x86 pslist >> pslist.txt
volatility -f U:\FIWE-Scenarios\Images\SC-WKS03\Memory\SC-WKS03-Snapshot1.vmsn --profile=Win7SP1x86 pstree >> pstree.txt
volatility -f U:\FIWE-Scenarios\Images\SC-WKS03\Memory\SC-WKS03-Snapshot1.vmsn --profile=Win7SP1x86 psscan >> psscan.txt
volatility -f U:\FIWE-Scenarios\Images\SC-WKS03\Memory\SC-WKS03-Snapshot1.vmsn --profile=Win7SP1x86 psxview >> psxview.txt
volatility -f U:\FIWE-Scenarios\Images\SC-WKS03\Memory\SC-WKS03-Snapshot1.vmsn --profile=Win7SP1x86 -p 3812,3824,4016,3820,1704,3216,2936,5332 procdump -D DumpedProcesses\
volatility -f U:\FIWE-Scenarios\Images\SC-WKS03\Memory\SC-WKS03-Snapshot1.vmsn --profile=Win7SP1x86 netscan >> netscan.txt
volatility -f U:\FIWE-Scenarios\Images\SC-WKS03\Memory\SC-WKS03-Snapshot1.vmsn --profile=Win7SP1x86 malfind >> malfind.txt
volatility -f U:\FIWE-Scenarios\Images\SC-WKS03\Memory\SC-WKS03-Snapshot1.vmsn --profile=Win7SP1x86 envars >> envars.txt
volatility -f U:\FIWE-Scenarios\Images\SC-WKS03\Memory\SC-WKS03-Snapshot1.vmsn --profile=Win7SP1x86 getsids -p 936,1900,2068,2188,2332,2548,4084 >> getsids.txt
volatility -f U:\FIWE-Scenarios\Images\SC-WKS03\Memory\SC-WKS03-Snapshot1.vmsn --profile=Win7SP1x86 dlllist -p 1520,2980,4068,4324,4584,5432 >> dlllist.txt
volatility -f U:\FIWE-Scenarios\Images\SC-WKS03\Memory\SC-WKS03-Snapshot1.vmsn --profile=Win7SP1x86 yarascan --yara-rules="174.129.50.106" >> yarascan.txt
volatility -f U:\FIWE-Scenarios\Images\SC-WKS03\Memory\SC-WKS03-Snapshot1.vmsn --profile=Win7SP1x86 yarascan --yarafile=rules> yaraTest.txt
volatility -f U:\FIWE-Scenarios\Images\SC-WKS03\Memory\SC-WKS03-Snapshot1.vmsn --profile=Win7SP1x86 screenshot -D ScreenShots\


HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Domain

COMMON REGISTRY AUTOSTART LOCATIONS
•  HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run\
•  HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunOnce\
•  HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunServices\
•  HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce\
•  HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\run\
•  HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon
•  HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\Userinit

•  HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\

•  HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\run\
•  HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run\
•  HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnce\
•  HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnce\Setup\

•  HKEY_USERS\.Default\Software\Microsoft\Windows\CurrentVersion\Run\
•  HKEY_USERS\.Default\Software\Microsoft\Windows\CurrentVersion\RunOnce\

HKEY_LOCAL_MACHINE\SYSTEM\ControlSet00#\Control\ComputerName\ComputerName - ComputerName
HKEY_LOCAL_MACHINE\SYSTEM\ControlSet00#\Control\TimeZoneInformation - TimeZone information
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces - find the IP of system
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Domain - Domain Information

HKEY_LOCAL_MACHINE\Software\Microsoft\WindowsNT\CurrentVersion\systemtroot - systemroot
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion - ProductName / Operating System 
HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Authentication\LogonUI - Last Logged on User


frame contains GET


get-filehash
hashdeep -c md5

IP regex from cyberchef
(?:(?:\d|[01]?\d\d|2[0-4]\d|25[0-5])\.){3}(?:25[0-5]|2[0-4]\d|[01]?\d\d|\d)(?:\/\d{1,2})?


strings executable.1520.exe.BAD >> 1520Strings.txt /accepteula
strings executable.2980.exe.BAD >> 2980Strings.txt /accepteula
strings executable.4068.exe.BAD >> 4068Strings.txt /accepteula
strings executable.4324.exe.BAD >> 4324Strings.txt /accepteula
strings executable.4382.exe.BAD >> 4382Strings.txt /accepteula
strings executable.5432.exe.BAD >> 5432Strings.txt /accepteula



<QueryList>
  <Query Id="0" Path="file://U:\WalkThrough\CharlesGriffin\Export\Security.evtx">
    <Select Path="file://U:\WalkThrough\CharlesGriffin\Export\Security.evtx">
    *[System[TimeCreated[@SystemTime&gt;='2015-07-30T04:00:00.000Z' and @SystemTime&lt;='2015-08-01T03:59:59.999Z']]]
    and
    [EventData['Data Name'[@SubjectLogonId='0x3e7']]]
    </Select>
  </Query>
</QueryList>


#>

# get the path to the image
$image = "U:\FIWE-Scenarios\Images\SC-WKS03\Memory\SC-WKS03-Snapshot1.vmsn"

volatility.exe -f $image imageinfo