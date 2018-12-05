#!/bin/bash
#input a number to choice a kind of fruit.
printf "(1).apple\n(2).pear\n(3).banana\n(4).cherry\n(5).quit\n"

while true
do
    read -p "please input a number of fruit:" fruit
    case $fruit in
        1)  
            echo -e "your choice is:\E[1;31mapple\E[0m"
            ;;  
        2)  
            echo -e "your choice is:\E[1;32mpear\E[0m"
            ;;  
        3)  
            echo -e "your choice is:\E[1;33mbanana\E[0m"
            ;;  
        4)  
            echo -e "your choice is:\E[1;34mcherry\E[0m"
            ;;  
        5)  
            exit
            ;;  
        *)  
            echo "please input [1-4]"
            ;;  
    esac
done
