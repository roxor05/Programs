 #! /bin/bash

 #for loops with files

# for c in ls pwd date
# do
# 	echo "--------------$c---------"
# 	$c
# done

# -----------------------------------

#to get the directory

for i in * # * is to select all 
do
	if [ -d $i ] #-f for files and -d for dir
	then
		echo $i
	fi
done