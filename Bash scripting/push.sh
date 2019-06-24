#! /bin/bash

cd shell-script/ # then go inside the directory

cp ~/*.sh  ./ # cp ~/github.sh  ./ #or  #copy the required file 

git add github.sh # then this adds the file

git commit # this will tell us which files are need to be pushed 

git push -u origin master # this pushes the files

# You have two options here. You can either add the untracked files to your Git repository (as the warning message suggested), or you can add the files to your .gitignore file, if you want Git to ignore them.

# To add the files use git add:

# git add Optimization/language/languageUpdate.php
# git add email_test.php

# To ignore the files, add the following lines to your .gitignore:

# /Optimization/language/languageUpdate.php
# /email_test.php
