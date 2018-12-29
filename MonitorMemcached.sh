#!/bin/bash
#Author is oldboy,not me.
export MemcachedIp=$1
export MemcachedPort=$2
export NcCmd="nc $MemcachedIp $MemcachedPort"
export MD5=3fe6c01f03425cb5e2da8186eb090d

USAGE(){
    echo "$0 MemcachedIp MemcachedPort"
    exit 3
}

[ $# -ne 2 ] && USAGE
printf "set $MD5 0 0 6\r\noldboy\r\n"|$NcCmd > /dev/null 2>&1
if [ $? -eq 0 ];then
    if [ `printf "get $MD5\r\n"|$NcCmd|grep oldboy|wc -l` -eq 1 ];then
        echo "Memcached status is ok"
        printf "delete $MD5\r\n"|$NcCmd > /dev/null 2>&1
        exit 0
    else
        echo "Memcached status is error1"
        exit 2
    fi
else
    echo "Could not connect Mcserver"
    exit 2
fi
