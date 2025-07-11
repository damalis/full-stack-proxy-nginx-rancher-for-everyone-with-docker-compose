# [full stack proxy nginx Rancher for everyone with docker compose](https://github.com/damalis/full-stack-proxy-nginx-rancher-for-everyone-with-docker-compose)

If You want to install Rancher at short time;

#### Full stack Proxy Nginx Rancher:
<p align="left"> <a href="https://www.rancher.com/" target="_blank" rel="noreferrer"> <img src="https://avatars.githubusercontent.com/u/9343010?s=200&v=4" alt="rancher" height="40" width="40"/> </a>&nbsp;&nbsp;&nbsp; 
<a href="https://kubernetes.io/" target="_blank" rel="noreferrer"> <img src="https://avatars.githubusercontent.com/u/13629408?s=200&v=4" alt="kubernetes" height="40" width="40"/> </a>&nbsp;&nbsp;&nbsp; 
<a href="https://www.docker.com/" target="_blank" rel="noreferrer" style="text-decoration: none;"> <img src="https://raw.githubusercontent.com/github/explore/80688e429a7d4ef2fca1e82350fe8e3517d3494d/topics/docker/docker.png" alt="docker" width="40" height="40" width="40"/> </a>&nbsp;&nbsp;&nbsp; 
<a href="https://www.nginx.com" target="_blank" rel="noreferrer"> <img src="https://avatars.githubusercontent.com/u/1412239?s=200&v=4" alt="nginx" height="40" width="40"/> </a>&nbsp;&nbsp;&nbsp; 
<a href="https://en.wikipedia.org/wiki/Bash_(Unix_shell)" target="_blank" rel="noreferrer" style="text-decoration: none;"> <img src="https://raw.githubusercontent.com/github/explore/80688e429a7d4ef2fca1e82350fe8e3517d3494d/topics/bash/bash.png" alt="Bash" height="50" width="50" style="max-width: 100%;"> </a>&nbsp;&nbsp;&nbsp; 
<a href="https://letsencrypt.org/" target="_blank" rel="noreferrer" style="text-decoration: none;"> <img src="https://avatars.githubusercontent.com/u/17889013?s=200&v=4" alt="letsencrypt" height="40" width="40"/> </a>&nbsp;&nbsp;&nbsp; 
<a href="https://certbot.eff.org/" target="_blank" rel="noreferrer"> <img src="https://avatars.githubusercontent.com/u/17889013?s=200&v=4" alt="certbot" height="40" width="40"/> </a>&nbsp;&nbsp;&nbsp; 
<a href="https://www.offen.dev/" target="_blank" rel="noreferrer"> <img src="https://avatars.githubusercontent.com/u/47735043?s=200&v=4" alt="backup" height="35" width="35"/> </a> </p>

Plus, manage docker containers with Portainer.

#### Supported CPU architectures:
<p align="left"> arm64/aarch64, x86-64 </p>

#### Supported Linux Package Manage Systems:
<p align="left"> apk, dnf, yum, apt/apt-get, zypper, pacman </p>
 
#### Supported Linux Operation Systems:
<p align="left"> <a href="https://alpinelinux.org/" target="_blank" rel="noreferrer"> <img src="https://avatars.githubusercontent.com/u/7600810?s=200&v=4" alt="alpine linux" height="40" width="40"/> </a>&nbsp;&nbsp;&nbsp; 
<a href="https://fedoraproject.org/" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/github/explore/e6b1e7f0fb8d0bf920bd719c7289243138bdc1b4/topics/fedora/fedora.png" alt="fedora" height="40" width="40"/> </a>&nbsp;&nbsp;&nbsp; 
<a href="https://www.centos.org/" target="_blank" rel="noreferrer"> <img src="https://avatars.githubusercontent.com/u/79192?s=200&v=4" alt="centos" height="40" width="40"/> </a>&nbsp;&nbsp;&nbsp; 
<a href="https://www.debian.org/" target="_blank" rel="noreferrer"> <img src="https://avatars.githubusercontent.com/u/1854028?s=200&v=4" alt="debian" height="40" width="40"/> </a>&nbsp;&nbsp;&nbsp; 
<a href="https://ubuntu.com/" target="_blank" rel="noreferrer"> <img src="https://avatars.githubusercontent.com/u/4604537?s=200&v=4" alt="ubuntu" height="40" width="40"/> </a>&nbsp;&nbsp;&nbsp; 
<a href="https://www.raspberrypi.com/" target="_blank" rel="noreferrer"> <img src="https://avatars.githubusercontent.com/u/1294177?s=200&v=4" alt="ubuntu" height="40" width="40"/> </a>&nbsp;&nbsp;&nbsp; 
<a href="https://www.redhat.com/en/technologies/linux-platforms/enterprise-linux" target="_blank" rel="noreferrer"> <img src="https://avatars.githubusercontent.com/u/33972111?s=200&v=4" alt="redhat on s390x (IBM Z)" height="40" width="40"/> </a>&nbsp;&nbsp;&nbsp; 
<a href="https://www.suse.com/products/server/" target="_blank" rel="noreferrer"> <img src="https://avatars.githubusercontent.com/u/623819?s=200&v=4" alt="opensuse on s390x (IBM Z)" height="40" width="40"/> </a>&nbsp;&nbsp;&nbsp; 
<a href="https://archlinux.org/" target="_blank" rel="noreferrer"> <img src="https://gitlab.archlinux.org/uploads/-/system/group/avatar/23/iconfinder_archlinux_386451.png?width=48" alt="arch linux" height="40" width="40"/> </a> </p>

##### Note: Fedora 37, 39 and alpine linux x86-64 compatible, could not try sles IBM Z s390x, rhel IBM Z s390x and raspberrypi.
																																																												  
#### With this project you can quickly run the following:

- [Rancher](https://hub.docker.com/r/rancher/rancher)
- [proxy (nginx)](https://hub.docker.com/_/nginx)
- [certbot (letsencrypt)](https://hub.docker.com/r/certbot/certbot)
- [backup](https://hub.docker.com/r/offen/docker-volume-backup)

#### For certbot (letsencrypt) certificate:

- [Set DNS configuration of your domain name](https://support.google.com/a/answer/48090?hl=en)

#### IPv4/IPv6 Firewall
Create rules to open ports to the internet, or to a specific IPv4 address or range.

- http: 80
- https: 443
- portainer: 9001

#### Contents:

- [Auto Configuration and Installation](#automatic)
- [Requirements](#requirements)
- [Manual Configuration and Installation](#manual)
- [Usage](#usage)
	- [Proxy](#proxy)
    - [backup](#backup)

## Automatic

### Exec install shell script for auto installation and configuration

download with

```
git clone https://github.com/damalis/full-stack-proxy-nginx-rancher-for-everyone-with-docker-compose.git
```

Open a terminal and `cd` to the folder in which `docker-compose.yml` is saved and run:

```
cd full-stack-proxy-nginx-rancher-for-everyone-with-docker-compose
chmod +x install.sh
./install.sh
```

## Requirements

Make sure you have the latest versions of **Docker** and **Docker Compose** installed on your machine.

### These CPU and memory requirements apply to a host with a single-node installation of Rancher

| Deployment Size | Clusters | Nodes | vCPUs | RAM |
|---|---|---|---|---|
| Small | Up to 5 | Up to 50 | 1 | 4 GB |
| Medium | Up to 15 | Up to 200 | 2 | 8 GB |

- [How install docker](https://ranchermanager.docs.rancher.com/v2.6/getting-started/installation-and-upgrade/installation-requirements/install-docker)
- [How install docker compose](https://docs.docker.com/compose/install/)

Clone this repository or copy the files from this repository into a new folder.

Make sure to [add your user to the `docker` group](https://docs.docker.com/install/linux/linux-postinstall/#manage-docker-as-a-non-root-user).

## Manual

### Configuration
				 
download with
```
git clone https://github.com/damalis/full-stack-proxy-nginx-rancher-for-everyone-with-docker-compose.git
```

Open a terminal and `cd` to the folder in which `docker-compose.yml` is saved and run:

```
cd full-stack-proxy-nginx-rancher-for-everyone-with-docker-compose
```

Copy the example environment into `.env`

```
cp env.example .env
```

Edit the `.env` file to change values of ```LOCAL_TIMEZONE```, ```DOMAIN_NAME```, ```DIRECTORY_PATH```, ```LETSENCRYPT_EMAIL``` and ```SSL_SNIPPET```.

LOCAL_TIMEZONE=[to see local timezones](https://docs.diladele.com/docker/timezones.html)

DIRECTORY_PATH=```pwd``` at command line
SSL_SNIPPET=```echo 'Generated Self-signed SSL Certificate at localhost'``` for localhost\
SSL_SNIPPET=```certbot certonly --webroot --webroot-path /tmp/acme-challenge --rsa-key-size 4096 --non-interactive --agree-tos --no-eff-email --force-renewal --email ${LETSENCRYPT_EMAIL} -d ${DOMAIN_NAME} -d www.${DOMAIN_NAME}``` for remotehost

### Installation

Firstly: will create external volume

```
docker volume create --driver local --opt type=none --opt device=${PWD}/certbot --opt o=bind certbot-etc
```

for localhost ssl: Generate Self-signed SSL Certificate with guide [mkcert repository](https://github.com/FiloSottile/mkcert).

```
docker compose up -d
```

then reloading for proxy ssl configuration

```
docker container restart proxy
```

The containers are now built and running. You should be able to access the rancher installation with the configured IP in the browser address. `https://example.com`.

For convenience you may add a new entry into your hosts file.

## Portainer

```
docker compose -f portainer-docker-compose.yml -p portainer up -d 
```

manage docker with [Portainer](https://www.portainer.io/) is the definitive container management tool for Docker, Docker Swarm with it's highly intuitive GUI and API. 

You can also visit `https://example.com:9001` to access portainer after starting the containers.

## Usage

#### You could manage docker containers without command line with portainer.

### Show both running and stopped containers

The docker ps command only shows running containers by default. To see all containers, use the -a (or --all) flag:

```
docker ps -a
```

### Starting containers

You can start the containers with the `up` command in daemon mode (by adding `-d` as an argument) or by using the `start` command:

```
docker compose start
```

### Stopping containers

```
docker compose stop
```

### Removing containers

To stop and remove all the containers use the `down` command:

```
docker compose down
```

to remove portainer and the other containers:

```
docker rm -f $(docker ps -a -q)
```

Use `-v` if you need to remove the database volume which is used to persist the database:

```
docker compose down -v
```

to remove external certbot-etc and portainer and the other volumes:

```
docker volume rm $(docker volume ls -q)
```

Delete all images, containers, volumes, and networks that are not associated with a container (dangling):

```
docker system prune
```

To additionally remove any stopped containers and all unused images (not just dangling ones), add the -a flag to the command:

```
docker system prune -a
```

to remove portainer and the other images:

```
docker rmi $(docker image ls -q)
```

### Logs containers

To fetch the logs of a container.

```
docker container logs container_name_or_id
```

### Project from existing source

Copy all files into a new directory:

You can now use the `up` command:

```
docker compose up -d
```

#### Docker run reference

[https://docs.docker.com/engine/reference/run/](https://docs.docker.com/engine/reference/run/)

#### Proxy

Proxying is typically used to distribute the load among several servers, seamlessly show content from different websites, or pass requests for processing to application servers over protocols other than HTTP.

add or remove code in the ```./proxy/templates/proxy.conf.template``` file for custom proxy configurations

[https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/)

### backup

This will back up the all files and folders in database/dump sql and html volumes, once per day, and write it to ./backups with a filename like backup-2023-01-01T10-18-00.tar.gz

#### can run on a custom cron schedule

```BACKUP_CRON_EXPRESSION: '20 01 * * *'``` the UTC timezone.
