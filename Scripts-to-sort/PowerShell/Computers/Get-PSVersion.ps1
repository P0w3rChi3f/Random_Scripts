$servers = Get-ADComputer -Filter 'OperatingSystem -like "Windows Server *"' -SearchBase "OU=SubOU3,OU=SubOU2,OU=SubOU1,DC=SubDomain1,DC=SubDomain2,DC=SubDomain3,DC=com"

Foreach ($Server in $servers) {
    $SN = $Server.SamAccountName.Trim('$')
    $ConnStatus = Test-Connection -ComputerName $SN -Count 1 -Quiet
    $RemoteStatus = Test-WSMan -ComputerName $SN 
    if ($RemoteStatus.IsEmpty -eq $true) {
        Write-Host $SN "Does not have WinRM enabled"
        
     }
     elseif ($ConnStatus -eq $false) {
        Write-host $SN "doesnt have network connectivity"}
        #export-csv "C:\AGMLogs\PowershellVersions.csv" -Append}
           
     else {Invoke-Command -ComputerName $SN -ScriptBlock {$PSVersionTable.PSVersion} |  export-csv "C:\AGMLogs\PowershellVersions.csv" -Append}



}


