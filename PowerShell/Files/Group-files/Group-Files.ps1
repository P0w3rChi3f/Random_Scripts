$counter = 1
$filePath = "C:\Users\honey\Downloads\RunKeeperFiles"
$directoryName = "Batch"
$fileExtention = ".gpx"
$testPath = $filePath + "\*" + $fileExtention

While (Test-Path $testPath) {

$NewFolder = New-Item -ItemType directory -Path $filePath -Name $directoryName$counter

Get-ChildItem $filePath | Where-Object {$_.Extension -eq $fileExtention} | Select-Object -First 25 | Move-Item -Destination $NewFolder

$counter ++

#$Test = Test-Path $testPath

} #While ($Test -eq $true)