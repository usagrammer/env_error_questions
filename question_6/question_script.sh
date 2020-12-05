ENV_QUESTION_NUMBER="5問目_"
source ~/projects/env_error_questions/env_error_tools/script.sh

if [[ $SETTINGS_COMPLETE != "true" ]] ; then
  SETTINGS_COMPLETE=false
  return 2>&- || exit
fi

ENV_QUESTION_NUMBER=""

gem uninstall -aIx rails
gem uninstall -aIx railties
gem install rails -v 6.0.0

source ~/projects/env_error_questions/env_error_tools/setting_completed.sh

  printf "
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

◆◆◆シチュエーション◆◆◆

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

rails newで次のエラーが発生して上手くいかないようです。

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

find_spec_for_exe': can't find gem railties (= 6.0.2) with executable rails (Gem::GemNotFoundException)

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

次のコマンドが成功するようにしてください。

rails _6.0.2_ new env_error_rails_new -d mysql

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
