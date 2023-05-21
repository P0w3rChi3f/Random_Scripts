# Possible old way of adding in the .Net Namespace
Add-Type -AssemblyName System.Windows.Forms 

# Possible new way of adding in the .Net Namespace
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
