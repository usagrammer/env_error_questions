printf "
アップデート確認中...
"

QDIR=`pwd`

cd ~/projects/env_error_questions/

git pull --ff-only

cd $QDIR

printf "
アップデート完了
"

printf "\e[31m
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
設定の確認を開始します。
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[m
"

sleep 1

source ~/projects/env_error_questions/env_error_tools/env_setting.sh

if [[ $SETTINGS_COMPLETE != "true" ]] ; then
terminal-notifier -message '設定に不具合が発生しています。ターミナルをご確認ください。' -sound Glass
  printf "\e[31m
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
設定に不具合が発生しています。ターミナルをご確認ください。
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[m
"
  return 2>&- || exit
fi

printf "\e[31m
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
問題の仕込みを開始します。ターミナルを画面隅に隠してください。
仕込みが完了するか不具合が発生したら画面右上に通知が表示されます。
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\e[m
"

printf "3..."
sleep 1
printf "2..."
sleep 1
printf "1..."
sleep 1
