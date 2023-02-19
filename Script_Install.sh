#!/bin/bash

# Vérification que les dépendances nécessaires sont installées
if ! command -v lsb_release > /dev/null 2>&1; then
    echo "Le paquet lsb-release n'est pas installé. Installation en cours..."
    apt-get update && apt-get install -y lsb-release
fi

# Mise à jour de la distribution
apt-get update && apt-get -y dist-upgrade
apt-get -y autoremove --purge && apt-get autoclean

# Désinstallation des vieilles versions de Docker
apt-get remove docker docker-engine docker.io containerd runc

# Installation du Dépot Officiel de Docker
apt-get update
apt-get install -y \
    ca-certificates \
    curl \
    gnupg

# Définition des variables d'environnement pour les informations sensibles
DOCKER_KEYRING_DIR="/etc/apt/keyrings"
DOCKER_GPG_KEY="https://download.docker.com/linux/ubuntu/gpg"
DOCKER_REPO_URL="https://download.docker.com/linux/ubuntu"
DOCKER_ARCHITECTURE=$(dpkg --print-architecture)

# Ajout de la clé GPG du Docker Officiel
mkdir -m 0755 -p "$DOCKER_KEYRING_DIR"
curl -fsSL "$DOCKER_GPG_KEY" | sudo gpg --dearmor -o "$DOCKER_KEYRING_DIR/docker.gpg"

# Configuration du Dépot
echo \
  "deb [arch=$DOCKER_ARCHITECTURE signed-by=$DOCKER_KEYRING_DIR/docker.gpg] $DOCKER_REPO_URL \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null ;

# Installation du paquet Docker
apt-get update -y
chmod a+r "$DOCKER_KEYRING_DIR/docker.gpg"
apt-get update -y
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Vérification de l'installation de Docker
if ! systemctl is-active --quiet docker; then
    echo "Docker n'est pas en cours d'exécution."
fi

if ! docker --version | grep -q "Docker version"; then
    echo "Erreur lors de l'installation de Docker."
fi

# Télécharger et installer la dernière version de Docker Compose
LATEST_RELEASE=$(curl --silent "https://api.github.com/repos/docker/compose/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
sudo curl -L "https://github.com/docker/compose/releases/download/$LATEST_RELEASE/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Afficher la version de Docker Compose installée
echo "Docker Compose version $LATEST_RELEASE a été installé avec succès."

# Suppression du dossier d'installation
sudo rm -r script-install-docker-dockercompose-ubuntu
