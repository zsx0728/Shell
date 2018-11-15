#!/bin/bash
#Source function library

. /etc/init.d/functions

#Defined variables
IP=$(ifconfig eth0|awk -F '[ :]+' 'NR==2{print $4}')
Path="/tmp/oldboy/$IP"
TIME=`date +%F`
BackupFile='/root/bin/test11.sh'

#Judged the existence of variables
[ ! -d $Path ] && mkdir -p $Path
[ ! -f $BackupFile ] && {
    echo "Please give me $BackupFile"
    exit 1
}

#Defined result function
function Msg(){
    if [ $? -eq 0 ];then
        action "$*" /bin/true
    else
        action "$*" /bin/false
    fi
}

#Backup config files
tar zcfh $Path/BackupFile_${TIME}.tar.gz `ls $BackupFile` &> /dev/null
Msg 'Backup config files'

#Make a flag for backup
find $Path -type f -name "*${TIME}.tar.gz"|xargs md5sum > $Path/flag\
_$TIME 2> /dev/null
Msg 'Make a flag for backup'

