#!/bin/bash

# Storyline: Extract IPs from emergingthreats.net and create a firewall ruleset.


etFile=/tmp/emerging-drop.suricata.rules


#--------------------------------------------------------------------------------------------------------------------------
# Regex to extract IPs

#egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.0/[0-9]{1,2}' /tmp/emerging-drop.suricata.rules | sort -u | tee badIPs.txt



# Create a firewall ruleset

#for eachIP in $(cat badIPs.txt)
#do
#
#
#	echo "iptables -A INPUT -s ${eachIP} -j DROP" | tee -a badIPs.iptable
#
#
#done
#--------------------------------------------------------------------------------------------------------------------------

# Test for the emergingthreats file.

if test -f "$etFile"
then

	echo "$etFile exists."

else

	read -p "$etFile does not exist. Do you want to download it? (Y/N) " choice

	case "$choice" in

	Y|y) wget https://rules.emergingthreats.net/blockrules/emerging-drop.suricata.rules -O /tmp/emerging-drop.suricata.rules
		 echo "File has been created"
	;;

	N|n) echo "File has not been created"
	;;

	*) echo "You chose poorly."
	   exit 0
	;;

	esac
fi


# Creating Options for the script

while getopts 'icnwmg' OPTION
do

	case "$OPTION" in

	I|i)

		for eachIP in $(cat badIPs.txt)
		do

			echo "iptables -A INPUT -s ${eachIP} -j DROP" | tee -a badIPs.iptable

		done
		exit 0
	;;

	C|c)

		for eachIP in $(cat badIPs.txt)
		do

			echo "access-list 103 deny ip host ${eachIP} any" | tee -a badIPs.cisco

		done
		exit 0
	;;

	N|n)

		for eachIP in $(cat badIPs.txt)
		do

			echo "set policy from Trust to UnTrust ip host ${eachIP) any" | tee -a badIPs.netscreen

		done
		exit 0
	;;

	W|w)

		for eachIP in $(cat badIPs.txt)
		do

			echo 'netsh advfirewall firewall add rule name="${eachIP} blocked" dir=in action=blocked remoteip=${eachIP}'

		done
		exit 0
	;;

	M|m)

		for eachIP in $(cat badIPs.txt)
		do

			echo "block in from ${eachIP} to any" | tee -a pf.conf

		done
		exit 0
	;;

	G|g)

		for eachDomain in $(cat targetedthreats.txt)
		do

			grep \"domain\" /tmp/targetedthreats.txt | sort | cut -d ',' -f 2

			echo "match protocol http host ${eachDomain}" | tee -a targetedthreat_domains.txt

		done
		exit 0
	;;

	esac

done
