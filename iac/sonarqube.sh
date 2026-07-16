#!/bin/bash

sudo hostnamectl set-hostname "sonarqube.mypc.com"
echo "`hostname -I | awk '{ print $1 }'` `hostname`" >> /etc/hosts
sudo apt-get update
# sudo apt-get install git wget unzip zip curl tree -y
apt-get install -y docker.io git curl unzip
sudo usermod -aG docker ubuntu
sudo chmod 777 /var/run/docker.sock
sudo systemctl enable docker
sudo systemctl start docker
sudo docker pull sonarqube:lts-community
sudo docker images
docker volume create sonarqube-conf
docker volume create sonarqube-data
docker volume create sonarqube-logs
docker volume create sonarqube-extensions
#docker volume inspect sonarqube-conf
#docker volume inspect sonarqube-data
#docker volume inspect sonarqube-logs
#docker volume inspect sonarqube-extensions
sudo mkdir /sonarqube
ln -s /var/lib/docker/volumes/sonarqube-conf/_data /sonarqube/conf
ln -s /var/lib/docker/volumes/sonarqube-data/_data /sonarqube/data
ln -s /var/lib/docker/volumes/sonarqube-logs/_data /sonarqube/logs
ln -s /var/lib/docker/volumes/sonarqube-extensions/_data /sonarqube/extensions
#docker run -d --name sonarqube -p 9000:9000 -p 9092:9092 -v sonarqube-conf:/sonarqube/conf -v sonarqube-data:/sonarqube/data -v sonarqube-logs:/sonarqube/logs -v sonarqube-extensions:/sonarqube/extensions sonarqube
docker run -d --name sonarqube --restart unless-stopped -p 9000:9000 -p 9092:9092 -v sonarqube-conf:/opt/sonarqube/conf -v sonarqube-data:/opt/sonarqube/data -v sonarqube-logs:/opt/sonarqube/logs -v sonarqube-extensions:/opt/sonarqube/extensions sonarqube:lts-community

sudo docker ps

# echo "===================================="
# echo "SonarQube Installation Complete"
# echo "Access: http://<EC2-Public-IP>:9000"
# echo "Username: admin"
# echo "Password: admin"
# echo "===================================="


# #!/bin/bash

# # Set hostname
# sudo hostnamectl set-hostname "sonarqube.mypc.com"
# echo "`hostname -I | awk '{ print $1 }'` `hostname`" >> /etc/hosts
# sudo apt-get update 
# sudo apt-get install git wget unzip zip curl tree -y
# sudo usermod -aG docker ubuntu
# sudo chmod 777 /var/run/docker.sock
# sudo systemctl enable docker
# sudo systemctl restart docker
# sudo docker pull sonarqube:lts-community

# sudo docker images

# # Create Docker volumes
# sudo docker volume create sonarqube-conf
# sudo docker volume create sonarqube-data
# sudo docker volume create sonarqube-logs
# sudo docker volume create sonarqube-extensions

# # Create symbolic links
# sudo mkdir -p /sonarqube

# sudo ln -sf /var/lib/docker/volumes/sonarqube-conf/_data /sonarqube/conf
# sudo ln -sf /var/lib/docker/volumes/sonarqube-data/_data /sonarqube/data
# sudo ln -sf /var/lib/docker/volumes/sonarqube-logs/_data /sonarqube/logs
# sudo ln -sf /var/lib/docker/volumes/sonarqube-extensions/_data /sonarqube/extensions

# # Run SonarQube
# sudo docker run -d \
#   --name sonarqube \
#   --restart unless-stopped \
#   -p 9000:9000 \
#   -p 9092:9092 \
#   -v sonarqube-conf:/opt/sonarqube/conf \
#   -v sonarqube-data:/opt/sonarqube/data \
#   -v sonarqube-logs:/opt/sonarqube/logs \
#   -v sonarqube-extensions:/opt/sonarqube/extensions \
#   sonarqube:lts-community

# # # Show running container
# # sudo docker ps

# # echo "===================================="
# # echo "SonarQube Installation Complete"
# # echo "Access: http://<EC2-Public-IP>:9000"
# # echo "Username: admin"
# # echo "Password: admin"
# # echo "===================================="