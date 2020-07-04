SETTINGS_COMPLETE=false

if [[ $TERM_PROGRAM == "vscode" ]] ; then
printf "\e[31m
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
環境エラー問題はvscodeのターミナルでは行わないでください
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[m
"
  EXIT=false
  return 2>&- || exit
fi

printf "
【openssl】:チェック中...
"
source ~/projects/env_error_questions/env_error_tools/openssl_checker.sh

if [[ $EXIT == "true" ]] ; then
  EXIT=false
  return 2>&- || exit
fi

printf "
【openssl】:チェック完了
"

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

printf "
【mysql】:チェック中...
"
source ~/projects/env_error_questions/env_error_tools/mysql_checker.sh
if [[ $EXIT == "true" ]] ; then
  EXIT=false
  return 2>&- || exit
fi
printf "
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
あなたのmysqlは
$MYSQL_VER
です。
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
printf "
【mysql】:チェック完了
"

printf "
【database】:バックアップ作成中...
"
source ~/projects/env_error_questions/env_error_tools/db_backup.sh
printf "
【database】:バックアップ作成完了...
"

SETTINGS_COMPLETE=true
