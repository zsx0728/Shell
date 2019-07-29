#!/bin/bash
ps aux | grep mysql | grep -v grep|grep -v sh > /dev/null 2>&1
temp=`echo $?`
echo $temp
