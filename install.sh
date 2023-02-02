#!/bin/bash

clear
echo ""
echo "=========================================================================="
echo "|                                                                        |"
echo "|    full-stack-proxy-nginx-rancher-for-everyone-with-docker-compose     |"
echo "|                        by Erdal ALTIN                                  |"
echo "|                                                                        |"
echo "=========================================================================="
sleep 2

# Uninstall old versions
echo "Older versions of Docker were called docker, docker.io, or docker-engine. If these are installed, uninstall them"

sudo apt-get remove docker docker-engine docker.io containerd runc

echo ""
echo "Done ✓"
echo "============================================"

# install start
sudo apt-get update
curl https://releases.rancher.com/install-docker/20.10.sh | sh
sudo apt-get update

Installed=`sudo apt-cache policy docker-ce | sed -n '2p' | cut -c 14-`
Candidate=`sudo apt-cache policy docker-ce | sed -n '3p' | cut -c 14-`

if [[ "$Installed" != "$Candidate" ]]; then
	sudo apt-get install docker-ce docker-ce-cli containerd.io
elif [[ "$Installed" == "$Candidate" ]]; then
	echo ""
	echo 'docker currently version already installed.'
fi


echo ""
echo "Done ✓"
echo "============================================"

##########
# Run Docker without sudo rights
##########
echo ""
echo ""
echo "============================================"
echo "| Running Docker without sudo rights..."
echo "============================================"
echo ""
sleep 2

sudo groupadd docker
sudo usermod -aG docker ${USER}
# su - ${USER} &

echo ""
echo "Done ✓"
echo "============================================"

##########
# Install Docker Compose
##########
echo ""
echo ""
echo "============================================"
echo "| Installing Docker Compose v2.12.2..."
echo "============================================"
echo ""
sleep 2

sudo mkdir -p /usr/local/lib/docker/cli-plugins
sudo curl -SL "https://github.com/docker/compose/releases/download/v2.12.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/lib/docker/cli-plugins/docker-compose
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

# permission for Docker daemon socket
sudo chmod 666 /var/run/docker.sock

echo ""
echo "Done ✓"
echo "============================================"

##########
# Setup project variables
##########
echo ""
echo ""
echo "============================================"
echo "| Please enter project related variables..."
echo "============================================"
echo ""
sleep 2

# set parameters in env.example file
domain_name=""
read -p 'Enter Domain Name(e.g. : example.com): ' domain_name
[ -z $domain_name ] && domain_name="NULL"
host -N 0 $domain_name 2>&1 > /dev/null
while [ $? -ne 0 ]
do
	echo "Try again"
	read -p 'Enter Domain Name(e.g. : example.com): ' domain_name
	[ -z $domain_name ] && domain_name="NULL"
	host -N 0 $domain_name 2>&1 > /dev/null
done
echo "Ok."

email=""
regex="^[a-zA-Z0-9\._-]+\@[a-zA-Z0-9._-]+\.[a-zA-Z]+\$"
read -p 'Enter Email Address for letsencrypt ssl(e.g. : email@domain.com): ' email
while [ -z $email ] || [[ ! $email =~ $regex ]]
do
	echo "Try again"
	read -p 'Enter Email Address for letsencrypt ssl(e.g. : email@domain.com): ' email
	sleep 1
done
echo "Ok."

local_timezone_regex="^[a-zA-Z0-9/+-_]{1,}$"
read -p 'Enter container local Timezone(default : America/Los_Angeles, to see the other timezones, https://docs.diladele.com/docker/timezones.html): ' local_timezone
: ${local_timezone:=America/Los_Angeles}
while [[ ! $local_timezone =~ $local_timezone_regex ]]
do
	echo "Try again (can only contain numerals 0-9, basic Latin letters, both lowercase and uppercase, positive, minus sign and underscore)"
	read -p 'Enter container local Timezone(default : America/Los_Angeles, to see the other local timezones, https://docs.diladele.com/docker/timezones.html): ' local_timezone
	sleep 1
	: ${local_timezone:=America/Los_Angeles}
done
local_timezone=${local_timezone//[\/]/\\\/}
echo "Ok."

read -p "Apply changes (y/n)? " choice
case "$choice" in
  y|Y ) echo "Yes! Proceeding now...";;
  n|N ) echo "No! Aborting now..."; exit 0;;
  * ) echo "Invalid input! Aborting now..."; exit 0;;
esac

cp env.example .env

sed -i 's/example.com/'$domain_name'/' .env
sed -i 's/email@domain.com/'$email'/' .env
sed -i "s@directory_path@$(pwd)@" .env
sed -i 's/local_timezone/'$local_timezone'/' .env

if [ -x "$(command -v docker)" ] && [ "$(docker compose version)" ]; then	
	# installing Rancher and the other services
	docker compose up -d & export pid=$!
	echo "Rancher and the other services installing proceeding..."
	echo ""
	wait $pid
	if [ $? -eq 0 ]
	then
		echo ""
		until [ -n "$(sudo find ./certbot/live -name '$domain_name' 2>/dev/null | head -1)" ]; do
			echo "waiting for Let's Encrypt certificates for $domain_name"
			sleep 5s & wait ${!}
			if sudo [ -d "./certbot/live/$domain_name" ]; then break; fi
		done
		echo "Ok."
		#until [ ! -z `docker compose ps -a --filter "status=running" --services | grep proxy` ]; do
		#	echo "waiting starting proxy container"
		#	sleep 2s & wait ${!}
		#	if [ ! -z `docker compose ps -a --filter "status=running" --services | grep proxy` ]; then break; fi
		#done
		echo ""
		echo "Reloading proxy ssl configuration"
		docker container restart proxy > /dev/null 2>&1
		echo "Ok."
		echo ""
		echo "completed setup"
		echo ""
		echo "Website: https://$domain_name"
		echo ""
		echo "Ok."
	else
		echo ""
		echo "Error! could not installed Rancher and the other services with docker compose" >&2
		exit 1
	fi
else
	echo ""
	echo "not found docker and/or docker compose, Install docker and/or docker compose" >&2
	exit 1
fi
