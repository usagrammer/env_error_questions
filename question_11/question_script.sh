ENV_QUESTION_NUMBER="10問目_"
source ~/projects/env_error_questions/env_error_tools/script.sh

if [[ $SETTINGS_COMPLETE != "true" ]] ; then
  SETTINGS_COMPLETE=false
  return 2>&- || exit
fi

ENV_QUESTION_NUMBER=""

yarn install --check-files

gem uninstall -aIx mysql2

brew services stop mysql@$MYSQL_VER
mysql.server stop
brew uninstall mysql@$MYSQL_VER
rm -rf /usr/local/var/mysql
brew install mysql@$OTHER_MYSQL_VER

sed -i .bak '/mysql@/d' ~/.$ENV_FILE
echo "export PATH=/usr/local/opt/mysql@$OTHER_MYSQL_VER/bin:\$PATH" >> ~/.$ENV_FILE
PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
source ~/.$ENV_FILE

rm /tmp/mysql.sock
rm /tmp/mysql.sock.lock
pkill -kill -f mysql
mysql.server start

bundle

mysql.server stop
brew uninstall mysql@$OTHER_MYSQL_VER
rm -rf /usr/local/var/mysql
brew install mysql@$MYSQL_VER

sed -i .bak '/mysql@/d' ~/.$ENV_FILE
echo "export PATH=/usr/local/opt/mysql@$MYSQL_VER/bin:\$PATH" >> ~/.$ENV_FILE
PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
source ~/.$ENV_FILE

rm /tmp/mysql.sock
rm /tmp/mysql.sock.lock
pkill -kill -f mysql
brew services start mysql@$MYSQL_VER
mysql.server start

source ~/projects/env_error_questions/env_error_tools/setting_completed.sh

  printf "
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

◆◆◆シチュエーション◆◆◆

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

最近mysqlが不調になってしまい直してもらったそうですがrails db:createが上手くいかないようです。

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

rails aborted!
LoadError: dlopen(/Users/tech-camo/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/mysql2-0.5.3/lib/mysql2/mysql2.bundle, 9):
Library not loaded: /usr/local/opt/mysql@5.6/lib/libmysqlclient.20.dylib

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

rails db:createが成功するようにしてあげてください。

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
