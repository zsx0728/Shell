#!/bin/bash
#提取request_time大于1的nginx日志，其中，request_time必须为每行日志的最后一项，如：
#-^-^09/May/2020:03:18:05 +0800^200^HEAD /favicon.ico HTTP/1.0^0^-^-^222.186.132.82^0.001
#使用方法：sh get_nginx_request_time.sh nginx_log_name

if [ -f final.txt ]
then
    rm -f final.txt
fi

cat $1|while read line
do
    request_time=`echo $line|awk -F'^' '{print $10}'`
    #echo ${request_time:0:1}
    if [ ${request_time:0:1} != 0 ]
    then
       echo $line >> final.txt 
    fi
done
