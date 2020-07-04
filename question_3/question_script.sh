ENV_QUESTION_NUMBER="2問目_"
source ~/projects/env_error_questions/env_error_tools/script.sh

if [[ $SETTINGS_COMPLETE != "true" ]] ; then
  SETTINGS_COMPLETE=false
  return 2>&- || exit
fi

ENV_QUESTION_NUMBER=""

sed -i .bak '/mysql@/d' ~/.$ENV_FILE
mysql.server stop
rm /tmp/mysql.sock
rm /tmp/mysql.sock.lock
pkill -kill -f mysql
PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
source ~/.$ENV_FILE

source ~/projects/env_error_questions/env_error_tools/setting_completed.sh

  printf "
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

◆◆◆シチュエーション◆◆◆

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

初めて環境構築をしているそうですがmysqlを起動しようとすると次のエラーが出てしまうようです。

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

zsh: command not found: mysql.server

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

次のコマンドでmysqlを起動できるようにしてあげてください。

mysql.server start

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
