MYSQL_VER=""
MYSQL_VER=`which mysql | grep mysql@`
MYSQL_VER=`awk '{print substr($0, index($0, "mysql"))}' <<< $MYSQL_VER | awk '{sub("/bin.*", "");print $0;}'`
MYSQL_VER=${MYSQL_VER##mysql@}

if [[ $MYSQL_VER == "" ]] ; then
  BREW_LIST_MYSQL=($(brew list | grep mysql@))
  if [[ $BREW_LIST_MYSQL[2] == "" ]] ; then
  MYSQL_VER=${BREW_LIST_MYSQL[1]##mysql@}
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
