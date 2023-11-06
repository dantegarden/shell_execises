#!/bin/bash

while :
do
  read -p "Please input number:(Input "end" to quit)" n
  # 用sed -r正则替换掉所有数字，然后用wc -c统计字符个数
  # 如果是纯数字，那么num的值是1，因为wc -c会把回车也算在内
  num=`echo $n | sed -r 's/[0-9]//g'|wc -c`
  if [ $n == "end" ]
  then
    exit
  fi

  if [ $num -ne 1 ]
  then
    echo "What you input is not a number! Try again!!"
  else
    echo "The number you entered is: $n"
  fi

  sleep 1s
done

<<'COMMENT'
1) wc -c 计算字符串长度，其中回车也算一个字符
2）使用 sed -r 's/[0-9]//g'可以把字符串里的数字删掉
3）exit直接退出脚本
COMMENT
