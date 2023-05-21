# Option 1 - Add-Type

# go to the location to where the DLLs are installed
Set-Location $PSHOME

# import all the 
Add-Type -AssemblyName "System.Windows.Forms"

# Option 2 - Call the Namespace
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
2
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")