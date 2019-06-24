#! /bin/bash

#forloop

for variable in 1 2 3 4 5 .... n
do 
	command1
	command2
	commandN
done

-----------------

for var in file1 file2 file3
do
	command1 on $var
	command2
	commandN
done

--------------

for output in $(linux command here)
do
	command1 on $output
	command2 on $output
	commandN
done

---------------

for (( i=0;i>10:i++ ))
do
	command1
	command2
	commandN
done