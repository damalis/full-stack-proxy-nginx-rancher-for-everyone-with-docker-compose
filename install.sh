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

# the "lpms" is an abbreviation of Linux Package Management System
lpms=""
for i in apk dnf yum apt zypper pacman
do
	if [ -x "$(command -v $i)" ]; then
		if [ "$i" == "apk" ]
		then
			lpms=$i
			sudo apk add --no-cache --upgrade grep
			break
		elif [ "$i" == "dnf" ] && ([[ $(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"') == "fedora" ]] || (([[ $(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"') != "centos" ]] && [[ $(grep -Pow 'ID_LIKE=\K[^;]*' /etc/os-release | tr -d '"') == *"fedora"* ]]) || ([[ $(grep -Pow 'ID_LIKE=\K[^;]*' /etc/os-release | tr -d '"') == *"rhel"* ]] && [ $(sudo uname -m) == "s390x" ])))
		then
			lpms=$i
			break
		elif [ "$i" == "yum" ] && ([[ $(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"') == "centos" ]] || (([[ $(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"') != "fedora" ]] && [[ $(grep -Pow 'ID_LIKE=\K[^;]*' /etc/os-release | tr -d '"') == *"fedora"* ]]) || ([[ $(grep -Pow 'ID_LIKE=\K[^;]*' /etc/os-release | tr -d '"') == *"rhel"* ]] && [ $(sudo uname -m) == "s390x" ])))
		then
			lpms=$i
			break
		elif [ "$i" == "apt" ] && ([[ $(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"') == *"ubuntu"* ]] || [[ $(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"') == *"debian"* ]] || [[ $(grep -Pow 'ID_LIKE=\K[^;]*' /etc/os-release | tr -d '"') == *"ubuntu"* ]] || [[ $(grep -Pow 'ID_LIKE=\K[^;]*' /etc/os-release | tr -d '"') == *"debian"* ]])
		then
			lpms=$i
			break
		elif [[ $(grep -Pow 'ID_LIKE=\K[^;]*' /etc/os-release) == *"suse"* ]]
		then
			lpms=$i
			break
		elif [ "$i" == "pacman" ]
		then
			lpms=$i
			break
		fi
	fi
done

if [ -z $lpms ]; then
	echo ""
	echo "could not be detected package management system"
	echo ""
	exit 0
fi

##########
# Uninstall old versions
##########
echo ""
echo ""
echo "======================================================================="
echo "| Older versions of Docker were called docker, docker.io, or docker-engine."
echo "| If these are installed or all conflicting packages, uninstall them."
echo "======================================================================="
echo ""
sleep 2

# linux remove command for pms
if [ "$lpms" == "apk" ]
then
	sudo apk del docker podman-docker
elif [ "$lpms" == "dnf" ]
then
	sudo dnf remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-selinux docker-engine-selinux docker-engine
elif [ "$lpms" == "yum" ]
then
	sudo yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine podman runc
elif [ "$lpms" == "apt" ]
then
	for pkg in docker docker-engine docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt remove $pkg; done
elif [ "$lpms" == "zypper" ]
then
	if [[ $(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"') == *"sles"* ]]
	then
		sudo zypper remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine runc
	fi
elif [ "$lpms" == "pacman" ]
then
	sudo pacman -Rssn podman-docker podman-compose
else
	echo ""
	echo "could not be detected package management system"
	echo ""
	exit 0
fi

echo ""
echo "Done ✓"
echo "======================================================================="

##########
# Install Docker
##########
echo ""
echo ""
echo "======================================================================="
echo "| Install Docker..."
echo "======================================================================="
echo ""
sleep 2

if [ "$lpms" == "apk" ]
then
	sudo apk add --update docker openrc bind-tools
	sudo rc-update add docker boot
	sudo service docker start
elif [ "$lpms" == "dnf" ]
then
	sudo dnf -y install dnf-plugins-core
	if [[ $(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"') == "fedora" ]] || ([[ $(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"') == "rhel" ]] && [ $(sudo uname -m) == "s390x" ])
	then
		sudo dnf config-manager --add-repo https://download.docker.com/linux/$(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"')/docker-ce.repo
		sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin bind-utils
	elif [[ $(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"') != "rhel" ]]
	then
		sudo dnf install docker
	else
		echo ""
		echo "unsupport operation system and/or architecture"
		echo ""
		exit 0
	fi
elif [ "$lpms" == "yum" ]
then
	sudo yum install -y yum-utils
	if [[ $(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"') == "centos" ]] || ([[ $(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"') == "rhel" ]] && [ $(sudo uname -m) == "s390x" ])
	then
		sudo yum-config-manager --add-repo https://download.docker.com/linux/$(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"')/docker-ce.repo
		sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin bind-utils
	elif [[ $(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"') != "rhel" ]]
	then 
		sudo yum install docker
	else
		echo ""
		echo "unsupport operation system and/or architecture"
		echo ""
		exit 0
	fi
elif [ "$lpms" == "zypper" ]
then
	if [[ $(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"') == *"sles"* ]] && [ $(sudo uname -m) == "s390x" ]
	then
		# "https://download.opensuse.org/repositories/security:/SELinux/openSUSE_Factory/security:SELinux.repo"
		sudo zypper addrepo "https://download.opensuse.org/repositories/security/$(grep -Pow 'VERSION_ID=\K[^;]*' /etc/os-release | tr -d '"')/security.repo"
		sudo zypper addrepo https://download.docker.com/linux/sles/docker-ce.repo
		sudo zypper install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
	else
		sudo SUSEConnect -p sle-module-containers/$(sudo uname -s)/$(sudo uname -m) -r ''
		sudo zypper install docker
	fi

	#Installed=`sudo zypper search --installed-only -v docker | sed -n '6p' | cut -c 28-40`
	#Candidate=`sudo zypper info docker | sed -n '10p' | cut -c 18-`
elif [ "$lpms" == "apt" ]
then
	sudo apt update
	sudo apt install ca-certificates curl gnupg lsb-release
	sudo mkdir -m 0755 /etc/apt/keyrings
	sudo curl -fsSL https://download.docker.com/linux/$(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"')/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
	sudo chmod a+r /etc/apt/keyrings/docker.gpg
	# Add the repository to Apt sources:
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/$(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"') $(grep -Po 'VERSION_CODENAME=\K[^;]*' /etc/os-release) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt update
	sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
	
	# sudo uname -r
	# sudo apt-get dist-upgrade -y
	# sudo reboot
	curl https://releases.rancher.com/install-docker/20.10.sh | sh
	sudo apt-get update

	#Installed=`sudo apt-cache policy docker-ce | sed -n '2p' | cut -c 14-`
	#Candidate=`sudo apt-cache policy docker-ce | sed -n '3p' | cut -c 14-`
elif [ "$lpms" == "pacman" ]
then
	sudo pacman -Syu --noconfirm
	sudo pacman -Ss docker docker-buildx
else
	echo ""
	echo "could not be detected package management system"
	echo ""
	exit 0
fi

#sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
#if [[ "$Installed" != "$Candidate" ]]; then
#	sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
#elif [[ "$Installed" == "$Candidate" ]]; then
#	echo ""
#	echo 'docker currently version already installed.'
#fi

cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

##########
# install iptables
# make sure that missing iptables modules are loaded into kernel:
##########

cat <<EOF | sudo tee /etc/modules-load.d/modules.conf
iptable_nat
iptable_filter
EOF

sudo modprobe iptable_nat
sudo modprobe iptable_filter

##########
# sysctl params required by setup, params persist across reboots
##########
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sudo sed -i 's/-net.ipv4.conf.all.promote_secondaries/#net.ipv4.conf.all.promote_secondaries/g' /usr/lib/sysctl.d/50-default.conf
sudo sed -i 's/-net.ipv4.ping_group_range/#net.ipv4.ping_group_range/g' /usr/lib/sysctl.d/50-default.conf

##########
# Apply sysctl params without reboot
##########
sudo sysctl --system

if [ $? -ne 0 ]
then
	exit 0
fi

if [ $lpms != "apk" ]
then
	sudo systemctl enable docker.service
	sudo systemctl enable containerd.service
	sudo systemctl start docker
fi

echo ""
echo "Done ✓"
echo "======================================================================="

##########
# Run Docker without sudo rights
##########
echo ""
echo ""
echo "======================================================================="
echo "| Running Docker without sudo rights..."
echo "======================================================================="
echo ""
sleep 2

sudo groupadd docker
sudo usermod -aG docker ${USER}
# su - ${USER} &

echo ""
echo "Done ✓"
echo "======================================================================="

##########
# Install Docker Compose
##########
echo ""
echo ""
echo "======================================================================="
echo "| Installing Docker Compose v2.32.4..."
echo "======================================================================="
echo ""
sleep 2

sudo mkdir -p /usr/local/lib/docker/cli-plugins
sudo curl -SL "https://github.com/docker/compose/releases/download/v2.32.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/lib/docker/cli-plugins/docker-compose
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

echo ""
echo "Done ✓"
echo "======================================================================="

##########
# permission for Docker daemon socket
##########
echo ""
echo ""
echo "======================================================================="
echo "| permission for Docker daemon socket..."
echo "======================================================================="
echo ""
sleep 2

sudo chmod 666 /var/run/docker.sock

echo ""
echo "Done ✓"
echo "======================================================================="

clear
##########
# Setup project variables
##########
echo ""
echo ""
echo "======================================================================="
echo "| Please enter project related variables..."
echo "======================================================================="
echo ""
sleep 2

# set the host
which_h=""
items=("localhost" "remotehost")
PS3="which computer command line are you on? Select the host: "
select h in "${items[@]}"
do
	case $REPLY in
		1)
			which_h=$h
			break;;
		2)
			which_h=$h
			break;;
		*)
			echo "Invalid choice $REPLY";;
	esac
done
echo "Ok."

# set your domain name
if [ "$which_h" == "localhost" ]
then
	read -p 'Enter Domain Name(default : localhost or e.g. : example.com): ' domain_name
	: ${domain_name:=localhost}
	[ "$domain_name" != "localhost" ] && sudo -- sh -c -e "grep -qxF '127.0.0.1  $domain_name' /etc/hosts || echo '127.0.0.1  $domain_name' >> /etc/hosts"
else
	domain_name=""
	read -p 'Enter Domain Name(e.g. : example.com): ' domain_name
	#[ "$domain_name" != "localhost" ] && sudo -- sh -c -e "sed -i '/$domain_name/d' /etc/hosts"
fi
[ -z $domain_name ] && domain_name="NULL"
host -N 0 $domain_name 2>&1 > /dev/null
while [ $? -ne 0 ]
do
	echo "Try again"
	sudo -- sh -c -e "sed -i '/$domain_name/d' /etc/hosts"
	if [ "$which_h" == "localhost" ]
	then
		read -p 'Enter Domain Name(default : localhost or e.g. : example.com): ' domain_name
		: ${domain_name:=localhost}
		[ "$domain_name" != "localhost" ] && sudo -- sh -c -e "grep -qxF '127.0.0.1  $domain_name' /etc/hosts || echo '127.0.0.1  $domain_name' >> /etc/hosts"
	else
		read -p 'Enter Domain Name(e.g. : example.com): ' domain_name
		#[ "$domain_name" != "localhost" ] && sudo -- sh -c -e "sed -i '/$domain_name/d' /etc/hosts"
	fi
	[ -z $domain_name ] && domain_name="NULL"
	host -N 0 $domain_name 2>&1 > /dev/null
done
echo "Ok."

ssl_snippet=""
if [ "$which_h" == "localhost" ]
then
	ssl_snippet="echo 'Generated Self-signed SSL Certificate at localhost'"
	if [ "$lpms" == "apk" ]
	then
		sudo apk add --no-cache nss-tools go git
	elif [ "$lpms" == "dnf" ]
	then
		sudo dnf install nss-tools go git
	elif [ "$lpms" == "yum" ]
	then
		sudo yum install nss-tools go git
	elif [ "$lpms" == "zypper" ]
	then
		sudo zypper install mozilla-nss-tools go git
	elif [ "$lpms" == "apt" ]
	then
		sudo apt install libnss3-tools go git
	elif [ "$lpms" == "pacman" ]
	then
		sudo pacman -S nss go git
	else
		echo ""
		echo "could not be detected package management system"
		echo ""
		exit 0
	fi
	sudo rm -Rf mkcert && git clone https://github.com/FiloSottile/mkcert && cd mkcert && go build -ldflags "-X main.Version=$(git describe --tags)"
	sudo mkcert -uninstall && mkcert -install && mkcert -key-file privkey.pem -cert-file chain.pem $domain_name *.$domain_name && sudo cat privkey.pem chain.pem > fullchain.pem && sudo mkdir -p ../certbot/live/$domain_name && sudo mv *.pem ../certbot/live/$domain_name && cd ..
	echo "Ok."
else
	ssl_snippet="certbot certonly --webroot --webroot-path \/tmp\/acme-challenge --rsa-key-size 4096 --non-interactive --agree-tos --no-eff-email --force-renewal --email \$\{LETSENCRYPT_EMAIL\} -d \$\{DOMAIN_NAME\} -d www.\$\{DOMAIN_NAME\}"
fi

# set parameters in env.example file
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

local_timezone_regex="^[a-zA-Z0-9/+_-]{1,}$"
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
  y|Y ) clear; echo ""; echo "Yes! Proceeding now...";;
  n|N ) echo "No! Aborting now..."; exit 0;;
  * ) echo "Invalid input! Aborting now..."; exit 0;;
esac

\cp env.example .env

sed -i 's/example.com/'$domain_name'/' .env
sed -i 's/email@domain.com/'$email'/' .env
sed -i "s/ssl_snippet/$ssl_snippet/" .env										 
sed -i "s@directory_path@$(pwd)@" .env
sed -i 's/local_timezone/'$local_timezone'/' .env

if [ -x "$(command -v docker)" ] && [ "$(docker compose version)" ]; then	
	# Firstly: create external volume
	docker volume create --driver local --opt type=none --opt device=`pwd`/certbot --opt o=bind certbot-etc > /dev/null
	# installing Rancher and the other services
	docker compose up -d & export pid=$!
	echo "Rancher and the other services installing proceeding..."
	echo ""
	wait $pid
	if [ $? -eq 0 ]
	then
		# installing portainer
		docker compose -f portainer-docker-compose.yml -p portainer up -d & export pid=$!
		echo ""
		echo "portainer installing proceeding..."
		wait $pid
		if [ $? -ne 0 ]; then
			echo "Error! could not installed portainer" >&2
			exit 1
		else
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
			echo "Portainer: https://$domain_name:9001"								 
			echo ""
			echo "Ok."
		fi
	else
		echo ""
		echo "Error! could not installed Rancher and the other services with docker compose" >&2
		echo ""
		exit 1
	fi
else
	echo ""
	echo "not found docker and/or docker compose, Install docker and/or docker compose" >&2
	echo ""
	exit 1
fi
