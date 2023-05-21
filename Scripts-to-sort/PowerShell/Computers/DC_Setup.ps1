<#
Directions to run the command and verify results

1. Copy ps1 to DC
2. browse to directory and from the command prompt type (runas /noprofile /user:ics\admin.chaud "powershell -command "& c:\Scripts\DC_setup.ps1""

3. Verify results by typing:

dsget group "CN=Domain Admins,CN=Users,DC=ICS,DC=STATE,DC=GOV" -members
dsget user "CN=NETWORK OWNER,OU=ACCOUNTS,OU=EXECUTIVE,OU=ICS,DC=STATE,DC=GOV


#>


Import-Module activedirectory

$DomainUsers = Get-ADUser -Filter *

Add-ADGroupMember -Identity "CN=Domain Admins,CN=Users,DC=ICS,DC=STATE,DC=GOV" -Members $DomainUsers.sAMAccountName

Disable-ADAccount -Identity network.owner



####################################################################################################################


Set-GPRegistryValue -Name "Default Domain Policy" -Key "HKLM\system\CurrentControlSet\Services\WinDefend" -ValueName "Start" -Type DWord -Value 4


