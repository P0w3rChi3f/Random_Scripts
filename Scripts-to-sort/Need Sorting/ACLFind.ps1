foreach($file in Get-ChildItem "C:\windows\Temp\q33") {
    $acl = Get-Acl $file.fullname
    if(-not $acl) { continue }
    $FoundAdminAcl = $false
    foreach($accessRule in $acl.Access) {
        if(($accessRule.IdentityReference -like "*Administrator*") -and
          ($accessRule.FileSystemRights -eq "FullControl")) {
            $foundAdminAcl = $true
        }
    }
    if(-not $FoundAdminAcl) { Write-Output "Found possible ACL Misconfiguration: $file" }
    else { Write-Output "NOTHING FOUND: $File" }
}
