#!/bin/bash

# 先定义一个main函数，目的是为了后面调用函数，方便记录日志
main()
{
  cd /data/att
  ## 遍历第一层目录
  for dir in `ls`
  do
    ## 遍历第二层目录
    for dir2 in `find $dir -maxdepth 1 -type d -mtime +365`
    do
      # 将目标目录下的文件同步到/data1/att/目录下，-R可以自动创建目录结构
      rsync -aR $dir2/ /data1/att/
      if [ $? -eq 0 ]
      then
        # 如果上步操作成功，会将/data/att下的目录删除
        rm -rf $dir2
        echo "/data/att/$dir2 移动成功"
        # 做软连接
        ln -s /data1/att/$dir2 /data/att/$dir2 && \
          echo "/data/att/$dir2 成功创建软连接"
        # 打印空行
        echo
      else
        echo "/data/att/$dir 未移动成功"
      fi
    done
  done
}

# 调用main函数，并将输出写入日志里，日志每天一个
# date +%F 输出 当前日期的yyyy-MM-dd格式字符串
main &> /tmp/move_old_data_`date +%F`.log

<<"COMMANT"
1. 可以通过main函数的形式来方便地定义脚本日志
2. find -maxdepth 可以定义查找目录的层级
3. 如果某行脚本很长，可以使用"\ + 回车"来换行，但本质上还是一行内容
4. rsync的-R选项可以自动级联创建目录层级
COMMANT