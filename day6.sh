#!/bin/bash

# 先看/opt/logs在不在，不在就创建
[ -d /opt/logs ] || mkdir -p /opt/logs

# while死循环
while :
do
   ## 获取系统1分钟的负载，并且只取小数点前面的数字
   # awk -F 'average:' '{print $2}' 按"average:"切分，取出第二段
   # cut -d',' -f1 再按,切分，取第一段
   # sed 's/ //g' 把空格去掉
   # cut -d. -f1 再按.切分，取第一段，至此得到整数数字
   load=`uptime |awk -F 'average:' '{print $2}'|cut -d',' -f1 |sed 's/ //g' | cut -d. -f1`
   # 判断负载是否比10大
   if [ $load -gt 10 ]
   then
     # 分别记录top、vmstat和ss命令的执行结果
     # top -bn1 静态打印所有进程，head -n 100 取前100条
     top -bn1 |head -n 100 > /opt/logs/top.`date +%s`
     # 每隔1s打印一次系统资源使用情况，打印10次
     vmstat 1 10 > /opt/logs/vmstat.`date +%s`
     # 记录网络连接状态
     ss -an > /opt/logs/ss.`date +%s`
   fi

   # 休眠20s
   sleep 20s
   # 找到30天以前的日志文件，删除掉
   find /opt/logs \( -name "top*" -o -name "vmstat*" -o name "ss*" \) -mtime +30 |xargs rm

done

<<'COMMENT'
1） || 用在两条命令中间，可以起到这样的效果：当前面命令执行不成功就会执行后面的命令
2） 死循环可以用while : + sleep 组合
3） find里面可以使用小括号将多个条件组合起来当成一个整体处理
COMMENT