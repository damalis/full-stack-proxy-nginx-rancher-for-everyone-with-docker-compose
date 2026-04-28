# [full stack proxy nginx Rancher for everyone with docker compose](https://github.com/damalis/full-stack-proxy-nginx-rancher-for-everyone-with-docker-compose)

If You want to install Rancher at short time;

#### Full stack Proxy Nginx Rancher:
[![Rancher](https://img.shields.io/badge/Rancher-0075A8?style=flat&logo=rancher&logoColor=white)](https://www.rancher.com/)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=flat&logo=kubernetes&logoColor=white)](https://kubernetes.io/)
[![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white)](https://www.docker.com/)
[![NGINX Proxy](https://img.shields.io/badge/NGINX-Reverse%20Proxy-009639?logo=nginx&logoColor=white)](https://nginx.com/)
[![Certbot](https://img.shields.io/badge/Certbot-003A70?style=flat&logo=letsencrypt&logoColor=white)](https://certbot.eff.org/)
[![Let's Encrypt](https://img.shields.io/badge/Let's%20Encrypt-003A70?style=flat&logo=letsencrypt&logoColor=white)](https://letsencrypt.org/)
[![Portainer](https://img.shields.io/badge/Portainer-13BEF9?style=flat&logo=portainer&logoColor=white)](https://www.portainer.io/?hsLang=en)
[![Docker Compose](https://img.shields.io/badge/Docker%20Compose-2496ED?style=flat&logo=docker&logoColor=white)](https://docs.docker.com/compose/)
[![Bash](https://img.shields.io/badge/Bash-4EAA25?style=flat&logo=gnubash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Backup](https://img.shields.io/badge/Backup-6C757D?style=flat&logo=icloud&logoColor=white)](https://www.offen.dev/)

Plus, manage docker containers with Portainer.

#### Supported CPU architectures:
![Linux-arm64/aarch64](https://img.shields.io/badge/Linux-arm64/aarch64-lightgrey)
![Linux-x86-64](https://img.shields.io/badge/Linux-X86--64-lightgrey)

#### Supported Linux Package Manage Systems:
![apk](https://img.shields.io/badge/apk-0D597F)
![dnf-yum](https://img.shields.io/badge/dnf-yum-73BA25)
![apt/apt-get](https://img.shields.io/badge/apt-apt--get-E95420)
![zypper](https://img.shields.io/badge/zypper-73BA25)
![pacman](https://img.shields.io/badge/pacman-1793D1)
 
#### Supported Linux Operation Systems:
[![Alpine Linux](https://img.shields.io/badge/alpine_linux-0D597F?style=flat&logo=alpine-linux&logoColor=white)](https://alpinelinux.org/)
[![Fedora](https://img.shields.io/badge/Fedora-blue?style=flat&logo=Fedora&logoColor=white)](https://fedoraproject.org/)
[![CentOS](https://img.shields.io/badge/CentOS-262577?style=flat-square&logo=CentOS&logoColor=white)](https://www.centos.org/)
[![Debian](https://img.shields.io/badge/debian-red?style=flat&logo=debian&logoColor=orange&color=darkred)](https://www.debian.org/)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=flat&logo=Ubuntu&logoColor=white)](https://www.ubuntu.com/)
[![Red Hat](https://img.shields.io/badge/Red_Hat-EE0000?style=flat&logo=redhat&logoColor=white)](https://www.redhat.com/en/technologies/linux-platforms/enterprise-linux)
[![openSUSE](https://img.shields.io/badge/openSUSE-73BA25?style=flat&logo=SUSE&logoColor=white)](https://www.opensuse.org/)
[![Arch Linux](https://img.shields.io/badge/Arch%20Linux-1793D1?style=flat&logo=arch-linux&logoColor=fff)](https://archlinux.org/)
[![Raspberry Pi](https://img.shields.io/badge/Raspberry%20Pi-red?logo=raspberrypi)](https://www.raspberrypi.com/)

##### Note: Fedora 37, 39 and alpine linux x86-64 compatible, could not try sles IBM Z s390x, rhel IBM Z s390x and raspberrypi.
##### After installing the repository, a system reboot is required on Red Hat OS, Arch Linux.
																																																												  
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

#### Requirements

Make sure you have the latest versions of **Docker** and **Docker Compose** installed on your machine.

#### These CPU and memory requirements apply to a host with a single-node installation of Rancher

| Deployment Size | Clusters | Nodes | vCPUs | RAM |
|---|---|---|---|---|
| Small | Up to 5 | Up to 50 | 1 | 4 GB |
| Medium | Up to 15 | Up to 200 | 2 | 8 GB |

#### Contents:

- [Auto Configuration and Installation](#automatic)
- [Manual Configuration and Installation](#manual)
	- [Requirements](#requirements)
	- [Configuration](#configuration)
	- [Installation](#installation)
- [Usage](#usage)
	- [Proxy](#proxy)
    - [backup](#backup)

### Automatic

#### Exec install shell script for auto installation and configuration

download with

```
git clone https://github.com/damalis/full-stack-proxy-nginx-rancher-for-everyone-with-docker-compose.git
```

Open a terminal and `cd` to the folder in which `docker-compose.yml` is saved and run:

```
cd full-stack-proxy-nginx-rancher-for-everyone-with-docker-compose
chmod +x install.sh
LC_ALL=C.UTF-8 ./install.sh # LC_ALL=C.UTF-8 if not os language english
```

### Manual

- [How install docker](https://ranchermanager.docs.rancher.com/v2.12/getting-started/installation-and-upgrade/installation-requirements/install-docker)
- [How install docker compose](https://docs.docker.com/compose/install/)

Clone this repository or copy the files from this repository into a new folder.

Make sure to [add your user to the `docker` group](https://docs.docker.com/install/linux/linux-postinstall/#manage-docker-as-a-non-root-user).

#### Configuration
				 
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

Edit the `.env` file to change values of

|```LOCAL_TIMEZONE```|```DOMAIN_NAME```|```DIRECTORY_PATH```|```LETSENCRYPT_EMAIL```|```SSL_SNIPPET```|

<table><thead>
  <tr>
    <th>Variable </th>
    <th colspan="2">Value</th>
  </tr></thead>
<tbody>
  <tr>
    <td><code>LOCAL_TIMEZONE</code></td>
    <td colspan="2"><code><a href="https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List" rel="nofollow">to see local timezones</a></code></td>
  </tr>
  <tr>
    <td><code>DIRECTORY_PATH</code></td>
    <td colspan="2"><code>pwd</code> at command line</td>
  </tr>
  <tr>
    <td rowspan="2"><code>SSL_SNIPPET</code></td>
    <td>localhost</td>
    <td><code>echo 'Generated Self-signed SSL Certificate at localhost'</code></td>
  </tr>
  <tr>
    <td>remotehost</td>
    <td><code>certbot certonly --webroot --webroot-path /tmp/acme-challenge --rsa-key-size 4096 --non-interactive --agree-tos --no-eff-email --force-renewal --email ${LETSENCRYPT_EMAIL} -d ${DOMAIN_NAME} -d www.${DOMAIN_NAME}</code></td>
  </tr>
</tbody>
</table>

#### Installation

Firstly: will create external volume

```
docker volume create --driver local --opt type=none --opt device=${PWD}/certbot --opt o=bind certbot-etc
```

Localhost ssl: Generate Self-signed SSL Certificate with guide [mkcert repository](https://github.com/FiloSottile/mkcert).

```
docker compose up -d
```

then reloading for proxy ssl configuration

```
docker container restart proxy
```

The containers are now built and running. You should be able to access the rancher installation with the configured IP in the browser address. `https://DOMAIN_NAME`.

For convenience you may add a new entry into your hosts file.

### Portainer

```
docker compose -f portainer-docker-compose.yml -p portainer up -d 
```

manage docker with [Portainer](https://www.portainer.io/) is the definitive container management tool for Docker, Docker Swarm with it's highly intuitive GUI and API. 

You can also visit `https://DOMAIN_NAME:9001` to access portainer after starting the containers.

### Usage

#### You could manage docker containers without command line with portainer.

#### Here’s a quick reference of commonly used Docker Compose commands

```
docker ps -a # Lists all containers managed by the compose file
```

```
docker compose start # Starts previously stopped containers
```

```
docker compose stop # Stops all running containers
```

```
docker compose down # Stops and removes containers, networks, etc.
```

```
docker compose down -v # Add --volumes to remove volumes explicitly
```

```
docker rm -f $(docker ps -a -q) # Removes portainer and the other containers
```

```
docker volume rm $(docker volume ls -q) # Removes all volumes
```

```
docker network prune # Remove all unused networks
```

```
docker system prune # Removes unused data (containers, networks, images, and optionally volumes)
```

```
docker system prune -a # Removes all unused images, not just dangling ones
```

```
docker rmi $(docker image ls -q) # Removes portainer and the other images
```

```
docker container logs container_name_or_id # Shows logs from all services
```

#### Project from existing source

Copy all files into a new directory:

```
docker compose up -d # Starts services in detached mode (in the background)
```

#### Docker run reference

[https://docs.docker.com/reference/cli/docker/compose/](https://docs.docker.com/reference/cli/docker/compose/)

#### Rancher

[Rancher](https://ranchermanager.docs.rancher.com/?_gl=1*15eypsy*_ga*NTk3MTM3NzA4LjE3NTA0Mzg4MTc.*_ga_Y7SFXF9L00*czE3NjAwODE4NTMkbzYkZzEkdDE3NjAwODE5ODAkajU5JGwwJGgw) is a Kubernetes management tool to deploy and run clusters anywhere and on any provider.
Rancher can provision Kubernetes from a hosted provider, provision compute nodes and then install Kubernetes onto them, or import existing Kubernetes clusters running anywhere.

#### Proxy

Proxying is typically used to distribute the load among several servers, seamlessly show content from different websites, or pass requests for processing to application servers over protocols other than HTTP.

add or remove code in the ```./proxy/templates/proxy.conf.template``` file for custom proxy configurations

[https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/)

#### backup

This will back up the all files and folders in database/dump sql and html volumes, once per day, and write it to ```./backups``` with a filename like backup-2023-01-01T10-18-00.tar.gz

##### can run on a custom cron schedule

```BACKUP_CRON_EXPRESSION: '20 01 * * *'``` the UTC timezone.
