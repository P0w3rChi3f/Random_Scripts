Import-Module GroupPolicy
$printers = Import-Csv c:\agmlogs\printers.csv

foreach ($printer in $printers){ 

New-GPO -Name $printer.GPOName -Domain ng.ds.army.mil | Set-GPLink -Target "OU=Test,OU=CAC_Users,OU=Users,OU=NGPE,OU=States,DC=ng,DC=ds,DC=army,DC=mil" `
-LinkEnabled Yes 



}
#>
$printers.gponame
