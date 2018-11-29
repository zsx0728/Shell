#!/bin/bash
#find some file named like *_finished.jpg,#copy it in the same dir path and rename it like *.jpg, delete "_finished"

#touch a file ,write the file name in it
[ ! -f $HOME/findfile.txt ] && {
touch $HOME/findfile.txt
chmod 755 $HOME/findfile.txt
}
find /tmp -name *_finished.jpg > $HOME/findfile.txt

AllFileNum=`find /tmp -name *_finished.jpg|wc -l`

for i in $(seq 1 $AllFileNum)
do  
    tempFileName=`cat $HOME/findfile.txt|awk 'NR=="'$i'"{print $0}'`
    echo " The old name is $tempFileName"
    cp $tempFileName `echo $tempFileName|sed 's/\_finished//g'`
done

rm $HOME/findfile.txt
