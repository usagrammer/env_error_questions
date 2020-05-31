ENV_QUESTION_NUMBER="4問目_"
source ~/projects/env_error_questions/env_error_tools/script.sh

if [[ $SETTINGS_COMPLETE != "true" ]] ; then
  SETTINGS_COMPLETE=false
  return 2>&- || exit
fi

ENV_QUESTION_NUMBER=""

gem uninstall mysql2 -v 0.5.1
sed -i .bak '/mysql@/d' ~/.$ENV_FILE
PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
source ~/.$ENV_FILE

source ~/projects/env_error_questions/env_error_tools/setting_completed.sh

  printf "
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

◆◆◆シチュエーション◆◆◆

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

初めてのRailsだそうですがbundle installをすると以下のエラーが出て進めないようです。

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

\e[31m
An error occurred while installing mysql2 (0.5.3), and Bundler cannot
continue.
Make sure that gem install mysql2 -v '0.5.1' --source 'https://rubygems.org/'
succeeds before bundling.
\e[m

In Gemfile:
  mysql2

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

bundle installが成功するようにしてください。

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
