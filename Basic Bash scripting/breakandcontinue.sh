#! /bin/bash

for (( i = 1 ; i<=10; i++ )) 
do
	if [ $i -gt 5 ] 
	then
		break #statements
	fi
	echo "$i"
done


for (( i = 1 ; i<=10; i++ )) 
do
	if [ $i -eq 3 -o $i -eq 6 ] 
	then
		continue #statements
	fi
	echo "$i"
done