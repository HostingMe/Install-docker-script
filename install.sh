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
REPO_OWNER="docker"
REPO_NAME="compose"

# Fetch the latest release information using GitHub API
latest_release=$(curl -s "https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/releases/latest")

# Extract the tag name (version) from the JSON response
latest_version=$(echo "$latest_release" | grep -o '"tag_name": "[^"]*' | cut -d'"' -f4)

# Construct the download URL using the extracted version and system architecture
download_url="https://github.com/${REPO_OWNER}/${REPO_NAME}/releases/download/${latest_version}/docker-compose-$(uname -s)-$(uname -m)"

# Download the latest release binary
sudo curl -L "$download_url" -o /usr/local/bin/docker-compose

# Make the downloaded binary executable
sudo chmod +x /usr/local/bin/docker-compose

echo -e "\e[1;34mDocker and Docker Compose have been installed.\e[0m"
