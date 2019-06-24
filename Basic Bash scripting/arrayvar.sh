#! /bin/bash

os=('ubuntu' 'windows' 'kali')
os[1]='a'

unset os[3]
echo "${os[@]}" #all the arrays are displayed
echo "${os[1]}" #to show only the addressed array
echo "${!os[@]}" #to display all the arrays in number
echo "${#os[@]}" #to display the total no of arrays

string=dajladlfljdffdjsd

echo "${string[@]}"
echo "${string[0]}"
echo "${string[1]}"
echo "${!string[@]}"

