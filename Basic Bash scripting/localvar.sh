#! /bin/bash

function print(){
	local name=$1  #local variabler .... try without local to  
	echo "the name is $name"
}

name="Tom"

echo "the name is $name :before"

print Max

echo "The name is $name :After"