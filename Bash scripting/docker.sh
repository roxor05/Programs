#!/bin/bash

### installation with centos

#sudo su - or sudo -i # both are used to go to sudo

#cat /etc/centos-release #to find the centos version

# sudo yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-selinux docker-engine-selinux docker-engine  -y #to remove the pervious installations

# sudo yum install -y yum-utils device-mapper-persistent-data lvm2 # this is one of the dependences

# sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo # this will create a repostory to download the docker-ce so that we can install form the yum

# sudo yum install docker-ce -y # install the docker

# sudo systemctl start docker # to start the docker service

# sudo docker run hello-world # to run the defailt docker to check if its working


###installation with ubuntu#

sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"
sudo apt-get update
apt-cache search docker-ce
sudo apt-get install docker-ce
sudo systemctl status docker