#!/bin/bash
#提取nginx日志文件中的访问码为404的客户端IP，并统计出现次数，最后按出现次数排序。出现次数多的IP在最前面。
#使用方法：sh nginx_404_count.sh nginx.log
codeNum=404
File1=$codeNum\.all.txt
File2=$codeNum\.final.txt
grep $codeNum $1 > $File1
awk '{match ($0, /[1-9][0-9]?\.[0-9]{1,3}\.[0-9]{1,3}\.[1-9][0-9]?/ ,array);print array[0]}' $File1 |sort|uniq -c|sort -nr > $File2
