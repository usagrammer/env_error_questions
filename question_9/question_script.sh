ENV_QUESTION_NUMBER="9問目_"
source ~/projects/env_error_questions/env_error_tools/script.sh

if [[ $SETTINGS_COMPLETE != "true" ]] ; then
  SETTINGS_COMPLETE=false
  return 2>&- || exit
fi

ENV_QUESTION_NUMBER=""

yarn install --check-files
gem install rails -v 6.0.0
bundle install
rm Gemfile.lock
bundle config --delete without
bundle install --without development test

source ~/projects/env_error_questions/env_error_tools/setting_completed.sh

  printf "
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

◆◆◆シチュエーション◆◆◆

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

rails sで以下のエラーが発生して上手くいかないようです。自分で色々と試行錯誤したそうですがお手上げとのことです。

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

cannot load such file -- spring/watcher (LoadError)

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

rails sが成功するようにしてください。
※rails s起動後にlocalhost:3000にアクセスするとデータベースが無いというエラーが出ますがrails sが出来れば問題ありません。

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
