# Storyline: A simple script to learn the basics of the Get-WmiObject cmdlet

# Use the Get-WMI cmdlet
# Get-WmiObject -Class Win32_service | select Name, PathName, ProcessID

# Get-WmiObject -list | where { $_.Name -ilike "Win32_[n-o]*" } | Sort-Object

# Get-WmiObject -Class Win32_Account | Get-Member

# Getting the network adapter information using the WMI class
Get-WmiObject -Class Win32_NetworkAdapterconfiguration | select ServiceName, IPAddress, DefaultIPGateway, DNSDomain