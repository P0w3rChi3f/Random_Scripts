$VIServerIP = 1.1.1.1 
$VlanName = New_Vlan

Connect-VIServer -Server $VIServerIP

Get-VM -Location Script_Tests | Get-NetworkAdapter | Set-NetworkAdapter -NetworkName $VlanName -Confirm:$false 