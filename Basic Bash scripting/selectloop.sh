#! /bin/bash

#to make a menu where we can select the name with the number(menu structure)
# select name in shrikkanth roxor sandeep  
# do
# 	echo "$name selected"
# done

# ---------------------------------------

select name in jae yo this is that
do
	case $name in
		jae )
			echo jae selected
		;;
		yo )
			echo yo selected
		;;
		this )
			echo this selected
		;;
		is )
			echo is selected
		;;
		that )
			echo that selected
		;;
		* )
			echo "error please select correct number"
	esac
done


# stack overflow
#!/bin/bash
# Bash Menu Script Example

PS3='Please enter your choice: '
options=("Option 1" "Option 2" "Option 3" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Option 1")
            echo "you chose choice 1"
            ;;
        "Option 2")
            echo "you chose choice 2"
            ;;
        "Option 3")
            echo "you chose choice $REPLY which is $opt"
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
Add break statements wherever you need the select loop to exit. If a break is not performed, the select statement loops and the menu is re-displayed.

In the third option, I included variables that are set by the select statement to demonstrate that you have access to those values. If you choose it, it will output:

you chose choice 3 which is Option 3
You can see that $REPLY contains the string you entered at the prompt. It is used as an index into the array ${options[@]} as if the array were 1 based. The variable $opt contains the string from that index in the array.

Note that the choices could be a simple list directly in the select statement like this:

select opt in foo bar baz 'multi word choice'
but you can't put such a list in a scalar variable because of the spaces in one of the choices.

You can also use file globbing if you are choosing among files:

select file in *.tar.gz