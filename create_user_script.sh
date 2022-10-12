#!/usr/bin/env bash
# 处理脚本参数
# -u 用户名
# -p 密码
# -m 创建home目录

help='create_user_script.sh usage:
            -u username
            -p login password
            -m create home dir , eg. /home/user
            -h print help
        '

user=""
pass=""
createHomeDir=false

while getopts "u:p:mh" opt_name; do # 通过循环，使用 getopts，按照指定参数列表进行解析，参数名存入 opt_name
  case "$opt_name" in               # 根据参数名判断处理分支
  'u')                              # -u
    user="$OPTARG"                  # 从 $OPTARG 中获取参数值
    ;;
  'p') # -p
    pass="$OPTARG"
    ;;
  'm') # -m
    createHomeDir=true
    ;;
  'h')
    echo "$help"
    exit 0
    ;;
  ?) # 其它未指定名称参数
    echo "$help"
    exit 2
    ;;
  esac
done

CMD="useradd"

if [ "$createHomeDir" == true ]; then
  CMD=$CMD" -m"
fi

if [ "$pass" != "" ]; then
  CMD=$CMD" -p$pass"
fi

echo "$CMD $user"
$CMD "$user"

if [ $? == 0 ]; then
  echo "create linux user success."
fi
