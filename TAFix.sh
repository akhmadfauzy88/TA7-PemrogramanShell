#!/bin/bash

animasi(){
	echo -e "\033[2J\033[?25l"
	R=`tput lines` C=`tput cols`
	: $[R--]
	while true
		do
			( e=echo\ -e s=sleep j=$[RANDOM%C] d=$[RANDOM%R]
			for i in `eval $e {1..$R}`
				do
					c=`printf '\\\\0%o' $[RANDOM%57+33]`
					$e "\033[$[i-1];${j}H\033[32m$c\033[$i;${j}H\033[37m"$c
					$s 0.1
					if [ $i -ge $d ]
						then
							$e "\033[$[i-d];${j}H "
					fi
			done
			for i in `eval $e {$[i-d]..$R}`
				do
					echo -e "\033[$i;${j}f "
					$s 0.1
			done)& sleep 0.05
	done
}

update(){
	sudo apt-get update
}

upgrade(){
	sudo apt-get upgrade
}

header(){
	echo "==========================="
	echo "           Menu            "
	echo "==========================="
	echo " 1. Tampilkan animasi      "
	echo " 2. Update                 "
	echo " 3. Upgrade                "
	echo " 4. Exit                   "
	echo "==========================="
}

menu="y"

while [[ $menu == "y" ]]
	do
		clear
		header
		read -p "Pilihan : " pilih
		case $pilih in
			1 ) animasi
			;;
			2 ) update
			;;
			3 ) upgrade
			;;
			4 ) exit
			;;
			* ) echo "Pilihan tidak tersedia"
			;;
		esac
		read -p "Pilih lagi ? ( y/n ) : "  menu
done
