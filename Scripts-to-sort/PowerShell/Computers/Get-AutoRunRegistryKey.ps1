$array = @("192.168.1.1", "192.168.1.2")
foreach ($ip in $array) {
# Run net use, ignore output. Username/password not required in a domain environment
net use \\$ip $password /u:$user | out-null 
$ip # Print the IP address
reg query \\$ip\HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
reg query \\$ip\HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce
reg query \\$ip\HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Run
# These keys will not exist on 32-bit systems, so ignore any errors
reg query
\\$ip\HKLM\SOFTWARE\Wow6432node\Microsoft\Windows\CurrentVersion\Run 2> $null
reg query
\\$ip\HKLM\SOFTWARE\Wow6432node\Microsoft\Windows\CurrentVersion\RunOnce 2> $null
Net use \\$ip del # drop the share
}
