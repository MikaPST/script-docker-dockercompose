<p align=center>
<img src="https://github.com/MikaPST/script-docker-dockercompose/blob/main/logo-script-DockerAndDockerCompose.png?raw=true" height="350">
</p><br>

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

# 📜Script Install Docker and Docker-Compose (Debian/Debian-based)
This script is a Bash script that aims to install **Docker** and **Docker Compose** in their latest versions on an Debian/Debian-based system.

The goal is to provide a single command that can perform a clean and quick installation of these two tools. After the installation, the git folder is deleted.

The script is compatible with Debian and other versions based on Debian.

```bash
mkdir setup_docker \
&& curl -o setup_docker/start.sh https://raw.githubusercontent.com/MikaPST/script-docker-dockercompose/main/start.sh \
&& chmod +x setup_docker/start.sh \
&& sudo ./setup_docker/start.sh \
&& rm -r setup_docker/
```

## ℹ️ Prerequisites:
> **1.** *Any hardware or vps/vds server running Linux. You should have administrative rights on this machine.*

> **2.** *The machine must have internet access.*

# 🔎 Detailed Description of the Script 

* Checks if the necessary dependencies are installed, namely the lsb_release command. If it is not installed, the script displays a message to the user indicating that the lsb-release package is not installed and proceeds to install it using the apt-get command.

* Updates the distribution using the apt-get update command followed by the apt-get -y dist-upgrade command. Then, the script executes the apt-get -y autoremove --purge and apt-get autoclean commands to remove old packages and unnecessary files.

* Uninstalls old versions of Docker using the apt-get remove command.

* Installs the necessary dependencies for Docker, namely the ca-certificates, curl, and gnupg packages, using the apt-get install command.

* Sets environment variables for sensitive information. These variables contain the necessary information to add the official Docker repository, such as the GPG key and the repository URL.

* Adds the GPG key of the official Docker repository by downloading the key from the URL defined earlier and adding it to the /etc/apt/keyrings/docker.gpg directory. This part of the script also configures the Docker repository by adding a new line to the /etc/apt/sources.list.d/docker.list file.

* Installs Docker using the apt-get install command by adding the docker-ce, docker-ce-cli, containerd.io, docker-buildx-plugin, and docker-compose-plugin packages.

* Checks if Docker is running using the systemctl is-active --quiet docker command. If Docker is not running, the script displays a message to the user.

* Shecks if Docker has been successfully installed using the docker --version | grep -q "Docker version" command. If Docker has not been successfully installed, the script displays a message to the user.

* Downloads and installs the latest version of Docker Compose using the curl command. Then, the script modifies the permissions of the docker-compose file to make it executable. Finally, the script displays a message to the user indicating that Docker Compose has been successfully installed.

## ⚠️ Note
**Once the installation is complete. The installation folder is deleted.**

# 📖 Other Resources
[Doc Install Docker](https://docs.docker.com/engine/install/ubuntu/)<br>
[Doc Install Docker-Compose](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04)<br>
