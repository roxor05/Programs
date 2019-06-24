#! /bin/bash

#for loops

for i in 1 2 3 4 5
do
	echo $i
done

# -------------------------
#1 to 10 range
for i in {1..10}
do
	echo $i
done

# -------------------------
#1 to 10 range with increment of 2
for i in {1..10..2}
do
	echo $i
done

echo ${BASH_VERSION}

# -----------------------
#traditional method
for (( i=0; i<5; i++ ))
do 
	echo $i
done