#!/bin/bash

#cpu infomation
printf "the cpu infomation:\n"
printf "the core number is: "
cat /proc/cpuinfo|grep 'model name'|wc -l 
cat /proc/cpuinfo|grep 'model name' 

#test whether the sensor has installed.if not,install it.
test `which sensors`
Temp=`echo $?`
if $Temp
then
    printf "Now it's going to install the sensors.\n"
    yum -y install lm_sensors
else
    printf "the sensors has installed.\n"
fi

printf "the temperature of cpu is:\n"
sensors

#memory infomation
printf "the memory size is:\n"
cat /proc/meminfo|head -4

#uptime
printf "the uptime is:\n"
uptime
