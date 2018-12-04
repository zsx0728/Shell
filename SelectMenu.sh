#!/bin/bash
#print the select menu,install service belong to the choice.
printf "1.[install lamp]\n2.[install lnmp]\n3.[exit]\npls input the num you want:"
read num

if [ $num -eq 1 ];then
    echo "start installing lamp"
    /root/bin/lamp.sh
    exit 1
elif [ $num -eq 2 ];then
    echo "start installing lnmp"
    /root/bin/lnmp.sh
    exit 2
elif [ $num -eq 3 ];then
    exit 3
else
    echo "Input error"
    exit 4
fi 
