Import-Module activedirectory


$GetTotal = Read-Host "How many accounts are needed?"
$TotalConversion= $GetTotal -as [int] 
$TotalAccounts = $TotalConversion+1

$UserCount = 01
$UserPrefix = Read-Host "What is the Prefix of the user name?  DO NOT include the ending number."   #"TestStuComps" 

$PassWord = Read-Host "What is the password of the users?"
$DefaultGroup = "CN=start,OU=ldap,OU=path,OU=here,DC=company,DC=com"

Do
    
{$userCount.ToString()
New-ADUser -SamAccountName ($UserPrefix+("{0:D2}" -f $userCount)) `
    -name ($UserPrefix+("{0:D2}" -f $userCount)) `
    -Path "CN=start,OU=ldap,OU=path,OU=here,DC=company,DC=com" `
    -AccountPassword (convertTo-SecureString -AsPlainText $PassWord -Force) -Enabled $true `
     
Add-ADGroupMember -Identity "CN=start,OU=ldap,OU=path,OU=here,DC=company,DC=com" -Members ($UserPrefix+("{0:D2}" -f $userCount))

$userCount++
}While ($userCount -lt $TotalAccounts)