#!/bin/bash

#docker installation      
#install docker dependencies 
sudo apt-get install ca-certificates curl gnupg lsb-release -y

#add docker’s official GPG key
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

#set up the stable repository.
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

#update the packages
sudo apt update -y

#install Docker from their repo instead
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

#adds your username to the docker group
sudo usermod -aG docker ${USER}

#install docker-compose
sudo apt-get update
sudo apt-get install docker-compose-plugin

echo -e "\e[1;34mDocker and Docker Compose have been installed.\e[0m"