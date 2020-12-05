ENV_QUESTION_NUMBER="1問目_"
source ~/projects/env_error_questions/env_error_tools/script.sh

if [[ $SETTINGS_COMPLETE != "true" ]] ; then
  SETTINGS_COMPLETE=false
  return 2>&- || exit
fi

ENV_QUESTION_NUMBER=""

gem uninstall rails -v 6.0.0
sed -i .bak '/rbenv init/d' ~/.$ENV_FILE
PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
source ~/.$ENV_FILE

source ~/projects/env_error_questions/env_error_tools/setting_completed.sh

  printf "
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

◆◆◆シチュエーション◆◆◆

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

基礎カリキュラムで初めてrailsに取り組むそうですが、gem install railsの時点で以下のようなエラーが出てしまうようです。

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
ERROR:  While executing gem ... (Gem::FilePermissionError)
    You don't have write permissions for the /Library/Ruby/Gems/2.6.0 directory.
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

gem install railsが通常通り成功するようにしてあげてください。

gem install rails -v 6.0.0

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
