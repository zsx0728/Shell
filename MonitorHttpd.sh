#!/bin/bash
#Userd in centos6.5,you can use "nohup MonitorHttpd.sh &" to run this script.
#Monitor the httpd service,if it down,try up it and mail the administrator.
. /etc/rc.d/init.d/functions

LogLocation=/var/log/MonitorHttpd.log
#Test the monitor log exist.if not,touch it.
if [ ! -f $LogLocation ];then
    touch $LogLocation
    chmod 755 $LogLocation
else
    :
fi

#Test the http service cyclical
while true
do
    #The right Status like :"httpd (pid  1092) is running..."
    Status=`status -p /var/run/httpd/httpd.pid /usr/sbin/httpd`
    Keyword=`echo $Status|sed "s#\.##g"|awk '{print $5}'`

    echo $Status
    echo $Keyword
    if [ "$Keyword"x = "running"x ];then
        echo "`date +%F\ %X`,httpd running good " >> $LogLocation
    else
        echo $Status
        echo "httpd down"|mail -s "The httpd service is down" XXXX@qq.com
        echo "httpd down"|mail -s "The httpd service is down" XXXX@163.com
        /etc/init.d/httpd start
        echo $? && echo "`date +%F\ %X`,start httpd success!" >> $LogLocation || echo "`date +%F\ %X`,start http fail" >> $LogLocation
    fi
    sleep 1m #every minute test it.
done
