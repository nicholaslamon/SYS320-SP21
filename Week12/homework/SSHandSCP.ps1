# Storyline: Script that pulls processes, services, tcp network sockets, user account info, and network adapter configs and some other information for
# an Instant Reponse kit.

function IRScript() {

    cls

    # Prompts user for location path to save exported files
    $filePath = Read-Host -Prompt "Please create a folder on your desktop and then enter file path to that folder. Example: C:\Users\Nick\Desktop\Test"

    # Gets Processes and prints them out to csv
    Get-Process | Select-Object ProcessName, Path, ID | `
    Export-Csv -Path $filePath"\process.csv" -NoTypeInformation

    # Gets the registered services
    Get-WmiObject win32_service | Select Name,StartMode, PathName | `
    Export-Csv -Path $filePath"\services.csv" -NoTypeInformation

    # Gets all of the TCP network sockets
    Get-NetTCPConnection | `
    Export-Csv -Path $filePath"\tcpsocket.csv" -NoTypeInformation

    # Gets all of the user account info (output on this is a little funky becuase this was done on a SKIFF machine and my persoanl user account is a domain one not saved locally)
    Get-WmiObject -Class Win32_UserAccount -Filter  "LocalAccount='True'" | `
    Export-Csv -Path $filePath"\userinfo.csv" -NoTypeInformation

    # Gets all of the NetworkAdapterConfig info
    Get-NetAdapter -Name * | `
    Export-Csv -Path $filePath"\netinfo.csv" -NoTypeInformation

    # Get-Content is a cmdlet that allows you to check the contents of a file.
    # For this script I will have it print out the contents of a test file I  will make to show function.
    Get-Content -Path C:\Users\Nick\test\sample.txt.txt | `
    Export-Csv -Path $filePath"\contents.csv" -NoTypeInformation

    # Get-ExecutionPolicy cmdlet is a cmdlet that lets the user see what the execution policy for scripts.
    # This could help to see if the execution policy is loose and that might be a lead on if a malicious script had been run.
    Get-ExecutionPolicy | `
    Export-Csv -Path $filepath"\executionPolicy.csv" -NoTypeInformation

    # Get-Process | Where-Object is a cmdlet that will search for a process when you give its specfic process name. It will create a list of how many instances of that
    # proccess is running. For this example I used internet explorer, but you could use it to look for a process that may be bogging down a system/network.
    Get-Process | Where-Object {$_.Name –eq “iexplore”} | `
    Export-csv -Path $filePath"\runningProcess.csv" -NoTypeInformation

    # Test-Connection is a cmdlet that tests network connectivity. I used it to ping google (because google is always online)
    # I thought this was a good test just to see if outbound network connectivity was a thing.
    Test-Connection 8.8.8.8 -Count 2 -Delay 2 | `
    Export-Csv -Path $filePath"\networkConnection.csv"

    # Creating FileHash for each file in folder
    Get-FileHash $filePath\*.csv | Export-Csv -Path $home\Desktop\zhash.csv -NoTypeInformation 

}

IRScript

# Saves the files as a zip
Compress-Archive -Path C:\Users\Nick\Desktop\Test -DestinationPath C:\Users\Nick\Desktop\IRScript.zip -Force

# Creates an SSH session to the SSH server
New-SSHSession -ComputerName '192.168.4.50' -Credential (Get-Credential nicholas.lamon@cyber.local)

# Finds the zipped file and sends it to the SSH server
Set-SCPFile -ComputerName '192.168.4.50' -Credential (Get-Credential nicholas.lamon@cyber.local) -RemotePath '/home/nicholas.lamon@cyber.local' -LocalFile 'C:\Users\Nick\Desktop\IRScript.zip'

# Check to see if the file made 
Invoke-SSHCommand -Index 0 'ls -l'

# As an extra little thing, I have it so that it removes the SSH session at the end of the execution so that it doesn't stay open and stay as a vulnerablity :)
Remove-SSHSession -Index 0