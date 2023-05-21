$computers = Get-ADComputer -filter * SearchBase "ou=Root,DC=state,DC=gov"

#$cred = Get-Credential

foreach ($computer in $computers){ 

    #invoke-command -ComputerName $computer -Credential $cred -ScriptBlock {enable -localuser -inputobject Administrator} #End ScriptBock

    try { Writehost "Checking WinRM Status on " ($computer).name
        Test-WSMan -ComputerName ($computer).name 
            } # End Try Block
    Catch {Write-host ($computer).name " does not have WinRM installed"} # Close Catch Block
} # End ForEach Loop