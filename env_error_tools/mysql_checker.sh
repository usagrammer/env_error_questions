EXIT=false
printf "
【shell】:チェック中...
"
source ~/projects/env_error_questions/env_error_tools/shell_checker.sh
printf "
【shell】:チェック完了
"

if [[ $EXIT == "true" ]] ; then
  EXIT=false
  return 2>&- || exit
fi

MYSQL_VER=""
MYSQL_VER=`which mysql | grep mysql@`
MYSQL_VER=`awk '{print substr($0, index($0, "mysql"))}' <<< $MYSQL_VER | awk '{sub("/bin.*", "");print $0;}'`
MYSQL_VER=${MYSQL_VER##mysql@}

if [[ $MYSQL_VER == "" ]] ; then
  BREW_LIST_MYSQL=($(brew list | grep mysql@))
  if [[ $BREW_LIST_MYSQL[2] == "" ]] ; then
  MYSQL_VER=${BREW_LIST_MYSQL[1]##mysql@}
  sed -i .bak '/opt\/mysql/d' ~/.$ENV_FILE
  echo "export PATH="/usr/local/opt/mysql@${MYSQL_VER}/bin:""'$PATH' >> ~/.$ENV_FILE
  source ~/.$ENV_FILE
  fi
fi

if [[ $MYSQL_VER == "5.6" ]] ; then
  OTHER_MYSQL_VER="5.7"
elif [[ $MYSQL_VER == "5.7" ]] ; then
  OTHER_MYSQL_VER="5.6"
else
  printf "\e[31m
  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  mysqlに異常があります！
  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  \e[m
  "
  EXIT=true
fi
