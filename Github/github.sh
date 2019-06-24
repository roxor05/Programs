#! /bin/bash
#using shell script create an image from running instance and then launch spot instance(t2.small) and login into it.
# sudo su # to login as admin to getall the access

# apt-get install git # yum install git

# git --version # to check the version and also to check if its correctly installed

git config --global user.email "shrikkkanthroxor@gmail.com" #to configure the email of the git account

git config --global user.name "roxor05" #to configure the name of the git account

git clone https://github.com/roxor05/ROxOR.git # this creates a directory as same as in the github
git clone https://github.com/roxor05/Programs.git # this creates a directory as same as in the github

cd ROxOR/ # then go inside the directory
cd Coding/ # then go inside the directory

# cp ~/*.sh  ./ # cp ~/github.sh  ./ #or  #copy the required file 

# git add github.sh 

git add --all # then this adds the file

git commit # this will tell us which files are need to be pushed 

git push -u origin master # this pushes the files

### to create a branch ###

#git branch branchname
#git push -u repostoryname branchname



# cp /home/roxor/*.sh /home/roxor/shell-scripts/ # to copy the files from one dir to another

# git init # to initate the git in that folder

# git clone https://github.com/username/repostoryname # to make the folder in the linux machine as same as the gthub repostory

# git add filename or foldername # to add to the github repostory

# git commit # to save the changes 

# git push -u repostoryname branchname # to upload the files or folder to the github online #branchname is master for default and we can have any other name if we have more than one branch

#access key: AKIAZXFPH5QQAHXS7DN5
#secret access key: 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
