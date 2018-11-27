#!/bin/bash
clear
ulang="y"

while [[ $ulang == "y" ]]
	do
		clear
		echo "====================[ Samba Configurator ]====================="
		echo "              =[ Samba Configurator v0.1.5-dev ]=              "
		echo -n "       +----+ =[  Samba `samba -V`"
		echo "  ]= +----+"
		echo ""
		echo "            +-- - --+ =[ Akhmad Fauzy ]= +-- - --+             "
		echo "                  +-- =[    Nadela    ]= --+"
		echo "====================[ ------------------ ]====================="
		echo ""
		echo "====================[ Status ]===================="
		echo -n " Samba : "
		if [[ "Installed" == `dpkg-query -s samba 2> /dev/null | grep -o 'Installed'` ]]
			then
				echo -e -n "\e[92mInstalled\e[0m"
				if [[ "is running" == `service samba status | grep -o 'is running'` ]]
					then
						echo -e " [ \e[92mService Running\e[0m ]"
						running=1
					else
						echo -e " [ \e[91mService not Running\e[0m ]"
						running=0
				fi
				status=1
			else
				echo -e "\e[91mNot Installed\e[0m"
				status=0
		fi
		echo -n " Sed   : "
		if [[ "Installed" == `dpkg-query -s sed 2> /dev/null | grep -o 'Installed'` ]]
			then
				echo -e "\e[92mInstalled\e[0m"
			else
				echo -e "\e[91mNot Installed\e[0m [ Please install sed ]"
		fi
		echo "====================[ ------ ]===================="

		echo ""

		echo "====================[  Menu  ]===================="
		echo " 1 Install Samba"
		echo -e " 2\e[93m Uninstall Samba\e[0m"
		echo " 3 Configure Network Interface"
		echo " 4 Configure Resolv.conf"
		echo " 5 Configure Samba"
		echo " 6 Restart Networking Service"
		echo " 7 Start / Stop Samba"
		echo " 8 Update"
		echo " 9 Upgrade"
		echo " 10 Exit"
		echo "====================[  ----  ]===================="
		read -p ">>> " pilihan

		case $pilihan in
			1 ) echo ">>> Installing ... please wait"
			    sudo apt-get install samba samba-common-bin -y > /dev/null
			    echo ">>> Samba Installed"
			    sleep 2
			;;
			2 ) read -p ">>> [WARNING] Are you sure ? ( y/n ) : " unin
				if [[ $unin == "y" ]] && [[ $status == 1 ]]
				then
					sudo apt-get -y remove samba
					sudo apt-get -y purge samba
				elif [[ $unin == "y" ]] && [[ $status == 0 ]]
				then
					echo ">>> Samba not installed"
					sleep 2
				fi
			;;
			3 ) echo -n ">>> "
			    sudo nano /etc/network/interfaces
			;;
			4 ) echo -n ">>> "
			    sudo nano /etc/resolv.conf
			;;
			5 ) sudo nano /etc/samba/smb.conf
			;;
			6 ) echo -n ">>> "
			    sudo service networking restart > /dev/null
			    echo ">>> Restarting Network"
			    sleep 2
			;;
			7 ) if [ $running -eq 0 ]
				then
					echo ">>> Starting Samba services ..."
					echo -n ">>> "
					sudo service samba start > /dev/null
				else
					echo ">>> Stoping Samba services ..."
					echo -n ">>> "
					sudo service samba stop &> /dev/null
				fi
			;;
			8 ) echo ">>> Updating ..."
			    echo ">>> "
			    sudo apt-get -y update &> /dev/null
			;;
			9 ) echo ">>> Upgrading ..."
			    echo ">>> "
			    sudo apt-get -y upgrade &> /dev/null
			;;
			10 ) exit
			;;
			* ) echo ">>> Command not found .."
			    echo -n ">>> "
			    sleep 3
			;;
		esac
done
