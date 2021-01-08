ENV_QUESTION_NUMBER="13問目_"

source ~/projects/env_error_questions/env_error_tools/script.sh

if [[ $SETTINGS_COMPLETE != "true" ]] ; then
  SETTINGS_COMPLETE=false
  return 2>&- || exit
fi

ENV_QUESTION_NUMBER=""

rm Gemfile.lock
rm yarn.lock
bundle install
yarn install --check-files
rails db:drop
rails db:create
rails db:migrate
pkill -f puma
rails s

source ~/projects/env_error_questions/env_error_tools/setting_completed.sh

  printf "
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

◆◆◆シチュエーション◆◆◆

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

rails sを起動してlocalhost:3000にアクセスすると以下のようなエラーが発生してしまうようです。

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Webpacker::Manifest::MissingEntryError in Articles#index

Showing /Users/tech-camo/projects/env_error_questions/question_13/app/views/layouts/application.html.erb where line #9 raised:

Webpacker can't find application in /Users/tech-camo/projects/env_error_questions/question_13/public/packs/manifest.json. Possible causes:
1. You want to set webpacker.yml value of compile to true for your environment
   unless you are using the `webpack -w` or the webpack-dev-server.
2. webpack has not yet re-run to reflect updates.
3. You have misconfigured Webpacker's config/webpacker.yml file.
4. Your webpack configuration is not creating a manifest.
Your manifest contains:
{
}

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

localhost:3000にアクセスしてもエラーが発生しないようにしてください。

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
