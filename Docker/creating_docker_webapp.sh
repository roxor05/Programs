#! /bin/bash

sudo su # to run as admin

docker pull prakhar1989/static-site # to download the webapp image from the internet

docker run -d -P --name static-site prakhar1989/static-site # to run the webapp -d will detach our terminal, -P will publish all exposed ports to random ports and --name is the name of the webapp

docker port static-site # to get the port number of the webapp

docker run --rm prakhar1989/static-site # to run the image and stop it when the image is closed is the use of rm

# then go the browser and get the public IP and the port number and you will get the webpage

#docker stop static-site --- to stop the service 

#docker run -p 8888:80 prakhar1989/static-site --- to run with a specific port number

#curl ifconfig.me --- to find the public ip
#ifconfig -a --- to find the private
