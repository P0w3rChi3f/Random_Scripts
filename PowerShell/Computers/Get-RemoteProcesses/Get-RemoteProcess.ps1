<#
The remote computers must have PS remoting enabled
  Enable-PSRemoting -SkipNetworkProfileCheck
#>
$creds = Get-Credential
$processes = Invoke-Command -ComputerName (Import-Csv .\Computers.csv).Computername -Credential $creds -ScriptBlock {Get-Process}

$processes