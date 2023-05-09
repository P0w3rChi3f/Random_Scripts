# Set my working Directory
$workingDir = "$env:USERPROFILE\Documents\IOCTests"

if (Test-Path $workingDir){
    Set-Location $workingDir
}
else {
    New-Item -ItemType Directory -Path $workingDir
    Start-Sleep -Milliseconds 500
    Set-Location $workingDir
}

$AlphaChars = @()
65..90 | ForEach-Object {$AlphaChars += [char]$_}
97..122 | ForEach-Object {$AlphaChars += [char]$_}
$AlphaChars
