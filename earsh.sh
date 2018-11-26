#!/bin/bash
#same like the dustbin in windows,move the file in .temp directory,and
#if i want,i can get back it.

#test .temp directory
if [ -d `echo $HOME`/.temp ];then
    echo "the dustbin is exist." 
else
    echo "the dustbin isn't exist"
    mkdir `echo $HOME`/.temp
fi

#test file/directory exist or not
if [ -d `pwd`/$1 ] || [ -f `pwd`/$1 ];then
    mv `pwd`/$1 `echo $HOME`/.temp
else
    echo "your input doesn't exist."
fi
