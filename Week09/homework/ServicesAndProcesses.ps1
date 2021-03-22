# Storyline: Using the Get-Process and Get-Service cmdlets
# Get-Process | Select-Object ProcessName, Path, ID | ` 
# Export-Csv -Path "C:\users\test\Desktop\myProcesses.csv" -NoTypeInformation 
# Get-PRocess | Get-Member
# Get-Service | Where { $_.Status -eq "Running" }

Get-Process | Select-Object ProcessName, Path, ID | Export-Csv -Path "C:\Users\test\Desktop\RunningProcesses.csv" -NoTypeInformation
Get-Service | Where { $_.Status -eq "Running" } | Select-Object ServiceName, DisplayName | Export-Csv -Path "C:\Users\test\Desktop\RunningServices.csv" -NoTypeInformation