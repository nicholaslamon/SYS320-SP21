#!/bin/bash

# Storyline: This is an additional script to run inside of apacheParse.bash that enables us to create the rules.
#			 For some reason, I could not get these commands to work inside of that script so I thought the best
#			 work around was to make a new script that contained them and then call it from the Parsing Script.

# Creating options to make the different rules
while getopts 'pi' OPTION
do

	case "$OPTION" in

	# Powershell rules
	P|p)

		for eachIP in $(cat parsedlog.txt)
		do

			echo "netsh advfirewall firewall add rule name='BLOCKED IP ADDRESS - ${eachIP}' dir=in action=block remoteip=${eachIP}" | tee -a psFirewallRules.txt

		done
		exit 0

	;;

	# Iptables rules
	I|i)

		for eachIP in $(cat parsedlog.txt)
		do

			echo "iptables -A INPUT -s ${eachIP} -j DROP" | tee -a iptableRules.txt

		done
		exit 0

	;;

	esac

done
