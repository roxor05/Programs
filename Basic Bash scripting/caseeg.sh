#! /bin/bash

echo -e "enter some characters : \c"
read value 

case $value in
	[a-z] )
		echo "the alp option";;
	[A-Z] )
		echo "the ualp option";; #for upper case to work we need type LANG=C
	[0-9] )
		echo "the number option";;
	? )
		echo "this is a special option";;
	* )
		echo "not the correct option";;
esac