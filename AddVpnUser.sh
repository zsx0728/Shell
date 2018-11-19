#!/bin/bash
#create by oldboy qq 49000448
#time 2018-11-19 09:29

. /etc/init.d/functions
#config file path
FILE_PATH=/tmp/oldboy3/authfile.conf

[ ! -f $FILE_PATH ] && touch $FILE_PATH;
usage(){
    cat <<EOF
    USAGE: 'basename $0' {-add|-del|-search} username
EOF
}

#judge run user
if [ $UID -ne 0 ];then
    echo "You are not supper user,please call root!"
    exit 1;
fi

#judge arg numbers.
if [ $# -ne 2 ];then
    usage
    exit
fi
RETVAL=0
case "$1" in
    -a|-add)
        shift
        if grep -w "$1" ${FILE_PATH} >>/dev/null 2>&1;then
            action $"vpnuser,$1 is exist" /bin/false
            exit
        else
            chattr -i ${FILE_PATH}
            /bin/cp ${FILE_PATH} ${FILE_PATH}.$(date +%F%T)
            echo "$1" >> ${FILE_PATH}
            [ $? -eq 0 ] && action $"Add $1" /bin/true
            chattr +i ${FILE_PATH}
        fi
        ;;
    -d|-del)
        shift
        if [ `grep -w "$1" ${FILE_PATH}|wc -l` -lt 1 ];then
            action $"vpnuser,$1 is not exist."  /bin/false
            exit
        else
            chattr -i ${FILE_PATH}
            /bin/cp ${FILE_PATH} ${FILE_PATH}.$(date +%F%T)
            sed -i "/^${1}$/d" ${FILE_PATH}
            [ $? -eq 0 ] && action $"Del $1" /bin/true
            chattr +i ${FILE_PATH}
            exit
        fi
        ;;
    -s|-search)
        shift
        if [ `grep -w "$1" ${FILE_PATH}|wc -l` -lt 1 ];then
            echo $"vpnuser,$1 is not exist.";exit
        else
            echo $"vpnuser,$1 is exist.";exit
        fi
        ;;
    *)
        usage
        exit
        ;;
esac
