#!/bin/bash
sudo root
sudo hostnamectl set-hostname AWSAPACHESERVER.MYPC.COM
echo "`hostname -I | awk '{print $1}'` `hostname`" >> /etc/hosts
sudo apt update
sudo apt install apache2 -y
sudo apt install unzip
timedatectl set-timezone "Asia/Kolkata"