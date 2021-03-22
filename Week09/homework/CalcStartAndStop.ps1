# Storyline: A simple script to start and stop the Windows Calculator.

# Starts the calculator
Start-Process calc

#This is just a wait so we can see that the calc opens
Start-Sleep -Seconds 3

# Ends the calculator process by its process name
Stop-Process -Name "Calculator"