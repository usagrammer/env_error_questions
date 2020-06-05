MYSQL_VER=`which mysql | grep mysql@`
MYSQL_VER=`awk '{print substr($0, index($0, "mysql"))}' <<< $MYSQL_VER | awk '{sub("/bin.*", "");print $0;}'`
MYSQL_VER=${MYSQL_VER##mysql@}
DB_BACKUP_NAME="`date "+%Y年%m月%d日%H時%M分%S秒"`_"$ENV_QUESTION_NUMBER"mysql@"$MYSQL_VER
DB_BACKUP_PATH="/Users/`whoami`/projects/env_error_questions/env_error_tools/db_backup/$DB_BACKUP_NAME.sql"
mkdir ~/projects/env_error_questions/env_error_tools/db_backup
mysqldump -u root --all-databases > ~/projects/env_error_questions/env_error_tools/db_backup/$DB_BACKUP_NAME.sql
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
