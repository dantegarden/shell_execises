#!/bin/bash

cd /data/wwwroot/app

# 遍历所有目录和文件，用find .即可
for f in `find .`
do
  # 查看文件权限，如644
  f_p=`stat -c %a $f`
  # 查看文件所有者，
  f_u=`stat -c %U $f`
  # 查看文件所属组
  f_g=`stat -c %G $f`

  # 判断是否为目录
  if [ -d $f ]
  then
    [ $f_p != '755' ] && chmod 755 $f
  else
    [ $f_p != '644' ] && chmod 644 $f
  fi

  # &&用在两条命令中间可以起到if的作用
  [ $f_u != 'www' ] && chown www $f
  [ $f_g != 'root' ] && chown :root $f
done

# 一大堆注释可以这么写
<<'COMMENT'
也可以用find来实现
find /data/wwwroot/app/ -type d ! -prem 755 -exec chmod 755 {} \;
find /data/wwwroot/app/ ! -type d ! prem 644 -exec chmod 644 {} \;
find /data/wwwroot/app/ ! -user www -exec chown www {} \;
find /data/wwwroot/app/ ! -group root -exec chgrp root {} \;

两个脚本相比，第一个只需要find一次，第二个需要find 4次，如果文件多，执行效率就很差了。
&& 可以实现 当前面的命令执行成功 再执行后面的语句
|| 可以实现 当前面的命令执行不成功 再执行后面的语句
COMMENT