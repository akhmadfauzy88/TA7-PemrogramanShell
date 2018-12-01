#!/bin/bash
clear
ulang="y"

if [[ "Installed" == `dpkg-query -s sl 2> /dev/null | grep -o "Installed"` ]]; then
#	sl
	echo
fi

konfigurasi(){
	clear
	echo "==========-[ Samba ]-=========="
	echo -n " Nama Folder = "
	read -e folder
	echo -n " Path lengkap = "
	read -e path
	echo -n " Browseable (yes/no) = "
	read -e browseable
	echo -n " Guest ok (yes/no) = "
	read -e guest
	echo -n " writeable (yes/no) = "
	read -e writeable
	echo "==========-[ ----- ]-=========="

	echo -n ">>> Correct ? (y/n) = "
	read cor

	if [[ $cor == "y" ]]; then
		sudo echo -e "[$folder] \n path = $path \n browseable = $browseable \n guest ok = $guest \n writeable = $writeable" > smb.cf
	fi
}

while [[ $ulang == "y" ]]
	do
		clear
		echo "====================[ Samba Configurator ]====================="
		echo "              =[ Samba Configurator v0.2.9-dev ]=              "
		if [[ "Installed" == `dpkg-query -s samba 2> /dev/null | grep -o 'Installed'` ]]
			then
				echo -n "       +----+ =[  Samba `samba -V`"
				echo "  ]= +----+"
		fi
		echo ""
		echo "          +-- - --+ =[ .:Akhmad Fauzy:. ]= +-- - --+           "
		echo "                +-- =[      Nadela      ]= --+"
		echo "                +---=[    Muh Yasser    ]=---+"
		echo "====================[ ------------------ ]====================="
		echo ""
		echo "==========================[ Status ]==========================="
		echo -n " Samba    : "
		if [[ "Installed" == `dpkg-query -s samba 2> /dev/null | grep -o 'Installed'` ]]
			then
				echo -e -n "\e[92mInstalled\e[0m"
				if [[ "inactive" != `/etc/init.d/smbd status | grep -o 'inactive'` ]]
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

		#echo -n " Awk      : "
		#if [[ "Installed" == `dpkg-query -s awk 2> /dev/null | grep -o 'Installed'` ]]
		#	then
		#		echo -e "\e[92mInstalled\e[0m"
		#	else
		#		echo -e "\e[91mNot Installed\e[0m [ Please install awk ]"
		#fi

		echo -n " Internet : "
		wget --timeout=3 --spider --quiet google.com
		if [ "$?" != 0 ]
			then
				echo -e "\e[91mOffline\e[0m"
			else
				echo -n -e "\e[92mOnline\e[0m"
				echo -e "    [ `ifconfig wlan0 | grep -m 1 'inet' | awk '{print $2}'` ] "
		fi
		echo "==========================[ ------ ]==========================="

		echo ""

		echo "==========================[  Menu  ]==========================="
		echo " 1  Install Samba"
		echo -e " 2\e[93m  Uninstall Samba [Warning Zone] \e[0m"
		echo " 3  Configure Network Interface"
		echo " 4  Configure Samba"
		echo -e " 5  \e[91mRestart Network [Warning, Reboot]\e[0m"
		echo " 6  Restart Samba"
		echo " 7  Start / Stop Samba"
		echo " 8  Update Package"
		echo " 9  Upgrade Package"
		echo " 10 Exit"
		echo "==========================[  ----  ]==========================="
		read -p ">>> " -e pilihan

		case $pilihan in
			1 ) echo ">>> Installing ... please wait"
			    sudo apt-get install samba samba-common-bin -y &> /dev/null
			    echo ">>> Samba Installed"
			    sleep 2
			;;
			2 ) read -p ">>> [WARNING] Are you sure ? ( y/n ) : " unin
				if [[ $unin == "y" ]] && [[ $status == 1 ]]
				then
					sudo apt-get -y remove samba &> /dev/null
					sudo apt-get -y purge samba &> /dev/null
				elif [[ $unin == "y" ]] && [[ $status == 0 ]]
				then
					echo ">>> Samba not installed"
					sleep 2
				fi
			;;
			3 ) echo -n ">>> "
			    sudo nano /etc/dhcpcd.conf
			;;
			4 ) konfigurasi
			;;
			5 )  sudo reboot > /dev/null
			    echo ">>> Restarting ..."
			    sleep 2
			;;
			6 ) echo ">>> Restarting samba services ..."
			    sudo service smbd restart &> /dev/null
			;;
			7 ) if [ $running -eq 0 ]
				then
					echo ">>> Starting Samba services ..."
					sudo service smbd start &> /dev/null
				else
					echo ">>> Stoping Samba services ..."
					sudo service smbd stop &> /dev/null
				fi
			;;
			8 ) echo ">>> Updating ..."
			    sudo apt-get -y update > /dev/null
			;;
			9 ) echo ">>> Upgrading ..."
			    sudo apt-get -y upgrade > /dev/null
			;;
			10 ) exit
			;;
			* ) echo ">>> Command not found .."
			    echo -n ">>> "
			    sleep 3
			;;
		esac
done
