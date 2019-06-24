#! /bin/bash

usage(){
	echo "you need to provide an argument"
	echo "usage: $0 filename"
}

is_file_exist(){
	local file="$1"
	[[ -f "$file" ]] && return 0 || return 1 
}

[[ $# -eq 0 ]] && usage 

if( is_file_exist "$1" )
then
	echo "$1 found"
else
	echo "File not found"
fi