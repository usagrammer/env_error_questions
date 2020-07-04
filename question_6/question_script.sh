ENV_QUESTION_NUMBER="5問目_"
source ~/projects/env_error_questions/env_error_tools/script.sh

if [[ $SETTINGS_COMPLETE != "true" ]] ; then
  SETTINGS_COMPLETE=false
  return 2>&- || exit
fi

ENV_QUESTION_NUMBER=""

gem uninstall rails -v 5.1.0
gem uninstall railties -v 5.1.0

source ~/projects/env_error_questions/env_error_tools/setting_completed.sh

  printf "
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

◆◆◆シチュエーション◆◆◆

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

rails newで次のエラーが発生して上手くいかないようです。

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

find_spec_for_exe': can't find gem railties (= 5.1.0) with executable rails (Gem::GemNotFoundException)

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

次のコマンドが成功するようにしてください。

rails _5.1.0_ new env_error_rails_new -d mysql

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
