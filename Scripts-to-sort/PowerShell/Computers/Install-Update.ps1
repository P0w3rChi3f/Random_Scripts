
$ServerName = import-csv # Here is where you would put the file path to the CSV file.  Make sure it has a Column header with PSComputerName
$Server = $ServerName.PSComputerName
$sourcePath = Read-Host "Please input the sourse path of the application: "
$DestinationPath = Read-host "Please list the filepath of where you would like to stage the applicaion on the remote host: "

foreach ($node in $Server) {
Write-Verbose "Connecting to Reomote computer"
Invoke-Command -ComputerName $node -ScriptBlock {
    New-Item -ItemType Directory -Path $DestinationPath -Verbose -Force
    Copy-Item $sourcePath $DestinationPath -Recurse -Force -Verbose
    # Insert an install statement here, i.e.: cmd @{$DestinationPath\setup.exe /acompaning /arguments}
    }# Close Invoke-Command
}# Close Foreach

<# Use the below code if you have to remote into each machine ( I think that is how I used the code, but not sure since I did not document it.)

$sourcePath = Read-Host "Please input the sourse path of the application: "
$DestinationPath = Read-host "Please list the filepath of where you would like to stage the applicaion on the remote host: "

Write-Verbose "Connecting to Reomote computer"
New-Item -ItemType Directory -Path $DestinationPath -Verbose
Copy-Item $sourcePath $DestinationPath -Recurse -Force -Verbose

Invoke-Command -ComputerName ngpevmtrescript -ScriptBlock {Start-Process "wusa.exe" -ArgumentList 'c:\agmlogs\PowerShell50\Win8.1AndW2K12R2-KB3191564-x64.msu /extract:\\ngpevmtrescript\c$\agmlogs\Powershell50\temp' -wait -PassThru}
Invoke-Command -ComputerName ngpevmtrescript -ScriptBlock {Start-Process "dism.exe" -ArgumentList '/online /add-package /PackagePath:\\ngpevmtrescript\c$\agmlogs\Powershell50\temp\WindowsBlue-KB3191564-x64.cab' -wait -PassThru -} 

Enter-PSSession -ComputerName ngpevmtrescript -Verbose

#>