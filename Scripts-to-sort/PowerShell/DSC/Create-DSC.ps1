# Note to create DSC on a remote machine without domain creds

#1. Check Firewall rules for ICMP and WinRM
    #Set-NetFirewallRule -Name "WINRM-HTTP-In-TCP-PUBLIC" -RemoteAddress Any
    #Enable-NetFirewallRule -Name "FPS-ICMP4-ERQ-IN" 