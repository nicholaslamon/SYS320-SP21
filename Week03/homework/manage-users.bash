#!/bin/bash

# Storyline: Script to add and delete VPN peers.

while getopts 'chdau:' OPTION ; do

	case "$OPTION" in

		d) u_del=${OPTION}
		;;
		a) u_add=${OPTION}
		;;
		c) u_check=${OPTION}
		;;
		u) t_user=${OPTARG}
		;;
		h)

			echo ""
			echo "Usage: $(basename $0) [-a] | [-c] | [-d] -u username"
			echo ""
			exit 1
		;;
		*)

			echo "Invalid value."
			exit 1
		;;

	esac

done


# Check to see if the -a and -d are empty or if they are both specified, throw an error

if [[ (${u_del} == "" && ${u_add} == "") || (${u_del} != "" && ${u_add} != "")  ]]
then

	echo "Please specify -a or -d and the -u and username."

fi

# Check to see if -u is specified.

if [[ (${u_del} !=  "" || ${u_add} != "") && ${t_user} == "" ]]
then

	echo "Please specify a user (-u)!"
	echo "Usage: $(basename $0) [-a] | [-d] [-u username]"
	exit 1

fi


# Delete a user

if [[ ${u_del} ]]
then

	echo "Deleting user..."
	sed -i "/# ${t_user} begin/,/# ${t_user} end/d" wg0.conf
fi

# Add a user

if [[ ${u_add}  ]]
then

	echo "Creating the User..."
	bash peer.bash ${t_user}

fi

# Check if a user exists

if [[ ${u_check} ]]
then

	echo "Checking if user exists..."
	check_user="$(grep ${t_user} wg0.conf)"
	if [[ "${check_user}" == "" ]]
	then

		echo "User does not exist." | less
		exit 1

	else

		echo "User does exist." | less

	fi
fi
