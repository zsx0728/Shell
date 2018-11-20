#!/bin/bash
#add system user
#write by myself

for ((i=1;i<=10;i++))
do
    useradd user$i && echo user$i |tee -a /tmp/AddUser.log;
    echo $((RANDOM+10000000)) |tee -a /tmp/AddUser.log;
    tail -1 /tmp/AddUser.log|passwd --stdin user$i;
    echo $? && echo "Add user$i success!" || echo "Add user$i failure!";
done

#finally,align user name and password.
sed -i "N;s#\n#=#g" AddUser.log
