Add-PSSnapin VMware.VimAutomation.core
$VIServerIP = 1.1.1.1
$FilePath = "/Path/to/Store/The/File_$date.csv"

#Connect-VIServer $VIServerIP
Connect-VIServer $VIServerIP

$pwd = Get-Content C:\Scripts\VMWare_Scripts\TaskSchedualCred
#$cred = New-Object System.Management.Automation.PSCredential "myServiceAccount", $pwd
$Date = get-date -DisplayHint date -Format ddMMMyy


get-vm -name * | export-csv $FilePath
