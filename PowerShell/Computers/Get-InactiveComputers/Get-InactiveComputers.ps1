<#
Created by James Honeycutt
Script was built in PowerShell 2.0
#>

#$today = get-date -DisplayHint Date
$45DayCuttoff = (get-date).AddDays(-45)
$SearchBase = "OU=SubOU3,OU=SubOU2,OU=SubOU1,DC=SubDomain1,DC=SubDomain2,DC=SubDomain3,DC=com"
$Computers = Get-ADComputer -Filter {-not(LastLogonTimeStamp -like "*") -or (LastLogonTimeStamp -lt $45DayCuttoff)} -SearchBase $SearchBase -Properties LastLogonTimestamp | Select-Object Name, SamAccountName, Description, @{N='lastLogonTimestamp'; E={[DateTime]::FromFileTime($_.LastLogonTimestamp).ToString('dd MMM yy')}}
$Date = get-date -DisplayHint date -Format ddMMMyy

foreach ($Computer in $Computers){

                $Computer.name +  " has not logged in the past 45 day, Their last login was " + $Computer.lastLogonTimestamp    #"C:\Scripts\LastLogon\LastLog.csv"
                Disable-ADAccount -Identity $Computer.SamAccountName
                Set-ADComputer -Identity $Computer.SamAccountName -Description "Disabled Due to Inactivity ($date) - Ran By Script" 
                dsquery computer "OU=NGPE,OU=States,DC=ng,DC=ds,DC=army,DC=mil" -name $Computer.name | dsmove -newparent "OU=Disabled_Computers,OU=SubOU3,OU=SubOU2,OU=SubOU1,DC=SubDomain1,DC=SubDomain2,DC=SubDomain3,DC=com" #P:\ShareDrive\Public\ADCleanUpReportsMove-ADObject -Identity $Computer.SamAccountName -TargetPath "OU=Disabled_Computers,OU=SubOU3,OU=SubOU2,OU=SubOU1,DC=SubDomain1,DC=SubDomain2,DC=SubDomain3,DC=com"
                

     }

$Computers | Export-Csv "\\FileServerName\Path\To\Share\ADCleanUpReports\Computers\LastComputerLogon_($Date).csv"