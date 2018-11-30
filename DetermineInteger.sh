#!/bin/bash
#read something,and determine whether the input is an integer. 

function exprTest()
{
expr $1 + 0 &>/dev/null && echo "your input is an integer" || echo "your input isn't an integer "
return 0
}
read -p "please input something,I will tell you whether it is a integer:" Num
exprTest $Num
