#!/bin/bash
#分析华为防火墙黑名单每个IP的命中情况，old.log为原防火墙命中情况，new.log为最近防火墙IP命中情况，均使用display firewall blacklist item命令提取，并删除表头，格式为：
# 118.244.X.X /any (src) /any/                               Manual               2020/XX/XX 09:05:52    Permanent 562               
# 106.12.X.X /any (src) /any/                                Manual               2020/XX/XX 14:10:31    Permanent 368               
#
#生成4个文件:
#    nochange.txt - 记录old.log与new.log中无变化的IP及命中数，意味着这段时间这些IP没有产生新攻击。
#    change.txt   - 记录2类数据：1.add.log中所有数据；2.old.log中存在，new.log中不存在的IP
#    add.txt      - 3列，第1列记录old.log与new.log中同时存在的IP，第2列记录old.log中的命中数，第3列记录最近新增的命中数。add.log意味着记录的IP最近产生了新攻击。
#    20201202.log - 运行日志，记录运行时计算的新旧IP命中数。

oldfile=old.log
newfile=new.log

#提取新旧防火墙日志中的IP和命中数
awk '{print $1" "$9}' $oldfile  > ./temp_old.txt
awk '{print $1" "$9}' $newfile  > ./temp_new.txt

#如果存在同名文件，程序运行之前进行删除
if [ -f ./nochange.txt ];then
    rm -f ./nochange.txt
fi

if [ -f ./change.txt ];then
    rm -f ./change.txt
fi

if [ -f ./add.txt ];then
    rm -f ./add.txt
fi

#逐行读取旧日志中的数据，并与新日志进行对比。
cat ./temp_old.txt|while read line
do
    ip=`echo $line|awk '{print $1}'`
    old_hitnum=`echo $line|awk '{print $2}'`
    echo "$ip old_hitnum is $old_hitnum" >> `date +%Y%m%d`.log
    new_hitnum=`grep $ip ./temp_new.txt|awk '{print $2}'`
    echo "$ip new_hitnum is $new_hitnum" >> `date +%Y%m%d`.log

    if [ $new_hitnum ];then
        if [ $old_hitnum -eq $new_hitnum ];then
            echo $line >> nochange.txt
        else
            diffnum=`expr $new_hitnum - $old_hitnum`
            echo "$line,$diffnum" >> change.txt
            echo "$line $diffnum" >> add.txt
        fi
    else
        echo $line >> change.txt            
    fi
done
