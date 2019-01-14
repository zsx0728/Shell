#!/bin/bash
#copy the tables to /tmp/bak and tar it
#README:
# 1.you must create the TableList.txt before use this script.you can create it in windows,but don't forget to use "dos2unix TableList.txt";
# 2.TableList.txt's example:
#    [root@www]# cat TableList.txt 
#    memcache-2.2.7
#    tengine-2.2.2

SourceDir=/home/FileStorage
TableList=/tmp/TableList.txt
TarballName=`date +%Y%m%d%H%M`.tar.gz
BackupDir=/tmp/bak

#Test whether have the TableList file
echo "NOTICE:Please vim the $TableList, write the directory name in it."
[ -f $TableList ] || {
    echo "sorry,please write the directory name in $TableList"
    exit 2
}

#Test whether have the bakup directory,if not ,create it.
[ -d $BackupDir ] || {
    mkdir $BackupDir
    echo "The backupDir $BackupDir had created."
}

main(){
    echo -e "1.the source dir is $SourceDir\n2.the file wait to copy is:\n`cat $TableList`\n3.the tarball name is /mnt/webchunk/$TarballName\nplease make sure you want to continue[Y/n]:"
    read var
    
    case $var in
        Y|y)
            #rsync the target directory to the BackupDir.
            cd $SourceDir 
            cat $TableList |xargs -i rsync -av {} $BackupDir
    
            #tar the files and remove the BackupDir
            cd $BackupDir && tar zcv -T $TableList -f /mnt/webchunk/$TarballName
            rm -rf $BackupDir
            ;;
        *)
            exit 3
    esac
}

main
