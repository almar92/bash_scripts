#!/bin/bash

# The script stores the last version installed in the file lvs
# if no file exits, it creates one

lvs=last_ver.txt
first_start=0

if [ ! -e "$lvs" ] 
then
		touch $lvs 
		sudo chmod +rw $lvs
		echo "0" > $lvs
		first_start=1
else
		sudo chmod +rw $lvs
fi

num=$(sed -n 1p $lvs)

if [ $first_start == 1 ]
then

		echo "Looking for latest version, please wait..."		
		
		# cute spinner code
		i=1
		sp="/-\|"
		echo -n ' '		

		# if it's the first time the script is run
		# it checks for last version available for download

		while true; do

				num_check=$(($num_check + 1))
				ver_check=0.0.$num_check
				pkg_check=discord-$ver_check.deb
				link_check=https://dl.discordapp.net/apps/linux/$ver_check/$pkg_check
				url_check=$(curl -is $link_check | head -n 1)
				
				# cute spinner
				printf "\b${sp:i++%${#sp}:1}"	
				
				# the moment it finds an invalid URL the loop breaks
				[[ "${url_check:0:10}" == "HTTP/2 200" ]] || break 

		done
		
		# subtracts 1 from the num_check, since the last one is the unvalid one
		num_check=$(($num_check - 1))
		ver_check=0.0.$num_check
		pkg_check=discord-$ver_check.deb
		link_check=https://dl.discordapp.net/apps/linux/$ver_check/$pkg_check
		url_check=$(curl -is $link_check | head -n 1)

		echo ""
		echo "Latest version found is 0.0.$num_check"

elif [ $first_start == 0 ]
then
		num_check=$(($num + 1))
		ver_check=0.0.$num_check
		pkg_check=discord-$ver_check.deb
		link_check=https://dl.discordapp.net/apps/linux/$ver_check/$pkg_check
		url_check=$(curl -is $link_check | head -n 1)

fi

if [ "${url_check:0:10}" == "HTTP/2 200" ] && [ $first_start == 0 ]
then
    echo "Upgrading from version 0.0.$num to 0.0.$num_check"
    # writes on file the last version number
    echo $num_check > $lvs
elif [ "${url_check:0:10}" == "HTTP/2 200" ] && [ $first_start == 1 ]
then
    echo "Installing version 0.0.$num_check"
    # writes on file the last version number
    echo $num_check > $lvs
else
    echo "Discord already upgraded to latest version (0.0.$num)"
    exit
fi

num=$(sed -n 1p $lvs)
ver=0.0.$num
pkg=discord-$ver.deb
link=https://dl.discordapp.net/apps/linux/$ver/$pkg

wget --show-progress $link

sudo dpkg --install $pkg

rm $pkg
