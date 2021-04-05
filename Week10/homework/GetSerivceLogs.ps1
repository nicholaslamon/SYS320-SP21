# Storyline: List all registered services and prompt the user based on what they want to see.

function get_services() { 

    cls

    # Find running services & create an array for them
    $runningServices = Get-Service | Where { $_.Status -eq "Running" }
    $arrRunning = @()

    # Array for running services
    foreach ($tempRunning in $runningServices) {
        
        # Adds each running process to the array
        $arrRunning += $tempRunning

    }

    # Find stopped services & create an array for them
    $stoppedServices = Get-Service | Where { $_.Status -eq "Stopped" }
    $arrStopped = @()

    # Array for stopped services
    foreach ($tempStopped in $stoppedServices) {
        
        # Adds each running process to the array
        $arrStopped += $tempStopped
 
    }

    # Prompt for the user to see which set of processes:
    $readServices = Read-Host -Prompt "Do you want to see all, running, or stopped services? Or 'q' to quit."

    # Check if the user wants to quit:
    if ($readServices -match "^[qQ]$") {
        
        # Stop executing the program and close the script
        break

    } elseif ($readServices -match "^running$") {

    write-host -BackgroundColor Green -ForegroundColor white "Please wait. It might take a few moments to retrieve running services."
    sleep 2

    $arrRunning | Out-Host

    Read-Host -Prompt "Press enter when you are done."
    get_services

    } elseif ($readServices -match "^stopped$") {
    
    write-host -BackgroundColor Green -ForegroundColor white "Please wait. It might take a few moments to retrieve stopped services."
    sleep 2
    
    $arrStopped | Out-Host

    Read-Host -Prompt "Press enter when you are done."
    get_services

    } elseif ($readServices -match "^all$") {
        
        Write-Host -BackgroundColor Green -ForegroundColor White "Please wait. It might take a few moments to retrieve all services."
        sleep 2

        $arrRunning | Out-Host
        $arrStopped | Out-Host

      Read-Host -Prompt "Press enter when you are done."
      get_services

    } else {

    Write-Host -BackgroundColor Red -ForegroundColor White "Sorry, invalid option. Try again."
    sleep 2

    get_services

    }


} # End of get_services()


get_services

