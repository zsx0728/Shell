#!/bin/bash
#monitor the mysql service,if not run,start it and mail to the administrator.
#you can use "nohup MonitorMysql.sh &" to use it,and must ensure the mail service is ok.
while true
do
    i=`netstat -tunlp|grep 3306|wc -l`
    [ $i -eq 0 ] && {
        echo `/etc/init.d/mysql.server start`|mail -s "mysql start" xxxx@163.com
        continue
    }       
    sleep 1m
done   
