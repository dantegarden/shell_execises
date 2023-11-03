#!/bin/bash

# sed "1d" 不要第一行，即不要表头
# 不需要tmpfs内存文件系统，要用grep -v过滤掉
# awk '{print $NF}' 只要最后一列
for mount_p in `df | sed '1d' | grep -v 'tmpfs' | awk '{print $NF}'`
do
  #创建测试文件然后删除，从而确定分区是否有问题
  # && 连接符表示前面的命令执行成功才会执行后面的命令，只有都执行成功才返回0，有任何一条执行出错都返回非0
  touch ${mount_p}/test_file && rm -f ${mount_p}/test_file
  if [ $? -ne 0 ]
  then
    echo "${mount_p} 读写有问题"
  else
    echo "${mount_p} 读写正常"
  fi
done