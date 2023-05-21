Start-Transcript C:\AGMLogs\networkconnection.log


$servers = Get-ADComputer -Filter 'OperatingSystem -like "Windows Server *"' -SearchBase "OU=Servers,OU=NGPE,OU=States,DC=ng,DC=ds,DC=army,DC=mil"

foreach ($node in $servers) {
    $name = $node.DNSHostName

    try {
        Test-Connection -ComputerName $name -Count 1 -ErrorAction Stop 
        Write-output $name "does have network connectivity" 
    }

    catch [System.Management.Automation.RuntimeException] {
        Write-output $name "does NOT have network connectivity" }
}

Stop-Transcript