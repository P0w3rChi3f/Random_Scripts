#Install-module powershellcookbook (Get-object)
#New-NetFirewallRule -Name "Allow WINRM IN" -DisplayName "Allow WINRM IN" -Direction Inbound -Protocol TCP -LocalPort 80
<#Set-Item WSMAN:\Localhost\Client\TrustedHosts -Value * -Force # * means all remote hosts

Check the change with:

Get-Item WSMAN:\Localhost\Client\TrustedHosts

Of course, you need to do this through an administrator powershell session.

You can test the configuration with:

Test-WSMan <remote hostname>

You may need to specify the credentials of an administrator on the remote host:

Test-WSMan <remote hostname> -credential <remote hostname>\<admin user> -authentication Negotiate

If all is good, you'll get something like this:

wsmid           : http://schemas.dmtf.org/wbem/wsman/identity/1/wsmanidentity.xsd
ProtocolVersion : http://schemas.dmtf.org/wbem/wsman/1/wsman.xsd
ProductVendor   : Microsoft Corporation
ProductVersion  : OS: 0.0.0 SP: 0.0 Stack: 2.0
#>

Invoke-Command -ComputerName 10.0.0.133 -ScriptBlock{get-process} -Credential (Get-Credential)

#Hide MOF/Configfiles in C:\Program Files\WindowsPowerShell\Configuration\files
$ConfigFilePath = "C:\Program Files\WindowsPowerShell\Configuration\files"




#Steps to create an SMB Pull Server
New-Item -Path $ConfigFilePath -ItemType Directory
New-SmbShare -Name "PowerShell Files" -Path $ConfigFilePath -ReadAccess Everyone -FullAccess Administrator -Description "PowerShell Module Share"

#Install xPSDesiredStateConfiguration to create an Http Pull Server
Install-Module -Name xPSDesiredStateConfiguration


