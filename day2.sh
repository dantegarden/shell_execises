#!/bin/bash

if [ -f /tmp/userinfo.txt ]
then
  rm -f /tmp/userinfo.txt
fi

# 判断mkpasswd命令是否存在，用该命令生成随机字符串密码
if ! which mkpasswd
then
  yum install -y expect
fi

# 借助seq生成从00到09，10个数的队列
# seq可以生成序列，用法seq 1 5 (从1到5); seq 5 (从1到5); seq 1 2 10 (从1到5，步长2，即1 3 5 7 9); seq 10 -2 1 (倒序); seq -w 1 10 (-w 等宽)
for i in `seq -w 0 09`
do
  # 每次生成一个随机字符串作为密码给p变量
  # mkpasswd -l指定长度 -s指定特殊字符个数 -c指定小写字符个数 -C指定大写字母个数 -d指定数字个数
  # mkpasswd生成的密码会包含大小写字母数字和特殊符号，如果不要特殊符号，可以加-s 0来限制不用特殊符号
  p=`mkpasswd -l 15 -s 0`
  # 添加用户，passwd --stdin 只需要输入一次密码，不需要重复输入密码
  useradd user_${i} && echo "${p}" | passwd --stdin user_${i}
  echo "user_${i} $p" >> /tmp/userinfo.txt
done