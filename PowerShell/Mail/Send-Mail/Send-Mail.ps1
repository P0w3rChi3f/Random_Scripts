<# Must allow mass Mailing for PowerShell and PowerShell_ISE

Steps:

Right click on McAfee icon 
Click on Virus Scan Console
Double click on Access Protection on VirusScan Console
On Access Protection tab
Go to Anti-Virus Standard Protection
On right hand side, double click on Prevent mass mailing worms from sending mail
On process to exclude tab, add PowerShell.exe and powershell_ise.exe at the end
Click ok 
Click apply on Access Protection
Click ok
#>
$SMTPRelay = 'MailRelay01'
$Array1= "Mickey Mouse", "Donald Duck", "Goofy"

Send-MailMessage -to "P0w3rChi3f@pm.me" -from "P0w3rChi3f-PowerShell@pm.me" `
-Subject "This is only a test" `
-body "This is a test message from powershell $Array1 Only A test" `
-Smtphost $SMTPRelay

Send-MailMessage -to P0w3rChi3f@pm.me -from P0w3rChi3f-PowerShell@pm.me -Subject "This is only a test" -body "This is a test message from powershell " $Array1.ToString().Split(" ") + " Only A test" -Smtphost SMTPServer.FQDN.com

