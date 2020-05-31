EXIT=false

printf "
アップデート確認中...
"

QDIR=`pwd`

cd ~/projects/env_error_questions/

git pull

cd $QDIR

printf "
アップデート完了
"

if [ ! -e Gemfile ] ; then
    printf "\e[31m
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※
Railsプロジェクト内（my_first_appなど）に移動してから再度実行してください！
※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
\e[m
"
  EXIT=true
  return 2>&- || exit
fi

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

source ~/projects/env_error_questions/env_error_tools/repair_other.sh

if [[ $EXIT == "true" ]] ; then
  EXIT=false
  return 2>&- || exit
fi

source ~/projects/env_error_questions/env_error_tools/repair_ruby.sh

if [[ $EXIT == "true" ]] ; then
  EXIT=false
  return 2>&- || exit
fi

source ~/projects/env_error_questions/env_error_tools/repair_mysql.sh
