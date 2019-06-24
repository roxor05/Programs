#! /bin/bash

sudo docker pull busybox # to pull the busybox image from the docker 

sudo docker images # to pullout all the images that are running in the docker 

sudo docker run busybox 

sudo docker run busybox echo "hello from busybox" # to get message from the busybox image

sudo docker run -it busybox sh # to see the running busybox image and you can type normal commands in it 

sudo docker ps

sudo docker ps -a

### to delete the docker container ###
# 1. got to --- sudo docker ps -a --- to check for the process and container id
# 2. sudo docker rm container id  ---- paste the container id to stop the process
# sudo su - username ---to login as root or any user
#to exit root --- ctrl+d
#to delete the container --- docker container prune or docker rm $(docker ps -a -q -f status=exited)
#docker run --rm busybox --- automatically removes the container


#docker run -d -P --name static-site prakhar1989/static-site --- this is used to run the server and show the ports to use
#docker port static-site --- this is used to get the ports of the server running


####to find the docker ip address

# First get the container ID:
# docker ps
# (First column is for container ID)
# Use the container ID to run:
# docker inspect <container ID>
# At the bottom,under "NetworkSettings", you can find "IPAddress"
# Or Just do:
# docker inspect <container id> | grep "IPAddress"

