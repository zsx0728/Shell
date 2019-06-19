#!/bin/bash

echo "please input the number of x:"
read x
echo "please input the number of y:"
read y

temp=1

for((i=0;i<$y;i++))
do
    let temp=$temp*$x
done

let S=$temp*3+4*$x*$x+5*$y+6
echo "s=$S"
