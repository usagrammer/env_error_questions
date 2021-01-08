ENV_QUESTION_NUMBER="7問目_"
source ~/projects/env_error_questions/env_error_tools/script.sh

if [[ $SETTINGS_COMPLETE != "true" ]] ; then
  SETTINGS_COMPLETE=false
  return 2>&- || exit
fi

ENV_QUESTION_NUMBER=""

bundle install
yarn install --check-files
rails db:drop
rails db:create

source ~/projects/env_error_questions/env_error_tools/setting_completed.sh

  printf "
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

◆◆◆シチュエーション◆◆◆

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

rails db:migrateを実行すると次のエラーが発生してうまくいかないようです。

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

rails aborted!
StandardError: An error has occurred, all later migrations canceled:

Mysql2::Error: Specified key was too long; max key length is 767 bytes
/Users/tech-camo/projects/env_error_questions/question_7/db/migrate/20210108053529_devise_create_users.rb:39:in change

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

rails db:migrateが成功するようにしてあげてください。

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
