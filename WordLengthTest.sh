#!/bin/bash
#find the word in a file ,when the word length greater than 6.
#Just a test.

Word=`cat target.txt|sed 's/[,|.|:|"]/\ /g'`
WordNum=`echo $Word|wc -w`

echo "the word number is:$WordNum"
for ((i=1;i<=$WordNum;i++))
do
    EveryWord=`echo $Word|awk '{print $"'$i'"}'`    
    WordLength=`echo $EveryWord|wc -L`
    if [ $WordLength -ge 6 ];then
        echo $EveryWord
    fi  
done
