#!/bin/bash

suffix=`date +%Y%m%d`

for f in `find /data/ -type f -name "*.txt"`
do
  echo "备份文件$f"
  cp "${f}" "${f}"_"${suffix}"
done