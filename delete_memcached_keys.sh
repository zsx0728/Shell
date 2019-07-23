#!/bin/bash
#. /etc/rc.d/init.d/functions
IP='127.0.0.1'
PORT=11211

echo -e "1.list all keys in /tmp/memcache_list_key.txt;\n2.Input a keyword to find the keys and delete;\n3.quit.\nPlease input a number to continue:"
read NUM
case $NUM in
1)
#three steps to get the memcached value:
#1.stats items;
#2.stats cachedump X 0
#3.get key
    (/bin/echo "stats items";/bin/echo -e "\n") | /usr/bin/telnet $IP $PORT |/bin/grep STAT|/bin/awk '{print $2}'|/bin/awk -F : '{print $2}'|/bin/sort|/usr/bin/uniq > /tmp/items.txt

    while read line
    do
        /bin/echo "stats cachedump $line 0"
    done < /tmp/items.txt > /tmp/cachedump.txt
#the memcache keys name in /tmp/memcache_list_key.txt
    while read command 
    do
        /bin/echo $command
        /bin/echo -e "\n"    
    done < /tmp/cachedump.txt | /usr/bin/telnet $IP $PORT | /bin/grep ITEM | /bin/awk '{print $2}' > /tmp/memcache_list_key.txt
    
#delete the useless files.
    if [ -f /tmp/items.txt ];then
        /bin/rm -f /tmp/items.txt
    fi
    if [ -f /tmp/cachedump.txt ];then
        /bin/rm -f /tmp/cachedump.txt
    fi
    ;;
2)
#please use step 1 to get the current keys.
    echo "You can use step 1 to get refresh the keys."
    echo -e "Please input a keyword:"
    read keyword
    /bin/grep $keyword /tmp/memcache_list_key.txt > /tmp/keyword.txt

#list the keys to del
    echo "Find the keys include \"$keyword\" are:"
    while read wait_to_del
    do
        /bin/echo $wait_to_del
    done < /tmp/keyword.txt

#delet the keys
    echo "Ready to delete the keys?[Y|N]"
    read choice
    case $choice in
        Y|y)
            while read wait_to_del
            do
                /bin/echo "delete $wait_to_del"
                /bin/echo -e "\n"
            done < /tmp/keyword.txt | /usr/bin/telnet $IP $PORT
            ;;
        N|n)
            ;;
    esac
    ;;
3)
    ;;
esac
