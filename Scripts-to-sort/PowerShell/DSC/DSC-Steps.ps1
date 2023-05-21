<#  Domain Controller Prep

 Install-windowsfeature ad-domain-services -includemanagementtools
 Install-addsforest -domainname testlab.local -SafeModeAdministratorPassword "SomePassword"

#>

<#  Client Machine Prep

# Staticly assigned the DNS Server
# Add-Computer -ComputerName $env:COMPUTERNAME -DomainName "TestLab.local" -Credential (Get-Credential)
# Enable-PSRemoting 

#>

<#  Setup of HTTP Push DSC (Done on the DC)

# Get-SmbShare (find already exising SMB Shares)
# Get-Acl "Path\to\Folder" | OGV
# Find-Module xpsdesired* | Install-Module -Confirm:$false
# Copy-Item "path\to\Http\pull\server\config\file" -Destination "path\to\smb\share"
# Start-DscConfiguration -Path "path\to\mof\file" -ComputerName "name-of-pull-svr"

#>

# Set up LCM on clients

# Copy-Item "path\to\Http\pull\LCM\config\file" -Destination "path\to\http\share"
# Set-DscLocalConfigurationManager -ComputerName win10x64 -Path C:\Windows\SYSVOL\sysvol\testlab.local\scripts -Verbose

# Created the config file
# Ran the following commands to create a MOF and rename it with the GUID
# $guid = Get-DscLocalConfigurationManager -CimSession win10x64 | Select-Object -ExpandProperty configurationID
# sourc = C:\windows\SYSVOL\sysvol\testlab.local\scripts\AllComputers.mof
# $dest = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration\$guid.mof"

