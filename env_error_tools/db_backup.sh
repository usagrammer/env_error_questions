MYSQL_VER=`which mysql | grep mysql@`
MYSQL_VER=`awk '{print substr($0, index($0, "mysql"))}' <<< $MYSQL_VER | awk '{sub("/bin.*", "");print $0;}'`
MYSQL_VER=${MYSQL_VER##mysql@}
DB_BACKUP_NAME="`date "+%Y年%m月%d日%H時%M分%S秒"`_"$ENV_QUESTION_NUMBER"mysql@"$MYSQL_VER
mkdir ~/projects/env_error_questions/env_error_tools/db_backup
mysqldump -u root --all-databases > ~/projects/env_error_questions/env_error_tools/db_backup/$DB_BACKUP_NAME.sql
