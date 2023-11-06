#!/bin/bash

echo "*cmd menu** 1-date 2-ls 3-who 4-pwd"

## 使用死循环，目的是为了当用户输入的字符并非要求的字符时，不能直接退出脚本，而是再次重新开始
while :
do
  ## 使用read实现与用户交互，提示让用户输入一个数字
  read -p "please input a number 1-4: " n
  case $n in
      1)
        date
        # 退出while循环
        break
        ;;
      2)
        ls
        break
        ;;
      3)
        who
        break
        ;;
      4)
        pwd
        break
        ;;
      *)
        ## 如果输入的并不是1-4的数字，提示错误
        echo "Wrong input, try again!!"
        ;;
  esac

  sleep 1s
done

<<'COMMENT'
1) read -p 可以在shell脚本中实现和用户交互的效果
2）case ... esac 这种逻辑判断用法，非常适合做选择题，尤其是选项很多的时候，选项也可以有多个值，比如1|5） 表示1或5
3）如果想要反复和用户交互，必须使用while循环，并借助break或者continue来控制循环流程
4）break表示退出循环体，continue表示结束本次循环，开始下一次循环
COMMENT