#!/bin/bash
#random product a number in 1~60,guess the num and return the times.

function JudgeInput(){
    [ $# -ne 1 ] && {
        echo "please input one number,thanks."
        exit 1
        }
    expr $1 + 1 &>/dev/null
    [ $? -ne 0 ] && {
        echo "please input the number.not char.thanks."
        exit 2
    }
    [ $1 -ge 1 -a $1 -le 60 ] || {
        echo "please input a number between 1~60."
        exit 3
    }
}

let RandomNum=$RANDOM%60+1
times=0

while true
do
    read -p  "The random number has created,please input a number between 1~60 to guess it:" GuessNum
    JudgeInput $GuessNum && ((times+=1))
    if [ $GuessNum == $RandomNum ];then
        echo "You guess it!congratulations!"
        echo "the times is $times."
        exit 0
    elif [ $GuessNum -gt $RandomNum ];then
        echo "your guess is greater than the random number."
        continue
    elif [ $GuessNum -lt $RandomNum ];then
        echo "your guess is less than the random number."
        continue
    fi
done
