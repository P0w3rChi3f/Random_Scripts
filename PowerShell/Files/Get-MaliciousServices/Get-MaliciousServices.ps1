$ServiceIOCs = "Net CLR", "elpmasym", "aec", "XblGameSave", "wscsvc"
$FoundServices = @()

foreach ($Service in $ServiceIOCs) {
    $message = Get-Service $service -ErrorAction Ignore
    if ($null -eq $message) {
        Write-Host "$service Not Found"
    }
    else {
        write-host "$service was found on the machine.  Updating the log."
        $maliciousService = Get-CimInstance Win32_Service | Where-Object {$_.name -like "*$service*"} | Select-Object Name, State, PathName
        $FoundServices += $maliciousService
    }
} # Close Main Foreach

$FoundServices

#>