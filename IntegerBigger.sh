#!/bin/bash
#input two integers,and output th bigger one.
[ $# != 2 ] && {
echo "please input two integers."
exit 5
}

expr $1 + 1 &>/dev/null && echo "$1 is integer" || {
    echo "$1 isn't integer"
    exit 6
    }   
expr $2 + 1 &>/dev/null && echo "$2 is integer" || {
    echo "$2 isn't integer"
    exit 7
    }   
            
i=0
[ $1 -ge $2 ] && i=$1 || i=$2
echo "the bigger number is:" $i
