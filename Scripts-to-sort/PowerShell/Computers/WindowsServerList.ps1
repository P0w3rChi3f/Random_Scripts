Import-Module AC*

Get-ADComputer -Filter 'OperatingSystem -like "Windows Server *"' -SearchBase "OU=NGPE,OU=States,DC=ng,DC=ds,DC=army,DC=mil" -Properties OperatingSystem | Export-Csv C:\AGMLogs\WindowsServerList.csv