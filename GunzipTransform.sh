#!/bin/bash
#find the file name like *.sql.gz and gunzip it like *.sql
SqlgzDir="/usr/local/src"
FileNameList="/usr/local/sqlFileName.txt"
Log="/usr/local/FileTrans.log"

[ -f $FileNameList ] || {
    touch $FileNameList
    chmod 777 $FileNameList
}

#collect the FileName of sql.gz
find $SqlgzDir -name *.sql.gz > $FileNameList

#calculate the number of files.
FileNum=`cat $FileNameList|wc -l`
echo -e "the filename list's location is $FileNameList,the file number is $FileNum.\nDo you want to begin to transform the *.sql.gz to *.sql?\nplease input the number:"

select ChoiceNum in yes no
do
    case $ChoiceNum in
        yes)
            for ((i=1;i<=$FileNum;i++))
                do
                    FileName=$(sed -n "$i"p $FileNameList)
                    gunzip $FileName && echo "$FileName success!" >> $Log || {
                        echo "$FileName failure!please check it." >> $Log
                        break
                    }
                    continue
            done
            rm -f $FileNameList
            exit 
            ;;
        *)
            echo "bye!" && exit 
            ;;
    esac
done
