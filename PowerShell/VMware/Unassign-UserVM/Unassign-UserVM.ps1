        
        
        
        $Creds = Get-Credential
        $DODID = read-host "What is the users DODID # "
        $User = Get-ADUser -Filter {employeeID -like $DODID} -searchbase "OU=Users,OU=NGPE,OU=States,DC=ng,DC=ds,DC=army,DC=mil" -Verbose      #-OtherAttributes @{'employeeID'=$user} 1535778694
        #$samAccount = $($user.SamAccountName)
        #$Path = "\\FileServer01\Path\to\ShareFolder\Profiles\$samAccount"

        #unassign the user from their virtual machine
        

            $session = New-PSSession –Computername ngpea0viewbroke.ng.ds.army.mil -Credential $Creds
            Invoke-Command -Session $session -ScriptBlock {Get-PSSnapin -name VMware* -Registered | Add-PSSnapin -Verbose
            #Connect-VIServer 22.22.22.22

            $vmDesktop = Get-DesktopVM | Where-Object {$_.user_sid -eq $(get-user -Name $User.sid)}
            Remove-UserOwnership -Machine_id $vmDesktop.machine_id -Verbose
            }



            Exit-PSSession -Verbose


<#
            Exit-PSSession 
           


           $SPath = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition)
Set-Location $SPath

$Session = New-PSSession -ComputerName NGPEA0ViewBroke -Credential $credential Invoke-Command -Session $Session -ScriptBlock { Get-PSSnapin -name VMware* -Registered | Add-PSSnapin Get-DesktopVM }





            
            Add-PSSnapin -Name VMware.ImageBuilder
            Invoke-command -ScriptBlock {Add-PSSnapin -Name VMware.DeployAutomation}
            Add-PSSnapin -Name VMware.VimAutomation.Core
            Add-PSSnapin -Name VMware.View.Broker
          

             
           
            Connect-VIServer 55.195.251.50                  
            Get-DesktopVM 

                       

        
            -Verbose
            Write-Host "User was not unassigned from their VM"
           

 

Enable-WSManCredSSP -Role server
Enable-WSManCredSSP -Role Client -DelegateComputer 
exit
1139034771




#>
