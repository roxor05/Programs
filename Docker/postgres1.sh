#! /bin/bash

sudo su # to run as admin

cat /etc/centos-release #to find the centos version

yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-selinux docker-engine-selinux docker-engine  -y #to remove the pervious installations

yum install -y yum-utils device-mapper-persistent-data lvm2 # this is one of the dependences

yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo # this will create a repostory to download the docker-ce so that we can install form the yum

yum install docker-ce -y # install the docker

systemctl start docker # to start the docker service

docker run hello-world # to run the defailt docker to check if its working

systemctl start docker #to start the docker

#docker pull postgres  

docker run --name postgresdatabase -e POSTGRES_PASSWORD=admin -d -p 5432:5432 postgres:9.5 # to download and run the postgres container # you can download 9.6 or anyother version too # you can specify the ip 127.0.0.1:5432:5432

docker ps -a

docker exec -it nameofthecontainer bash #we get the container id from ps -a

### now we go into the postgres container bash

psql -U postgres #to login to the potgres with the username we have given , here its postgres as username 

### now you will entering into the user 

\du # to see the no of users and there roles

create database test; # to create a database

\l # to check if the ddatabase is created

\c test # to connect to the database


\d # to check if there is anything in the database created

### then to connect to the db from other computer 

#sudo yum install psql 9.5

#sudo apt install libgmp3-dev libpq-dev libapache2-mod-wsgi-py3

# sudo mkdir -p /var/lib/pgadmin4/sessions
# sudo mkdir /var/lib/pgadmin4/storage
# sudo mkdir /var/log/pgadmin4
# sudo chown -R roxor:roxor /var/lib/pgadmin4
# sudo chown -R roxor:roxor /var/log/pgadmin4

#sudo -i -u postgres
#psql
#psql -h 95.21.147.252 -p 5432 -U postgres ##95.21.147.252 is the intance ip address 
###type the password and you are good to go


### to remove image and docker and container ###

# docker rmi <IMAGE ID> ### to delete all the images installed

# docker images ### to see the images installed 

# docker rm <CONTAINER ID> ### to remove container

# docker ps -a ### to see all the docker images running

# docker stop $(docker ps -a -q) ### to stop all the containers

# docker rm $(docker ps -a -q) ### to remove all the containers


### extra commands ### 

# docker images

# mkdir -p $HOME/docker/volumes/postgres

# docker volume create pgdata

# sudo docker volume ls

# sudo docker container rm postgresondocker -f

# sudo docker run --name postgresondocker --network postgres-network -v pgdata:/var/lib/postgresql/9.3/main -d postgresondocker:9.3 