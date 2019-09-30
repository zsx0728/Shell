#!/bin/bash
#author:zsx
#date 2019-09-24
#This script is used to count the IP with the most visits,
#you can use it like:
#    sh log_count.sh nginx.access.log-20190924
echo start
output_file1='/root/most_visit_ip.txt'
output_file2='/root/wait_for_investigation.txt'
output_file3='/root/final.txt'

/usr/bin/awk -F "[ ^]" '{print $2}' $1 |/usr/bin/sort|/usr/bin/uniq -c |/usr/bin/sort -t ' ' -nr -k 2 > $output_file1            
/usr/bin/awk -F "[ ^]" '{print $2,$10}' $1 |/usr/bin/grep -v ' 403$'|/usr/bin/sort|/usr/bin/uniq -c |/usr/bin/sort -t ' ' -nr -k 2 > $output_file2  

while read line
do
    ip_count=`echo $line|/usr/bin/awk '{print $1}'`
    ip=`echo $line|awk '{print $2}'`
    if [ $ip_count -ge 100 ];then
        echo $ip >> $output_file3
    fi
done < $output_file2

if [ `echo $?` ];then
    echo success
else echo fail
fi  
