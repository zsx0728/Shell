#!/bin/bash
#提取request_time大于500ms的nginx日志，其中，以双引号为间隔，request_time为每行日志的第8项，如：
#-^123.103.xx.xx - - [26/May/2020:10:28:19 +0800] "POST /App/Api/index.php/AppV5/getActInfo HTTP/1.1" 200 1854 "-" "okhttp/3.5.0" "0.702"
#使用方法：sh get_nginx_request_time.sh nginx_log_name

if [ -f final.txt ]
then
    rm -f final.txt
fi

cat $1|while read line
do
    request_time=`echo $line|awk -F'"' '{print $8}'`
    #echo ${request_time:2:1}
    if [ ${request_time:0:1} == 0 ];then
        if [ ${request_time:2:1} == 5 ] || [ ${request_time:2:1} == 6 ] || [ ${request_time:2:1} == 7 ] || [ ${request_time:2:1} == 8 ] || [ ${request_time:2:1} == 9 ]
        then
           echo $line >> final.txt 
        fi
    elif [ ${request_time:0:1} != 0 ] && [ ${request_time:0:1} != '-' ]
    then
        echo $line >> final.txt
    fi
done
