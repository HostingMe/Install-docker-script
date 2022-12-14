#!/bin/bash
PS3='What would you like to do? '
commands=("Install docker and docker compose" 
					"Remove stopped containers" 
					"Remove all unused images, volumes & networks" 
					"Stop and remove all containers" 
					"Stop all containers"
					"Remove all containers"
					"Remove all images"
					"Remove all volumes"
					"Remove all networks"
					"Stop and remove everything" 
					"Quit")
select choice in "${commands[@]}"; do
		case $choice in
				"Install docker and docker compose")
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
						break
						;;
				"Remove unused containers (prune)")
						docker container prune
						echo -e "\e[1;34mAll containers have been stopped.\e[0m" 
						break
						;;
				"Remove all unused images, volumes & networks")
						docker image prune -a
						docker volume prune
						docker network prune
						echo -e "\e[1;34mUnused images, volumes and networks removed.\e[0m" 
						break
						;;
				"Stop and remove all containers")
						docker stop `docker ps -qa`
						docker rm `docker ps -qa`
						echo -e "\e[1;34mContainers have been stopped and removed.\e[0m" 
						break
						;;
				"Stop all containers")
						docker stop `docker ps -qa`
						echo -e "\e[1;34mAll containers have been stopped.\e[0m" 
						break
						;;
				"Remove all containers")
						docker rm `docker ps -qa`
						echo -e "\e[1;34mAll containers have been removed.\e[0m" 
						break
						;;
				"Remove all images")
						docker rmi -f `docker images -qa `
						echo -e "\e[1;34mAll images have been removed.\e[0m" 
						break
						;;
				"Remove all volumes")
						docker volume  rm $(docker volume ls -qf)
						echo -e "\e[1;34mAll volumes have been removed.\e[0m" 
						break
						;;
				"Remove all networks")
						docker network rm `docker network ls -q`
						echo -e "\e[1;34mAll networks have been removed.\e[0m" 
						break
						;;
				"Stop and remove everything")
						docker stop `docker ps -qa`
						docker rm `docker ps -qa`
						docker rmi -f `docker images -qa `
						docker volume rm $(docker volume ls -qf)
						docker network rm `docker network ls -q`
						echo -e "\e[1;34mAll containers, images, volumes and networks removed.\e[0m"    
						break
						;;
		"Quit")
				echo -e "\e[1;34mNothing left to do, bye!\e[0m" 
				exit
				;;
				*) echo -e "\e[1;31m$REPLY is not a vaild option. Try again.\e[0m";;
		esac
done