#!/bin/bash
#author:oldboy,not me
#Test the url,if failure the first time,try it after 3 seconds.
#------function split------
. /etc/init.d/functions
function checkURL()
{
    checkUrl=$1
    echo 'check url start ...'
    judge=($(curl -I -s --connect-timeout 2 ${checkUrl}|head -1|tr "\r" "\n") )
    if [[ "${judge[1]}" == "200" &&  "${judge[2]}" == 'OK' ]]
        then
            action "${checkUrl}" /bin/true
    else
            action "${checkUrl}" /bin/false
            echo -n "retrying again...";sleep 3;
            judgeagain=($(curl -I -s --connect-timeout 2 ${checkUrl}|head -1|tr "\r" "\n") )
            if [[ "${judgeagain[1]}" == '200' && "${judgeagain[2]}" == 'OK' ]]
                then
                    action "${checkUrl},retried again" /bin/true
            else
                    action "${checkUrl},retried again" /bin/false
            fi
    fi
    sleep 1;
}

checkURL www.zsx.org
