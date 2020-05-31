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

printf "\e[32m
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
mysqlの修復を開始します。
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
\e[m
"

printf "
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
mysqlのバージョンをチェックします。
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"

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

NO_MYSQL=false
if [[ $MYSQL_VER == "5.6" ]] ; then
  cd .
elif [[ $MYSQL_VER == "5.7" ]] ; then
  cd .
else
  printf "\e[31m
  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  mysqlに異常があります！
  mysql5.6を入れ直します。
  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  \e[m
  "
  MYSQL_VER="5.6"
  NO_MYSQL=true
fi

if [[ $NO_MYSQL == "false" ]] ; then
  printf "
  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  データベースのバックアップ作成を試みます。
  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  "

  printf "\e[31m
  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  パスワードの入力を求められたらMacのパスワードを入力してください。
  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  \e[m
  "
  sudo chown -R "$(whoami)":admin /usr/local/var/mysql
  sudo chmod 1777 /tmp
  sudo chown root:wheel /tmp
  sudo rm /tmp/mysql.sock
  sudo pkill -kill -f mysql
  mysql.server start
  sleep 3
  DB_BACKUP_NAME="`date "+%Y年%m月%d日%H時%M分%S秒"`_"MYSQL修復前"mysql@"$MYSQL_VER
  DB_BACKUP_PATH="/Users/`whoami`/projects/env_error_questions/env_error_tools/db_backup/$DB_BACKUP_NAME.sql"
  mkdir ~/projects/env_error_questions/env_error_tools/db_backup

  mysqldump -u root --all-databases > $DB_BACKUP_PATH
  : 'バックアップ作成失敗のとき'
  if [ -z `cat $DB_BACKUP_PATH` ];then
  printf "\e[31m
  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  データベースのバックアップに失敗しました
  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  \e[m
  "
  DB_BACKUP_SUCCESS=false
  else
  printf "\e[32m
  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  バックアップの作成に成功しました。
  ファイル名は

  $DB_BACKUP_PATH

  です。
  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  \e[m
  "
  DB_BACKUP_SUCCESS=true
  fi
fi


printf "\e[32m
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
mysqlを全て削除します。
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
\e[m
"
mysql.server stop
brew uninstall mysql
brew uninstall mysql@5.6
brew uninstall mysql@5.7
gem uninstall -aIx mysql2
sudo rm -rf /usr/local/var/mysql
sudo rm /etc/my.cnf
printf "\e[32m
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
mysql$MYSQL_VERを入れ直します。
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
\e[m
"
brew install mysql@$MYSQL_VER

sudo chown -R "$(whoami)":admin /usr/local/var/mysql
sudo chmod 1777 /private/tmp
sudo chown root:wheel /private/tmp

printf "\e[32m
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
mysqlを起動します。
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
\e[m
"

sudo rm -rf /tmp/mysql.sock
sudo pkill -KILL -f mysql
sudo pkill -KILL -f mysql
sudo pkill -KILL -f mysql
sleep 1
mysql.server start

if [[ $DB_BACKUP_SUCCESS = "true" ]] ; then
  printf "\e[32m
  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  バックアップからデータベースを復元します
  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  \e[m
  "

  sleep 1
  mysql -u root < $DB_BACKUP_PATH
  printf "\e[32m
  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  データベースの復元が完了しました。
  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  \e[m
  "
fi

if [ "echo `mysql.server status` | grep 'SUCCESS'" ] ; then
  printf "\e[32m
  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  mysqlの修復が完了しました。
  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  \e[m"
else
  printf "\e[31m
  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  mysqlの修復に失敗しました。
  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  \e[m"
fi
