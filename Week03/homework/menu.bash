#!/bin/bash

# Storyline: Menu for admin, VPN, and Security functions

function invalid_opt() {

	echo ""
	echo "Invalid Option"
	echo ""
	sleep 2

}




function menu() {

	# Clears the screen
	clear

	echo "[A]dmin Menu"
	echo "[S]ecurity"
	echo "[E]xit"
	read -p "Please enter a choice above: " choice

	case "$choice" in

	A|a) admin_menu
	;;

	S|s) security_menu
	;;

	E|e) exit 0
	;;

	*)
		echo ""
		echo "Invalid Option"
		echo ""
		sleep 2

		# Call the menu
		menu
	;;

	esac
}

function security_menu() {

	clear

	echo "[O]pen Network Sockets"
	echo "[U]ser ID Value of Zero"
	echo "[L]ast 10 Users"
	echo "[C]urrently Logged In Users"
	echo "[M]ain Menu"
	echo "[E]xit"
	read -p "Please enter a choice above: " choice

	case "$choice" in

		O|o) ss -l | less
		;;

		U|u) getent passwd | grep :0: | less
		;;

		L|l) last  -10 | less
		;;

		C|c) last -1 | less
		;;

		M|m) menu
		;;

		E|e) exit 0
		;;

		*)

		invalid_opt

		;;

	esac

security_menu

}

function admin_menu() {

	clear
	echo "[L]ist Running Processes"
	echo "[N]etwork Sockets"
	echo "[V]PN Menu"
	echo "[4] Exit"
	read -p "Please enter a choice above: " choice

	case "$choice" in

		L|l) ps -ef | less
		;;
		N|n) netstat -an --inet | less
		;;
		V|v) vpn
		;;
		4) exit 0
		;;

		*)

		invalid_opt

		;;

		esac

admin_menu
}


function vpn() {

	clear
	echo "[A]dd a peer"
	echo "[D]elete a peer"
	echo "[C]heck if a peer exists"
	echo "[B]ack to admin menu"
	echo "[M]ain Menu"
	echo "[E]xit"
	read -p "Please enter a choice above: " choice

	case "$choice" in

	A|a) 

	bash peer.bash
	tail -6 wg0.conf |less

	;;
	D|d) read -p "Please enter the peer you wish to delete: " pname
		 bash manage-users.bash -d -u ${pname}
		 echo "Deleting peer..."
		 sleep 2
		 echo "Complete!"
	;;

	C|c) read -p "PLease enter the peer you wish to search for: " peername
		 bash manage-users.bash -c -u ${peername}
	;;

	B|b) admin_menu
	;;
	M|m) menu
	;;
	E|e) exit 0
	;;
	*)

	invalid_opt

	;;

	esac

vpn
}


# Call the main function

menu
