#!/bin/bash
#Judge the input is integer or char,if input two integer,sum it. 
echo "the number of input is:$#";

#Judge the input is an integer.
function IntegerTest()
{
    expr $1 + 0 &>/dev/null && echo "your input is an integer" || echo "your input is a char "
    return 0
}

#judge the input is null.
[ $# -eq 0 ] && {
echo "please input something"
exit
}

#print every input word and judge whether an integer
for ((i=1;i<=$#;i++))
do
    EveryWord=`echo $@|awk '{print $"'$i'"}'`
    echo "the $i word is:$EveryWord"
    IntegerTest $EveryWord
done

#if innput 2 num,calculate the sum.
if [ $# -eq 2 ];then
    Sum=`expr $1 + $2 2>/dev/null`
    echo "the sum of input is:$Sum."
fi
