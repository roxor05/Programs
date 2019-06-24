#!bin/bash

python --version # to check the version

curl -O https://bootstrap.pypa.io/get-pip.py # to get the pip repostory for apt 

python get-pip.py --user #to get the pip installed

export PATH=~/.local/bin:$PATH # to save the env

source ~/.profile # to paste it in here

pip --version # to check the pip version

pip install awscli --upgrade --user # to install the aws

aws --version # to check if aws is installed

which aws # to check the env

which python # to check the env

aws configure # to configure the aws and connect it the aws account using key 

