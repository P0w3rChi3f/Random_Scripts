$IsLinux ? (Write-Host "This is Linux, We will run option 1") : (Write-Host "This is NOT Linux!!!!" -BackgroundColor Yellow -ForegroundColor Red)

#####################################################################################################################

if ($IsLinux) {
    Write-Host "This is Linux"
}
else {
    Write-host "This is NOT Linux" -BackgroundColor Yellow -ForegroundColor Red
}

#####################################################################################################################

$IsLinux ? (Write-Host "This is Linux") : ($IsMacOS) ? (Write-Host "This is MacOS") : ($IsWindows) ? (write-host "we are on a Windows machine") : (Write-Host "I have NO CLUE what OS we are on" -ForegroundColor Red -BackgroundColor Yellow)

#####################################################################################################################

if ($IsLinux) {
    Write-Host "This is Linux" 
}
elseif ($IsMacOS) {
    Write-Host "This is MacOS"
}
elseif ($IsLinux) {
    write-host "we are on a Windows machine"
}
else {
    Write-Host "I have NO CLUE what OS we are on" -ForegroundColor Red -BackgroundColor Yellow  
}

#####################################################################################################################
$x = "WindowsOS"

switch ($x) {
    WindowsOS {write-host "we are on a Windows machine"}
    LinuxOS {Write-Host "This is Linux"}
    MacOS {Write-Host "This is MacOS"}
    Default {Write-Host "I have NO CLUE what OS we are on" -ForegroundColor Red -BackgroundColor Yellow}
}