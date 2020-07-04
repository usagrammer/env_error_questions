ENV_QUESTION_NUMBER="11問目_"
printf "\e[31m
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Macのパスワードを入力してください。
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[m
"

sudo cd ..

source ~/projects/env_error_questions/env_error_tools/script.sh

if [[ $SETTINGS_COMPLETE != "true" ]] ; then
  SETTINGS_COMPLETE=false
  return 2>&- || exit
fi

ENV_QUESTION_NUMBER=""

sudo chown _mysql:_mysql /private/tmp
sudo chmod 755 /private/tmp

brew uninstall mysql@$MYSQL_VER
brew uninstall mysql@$OTHER_MYSQL_VER
rm -rf /usr/local/var/mysql
brew install mysql@$MYSQL_VER

sudo rm /tmp/mysql.sock
sudo rm /tmp/mysql.sock.lock
sudo pkill -kill -f mysql

source ~/projects/env_error_questions/env_error_tools/setting_completed.sh

  printf "
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

◆◆◆シチュエーション◆◆◆

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

mysqlが起動できなくなってしまい、mysqlを入れ直しても直らないそうです。

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Starting MySQL
./usr/local/Cellar/mysql@5.7/5.7.29/bin/mysqld_safe: line 647: /usr/local/var/mysql/$(hostname).err: No such file or directory
Logging to '/usr/local/var/mysql/$(hostname).err'.
/usr/local/Cellar/mysql@5.7/5.7.29/bin/mysqld_safe: line 144: /usr/local/var/mysql/$(hostname).err: No such file or directory
/usr/local/Cellar/mysql@5.7/5.7.29/bin/mysqld_safe: line 198: /usr/local/var/mysql/$(hostname).err: No such file or directory
/usr/local/Cellar/mysql@5.7/5.7.29/bin/mysqld_safe: line 906: /usr/local/var/mysql/$(hostname).err: No such file or directory
/usr/local/Cellar/mysql@5.7/5.7.29/bin/mysqld_safe: line 144: /usr/local/var/mysql/$(hostname).err: No such file or directory
 ERROR! The server quit without updating PID file (/usr/local/var/mysql/$(hostname).pid).

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

mysql.server startが成功するようにしてください。

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
