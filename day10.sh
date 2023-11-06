#!/bin/bash

# 判断本机有没有curl命令（没有不成立）
if ! which curl &>/dev/null
then
  echo "本机没有curl"
  yum install -y curl
  if [ $? -ne 0 ]
  then
    echo "curl没安装成功"
    exit 1
  fi
fi

# 获取状态码
# curl -I 只返回header信息，因为只要状态码
# curl --connect-timeout 最多卡3s
# 2>/dev/null 把错误返回信息扔掉
# awk {print $2} 默认按空格切分拿第二段，就是状态码
code=`curl --connect-timeout 3 -I $1 2>/dev/null |grep 'HTTP' |awk '{print $2}'`

## 如果状态码是2xx或3xx，则条件成立
# grep -q 只过滤不打印结果
if echo $code |grep -qE '^2[0-9][0-9]|^3[0-9][0-9]'
then
  echo "$1访问正常"
else
  echo "$1访问不正常"
fi

<<'COMMENT'
COMMENT