#!/bin/bash

#docker installation      
echo "Installing docker..."

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
       
echo "docker successfully installed."

echo "docker already installed, installing wordpress and mariaDB..."

#create local directories for mariaDB and Wordpress
mkdir ~/wordpress 
cd ~/wordpress

#pull the mariaDB image from docker
read -p "Please enter a database password: " dbpassword
sudo docker run -e MYSQL_ROOT_PASSWORD=$dbpassword -e MYSQL_DATABASE=wordpress --name wordpressdb -v "$PWD/database":/var/lib/mysql -d mariadb:latest

#pull the wordpress image from docker
sudo docker run -e WORDPRESS_DB_USER=root -e WORDPRESS_DB_PASSWORD=$dbpassword --name wordpress --link wordpressdb:mysql -p 80:80 -v "$PWD/html":/var/www/html -d wordpress
