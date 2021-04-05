# Storyline: View the event logs. Check for a valid log, and print the results.

function select_log() {

    cls

    # Lists all event logs
    $theLogs = Get-EventLog -List | select Log
    $theLogs | Out-Host

    # initialize the arry to store the logs
    $arrLog = @()

    foreach ($tempLog in $theLogs) {

        # Add each log to the array
        # Note: These are stored in the array as a hash table
        # @{Log=LOGNAME}
        $arrLog += $tempLog

    }

     # Test to be sure our array is being populated.
     # write-host $arrLog[0]

    #Prompt the user for a log to view or quit
    $readLog = Read-Host -Prompt "Please enter a log from the list above or 'q' to quit"

    # Check if the user wants to quit:
    if ($readLog -match "^[qQ]$") {
        
        # Stop executing the program and close the script
        break

    }

    log_check -logToSearch $readLog

} # ends the select_log()


function log_check() {

    # String the user types in within the select_log function
    Param([string]$logToSearch)

    # Format the user's input
    $theLog = "^@{Log=" + $logToSearch + "}$"


    # Search the array for the exact hashtable string
    if ($arrLog -match $theLog){

        write-host -BackgroundColor Green -ForegroundColor white "please wait it may take a few moments to retrieve the log entries"
        sleep 2

        # Call the function to view the log
        view_log -logToSearch $logToSearch

    } else {

        write-host -BackgroundColor Red -ForegroundColor white "The log specified doesn't exist."

        sleep 2

        select_log
    }

} # ends the log_check()


function view_log() {

    cls

    # Get the logs
    Get-EventLog -Log $logToSearch -Newest 10 -after "1/18/2020"

    # Pause the screen and wait until the user is ready to proceed
    read-host -Prompt "Press enter when you are done."
    
    # Go back to select_log
    select_log



} # ends the view_log()


# Run the select_log as the first function
select_log