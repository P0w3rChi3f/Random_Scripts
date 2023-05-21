Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Sort-Object |  export-csv c:\intel\InstalledApplications.csv

Get-WmiObject -Class Win32_Product | select-object Name, Version, IdentifyingNumber | Sort-Object |  export-csv c:\intel\InstalledApplications2.csv