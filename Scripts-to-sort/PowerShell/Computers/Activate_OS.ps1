Clear-History
Clear-Host

$Certs = (Get-ChildItem Cert:\CurrentUser\My)
$CNT = 0

Write-Host
Write-Host "Certificate Selection for OS Activation"
Write-Host

ForEach($Cert in $Certs) {
$CNT = ($CNT + 1)
Write-Host $CNT")" ($Cert).Thumbprint ($Cert).Subject
}

Write-Host
$Answer = (Read-Host -Prompt "Input your choice" )

If ( $Answer -eq '1' ) { 
$A = ((Get-ChildItem Cert:\CurrentUser\My)[0]).Thumbprint
Write-Host ' ' 
Write-Host "Using: (" $A ") to activate the OS."
slmgr.vbs /fta $A }

If ( $Answer -eq '2' ) { 
$A = ((Get-ChildItem Cert:\CurrentUser\My)[1]).Thumbprint
Write-Host ' ' 
Write-Host "Using: (" $A ") to activate the OS."
slmgr.vbs /fta $A }

If ( $Answer -eq '3' ) { 
$A = ((Get-ChildItem Cert:\CurrentUser\My)[2]).Thumbprint
Write-Host ' ' 
Write-Host "Using: (" $A ") to activate the OS."
slmgr.vbs /fta $A }

If ( $Answer -eq '4' ) { 
$A = ((Get-ChildItem Cert:\CurrentUser\My)[3]).Thumbprint
Write-Host ' ' 
Write-Host "Using: (" $A ") to activate the OS."
slmgr.vbs /fta $A }

If ( $Answer -eq '5' ) { 
$A = ((Get-ChildItem Cert:\CurrentUser\My)[4]).Thumbprint
Write-Host ' ' 
Write-Host "Using: (" $A ") to activate the OS."
slmgr.vbs /fta $A }

If ( $Answer -eq '6' ) { 
$A = ((Get-ChildItem Cert:\CurrentUser\My)[5]).Thumbprint
Write-Host ' ' 
Write-Host "Using: (" $A ") to activate the OS."
slmgr.vbs /fta $A }

If ( $Answer -eq '7' ) { 
$A = ((Get-ChildItem Cert:\CurrentUser\My)[6]).Thumbprint
Write-Host ' ' 
Write-Host "Using: (" $A ") to activate the OS."
slmgr.vbs /fta $A }

If ( $Answer -eq '8' ) { 
$A = ((Get-ChildItem Cert:\CurrentUser\My)[7]).Thumbprint
Write-Host ' ' 
Write-Host "Using: (" $A ") to activate the OS."
slmgr.vbs /fta $A }

If ( $Answer -eq '9' ) { 
$A = ((Get-ChildItem Cert:\CurrentUser\My)[8]).Thumbprint
Write-Host ' ' 
Write-Host "Using: (" $A ") to activate the OS."
slmgr.vbs /fta $A }