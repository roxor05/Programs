#! /bin/bash

echo -e "enter the filename: \c"
read filename

if [ -f $filename ]
then
	if [ -w $filename ]
	then
		echo "Type some data here/ to quit press ctrl+c."
		cat >> $filename
	else
		echo "the file has no write access"
	fi
	
else
	echo "$filename is not there"
fi