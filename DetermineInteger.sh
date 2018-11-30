#!/bin/bash
#read something,and determine whether the input is an integer. 

read -p "please input something,I will tell you whether it is a integer:" Num
expr $Num + 0 &>/dev/null && echo "your input is an integer" || echo "your input isn't an integer "
