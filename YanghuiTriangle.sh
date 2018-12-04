#!/bin/bash
#input the number of Yanghui triangle,and print it.

if [ -z $1 ];then
    read -p "please input the layer of Yanghui triangle:" Layer
else
    Layer=$1
fi

for ((n=0;n<=$Layer;n++))
do
    for ((m=0;m<="$n";m++))
        do
            if [ $n -eq 0 ] && [ $m == 0 ];then
                printf "1\n"
                continue
            fi
            if [ $m -eq 0 ];then
                printf "1 "
            else
                divisor=`seq -s "*" $n|bc`
                dividend=`seq -s "*" $m|bc`
                if [ $divisor == $dividend ];then
                    printf "1\n"
                else
                x=`seq -s "*" $(($n-$m)) |bc`
                i=$(($dividend*$x))
                let j=$divisor/$i
                printf $j" "
                fi
            fi
    done
done
