#! /bin/bash

#this is the starting the line
# echo "yoyo honeysingh"
# read -p 'username: ' username
# read -sp 'password: ' password

# echo "Enter names : "
# read -a names
# echo "Names" : ${names[0]} , ${names[1]} , ${names[2]}


# echo -e "Enter the the names:"
# read names
# echo "$names"
# echo $#

echo "Enter the file name"
read file
echo "enter the word to be found"
read word
count=0
for i in cat $file
do
	if [ $i==$word ]
	then
		((count++))
	fi
done<test
echo "the number of words are $count"

