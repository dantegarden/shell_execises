#!/bin/bash

d=`date +%Y%m%d%H%M`
basedir=/data/web/attachment

## find找到5分钟之内新产生的文件，并把文件列表写入一个文件里
# -mmin -5 根据更改时间来查找，以分钟为单位，超找过去五分钟内修改的文件
find $basedir/ -type f -mmin -5 > /tmp/newf.txt

## 如果文件里有内容，把文件改名，即我们要的文件列表日志文件
# -s 可判断文件是否为空文件
if [ -s /tmp/newf.txt ]; then
  mv /tmp/newf.txt /tmp/$d
fi

<<'COMMENT'
1） find的-mmin可以以分钟单位，-mtime的单位是天
2） [ -s filename] 表示当文件存在，且文件内容不为空时，条件成立
COMMENT