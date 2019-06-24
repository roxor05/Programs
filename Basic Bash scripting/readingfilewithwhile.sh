#! /bin/bash

#input redirection
while read p
do
	echo $p
done < hello.sh


#single variable
cat	while read p
do
	echo $p
done < hello.sh



#ifs

while IFS= read -r line
do
	echo $line
done < hello.sh # anyfile you want to read