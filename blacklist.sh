#!/bin/bash
#本脚本适用于华为USG6000，USG9500系列防火墙。
#使用说明：
#    脚本有2个选项：
#    1选项将分析防火墙黑名单拦截情况，将攻击数为0的ip筛选出来，并拼接成用于防火墙的命令，最后将命令写入undo.txt。目的在于从防火墙上删除近期未攻击的IP，节约黑名单资源;
#    2选项将分析SSH攻击的日志，将攻击IP提取出来，并拼接成用于防火墙的命令，最后将命令写入add.txt。目的在于将SSH攻击IP写入防火墙，进行拦截。
#防火墙黑名单情况需要在防火墙上使用 display firewall blacklist item 命令，将结果保存为 firewall_blacklist 文件，其格式类似：
# 120.78.64.2 /any (src) /any/                                 Manual               2020/08/05 07:19:10    Permanent 20 
#SSH攻击日志需要在服务器上使用 lastb -a > last.log 获取，其格式类似：
#develope ssh:notty    Tue Aug 25 14:10 - 14:10  (00:00)     116.236.200.254
#fenix    ssh:notty    Tue Aug 25 14:09 - 14:09  (00:00)     bl14-150-173.dsl.telepac.pt
#最后，将文件与脚本保存在同一目录运行即可。

#筛选攻击数为0的IP，并生成在防火墙上删除这些IP的命令
function undo_blacklist()
{
    sort -k 9n $1 > ./temp_undo.txt
    cat ./temp_undo.txt|while read line
    do
        number=`echo ${line} | awk '{print $9}'`
        name=`echo ${line} | awk '{print $1}'`
        if [ $number -eq 0 ];then
                echo "undo firewall blacklist item source-ip $name" >> ./undo.txt
        else break
        fi
    done
    rm -f ./temp_undo.txt
}

#检查IP地址是否正确
CheckIPAddr()
{
    echo $1|grep "^[0-9]\{1,3\}\.\([0-9]\{1,3\}\.\)\{2\}[0-9]\{1,3\}$" > /dev/null;
    #IP地址必须为全数字
        if [ $? -ne 0 ]
        then
                return 1
        fi
        ipaddr=$1
        a=`echo $ipaddr|awk -F . '{print $1}'`  #以"."分隔，取出每个列的值
        b=`echo $ipaddr|awk -F . '{print $2}'`
        c=`echo $ipaddr|awk -F . '{print $3}'`
        d=`echo $ipaddr|awk -F . '{print $4}'`
        for num in $a $b $c $d
        do
                if [ $num -gt 255 ] || [ $num -lt 0 ]    #每个数值必须在0-255之间
                then
                        return 1
                fi
        done
                return 0
}

#确定SSH攻击的IP，如使用域名攻击，将域名转化为IP，最后生成可以在华为防火墙执行的命令。
function add_blacklist()
{
    if [ -f ./add.txt ];then
        rm -f ./add.txt
    fi
    awk '{print $10}' $1 |sort|uniq -c|sort -nr|awk '{print $2}' > ./temp_add.txt
    cat ./temp_add.txt|while read line
    do
        CheckIPAddr $line
        if [ `echo $?` -eq 1 ];then
            temp_ip=`dig +nocomment +nocmd +noquestion +nostats $line|awk '{print $5}'`
           echo "firewall blacklist item source-ip $temp_ip" >> ./add.txt
        else
            echo "firewall blacklist item source-ip $line" >> ./add.txt
        fi
    done
    rm -f ./temp_add.txt
}

#打印提示，读取选择
echo -e "Please input your choice:
1.analyze the firewall status and get the 0 hit blacklist items;
2.analyze the lastb logfile and add the blacklist;
3.quit"
read num

case $num in 
    1)
        printf "Please input the name of the firewall status file,default is 'firewall_blacklist':\n" 
        read fileName
        if [ -z "${fileName}" ];then
                fileName="firewall_blacklist"
        fi
        undo_blacklist $fileName
        ;;
    2)
        printf "Please input the name of the lastb logfile,default is 'last.log':\n" 
        read fileName
        if [ -z "${fileName}" ];then
                fileName="last.log"
        fi
        add_blacklist $fileName
        ;;
    *)
        exit
        ;;
esac
