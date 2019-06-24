#! /bin/bash

# n=1

# while [ $n -le 10 ] #or (( $n <= 10 ))
# do
# 	echo "$n"
# 	n=$(( n+1 )) # or (( n++ ))
# done



#eg for whileloops

n=1 
while [ $n -le 3 ] 
do
	echo "$n"
	(( n++ ))
	gnome-terminal & #or xterm & #to open in different terminal 	
	# sleep 1   #displays the value for every 1 second time interval
done