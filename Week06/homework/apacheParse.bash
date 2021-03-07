#!/bin/bash

# Parse Apache Log
# 101.236.44.127 - - [24/Oct/2017:04:11:14 - 055] "GET / HTTP/1.1" 200 225 "-" "Mozzilla/5.0 (Windows NT 6.2; WOW64) AppleWebSkit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.94 Safari/537.36"

#Read in file

#Arguements using the position, they start at $1
APACHE_LOG="$1"

#check if file exists
if [[ ! -f ${APACHE_LOG}  ]]
then

	echo "Please specify the path to a log file."
	exit 1

fi

# Looking for web scanners
sed -e "s/\[//g" -e "s/\"//g" ${APACHE_LOG} | \
egrep -i "test|shell|echo|passwd|select|phpmyadmin|setup|admin|w00t" | \

# Cuts out all of the extra info so we are left with the IP address and saves it to a text file.
cut -f 1 -d - | sort -u | tee parsedlog.txt


# Calls the other script to create the rules and outputs them to their own files.
bash rules.bash -i
bash rules.bash -p
