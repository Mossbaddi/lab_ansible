#!/usr/bin/env bash

# Installation du serveur SSH
apt-get update
apt-get install -y openssh-server

# Active l'authentification par mot de passe pour SSH
sed -i 's/^#\s*PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config


sed -i 's/^#\?\s*PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config

# Redémarre le service SSH pour prendre en compte les modifications
service ssh restart


echo "root:password" | chpasswd

# Installation des paquets nécessaires
apt update && apt -y install curl wget net-tools iputils-ping python3-pip sshpass

# Installer Ansible en utilisant pip uniquement sur le noeud "controller"
# Nous utilisons le nom du conteneur pour déterminer s'il s'agit du "controller"
if [[ $(hostname) = "controller" ]]; then
   pip3 install ansible
fi
