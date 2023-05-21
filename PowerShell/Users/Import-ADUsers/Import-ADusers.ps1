Import-Module ActiveDirectory

$users =  Import-Csv .\Rosters\Combined-UserList.csv

foreach ($user in $Users) {

    # A little test to make sure the SamAccountName is 20 characters or less
    if (($user.username).length -gt 16) {
        $samaccountname = ($user.username).substring(0,15)+".v21"
    }
    else {
        $samaccountname = $user.username+".v21"
    }

    # Variables are set here
    $DefaultPassword = 'PassWord12#$34'
    $userprincipalName = $samaccountname+"@91bde.net"
    $displayname = $user.firstname+" "+$user.initials+" "+$user.lastname+" v21"
    $AccountName = $user.lastname+","+" "+$user.firstname+" v21"
    $OUPath = "ou=$Unit,ou=valex 2021,ou=Exercises,dc=91bde,dc=net"
    $Unit = $user.Unit
    $Status = $user.description
    $DefaultGroup = "CN=VAl21 $Unit,ou=$Unit,ou=valex 2021,ou=Exercises,dc=91bde,dc=net"

    # This is the actual command that will create the accounts
    New-ADUser -Name $AccountName `
              -SamAccountName $samaccountname `
              -GivenName $user.firstname `
              -Surname $user.lastname `
              -path $OUPath `
              -AccountPassword (convertTo-SecureString -AsPlainText $DefaultPassword -Force) `
              -Enabled $true `
              -ChangePasswordAtLogon $true `
              -UserPrincipalName $userprincipalName `
              -emailaddress $user.email `
              -displayname $displayname `
              -description "$unit $status"

    # This command will add the users to the correct user group.
    Add-ADGroupMember -Identity $DefaultGroup -Members $samaccountname
       
}

#email - full .mil email address
#Display Names - First L Kolka v21
#userlongin name - @91bde.net
#discription - 

# Double check email on sheets