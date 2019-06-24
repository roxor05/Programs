#! /bin/bash


vehicle=$1

case $vehicle in
	"cars" )
		echo "car is just fine";;
	"bikes" )
		echo "bikes are better";;
	* )
		echo "not the correct option";;
esac