EXIT=false
printf "
【shell】:チェック中...
"
source ~/projects/env_error_questions/env_error_tools/shell_checker.sh
printf "
【shell】:チェック完了
"

if [[ $EXIT == "true" ]] ; then
  return 2>&- || exit
fi

printf "\e[32m
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rubyの修復を開始します。
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
\e[m
"

printf "
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rbenvの再設定を行います
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"

if [ `echo $SHELL | grep 'zsh'` ] ; then ENV_FILE="zshrc" ; else ENV_FILE="bash_profile" ; fi
sed -i .bak '/rbenv init/d' ~/.$ENV_FILE
echo 'eval "$(rbenv init -)"' >> ~/.$ENV_FILE
source ~/.$ENV_FILE

printf "\e[31m
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rubyの入れ直しをしますか？（かなり時間がかかります）。

する y
しない n
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
\e[m
"

read input

if [ $input = y -o $input = ｙ ] ; then
  RBENV_GLOBAL=`rbenv global`
printf "\e[31m
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
途中でパスワードを求められたらMacのパスワードを入力してください。
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
\e[m
"

sudo cd .
  RUBY_VERSIONS=($(ls -1 ~/.rbenv/versions))
  sudo rm -rf ~/.rbenv
  for ruby in $RUBY_VERSIONS; do
    RUBY_CONFIGURE_OPTS="--with-readline-dir=`brew --prefix readline` --with-openssl-dir=`brew --prefix openssl`"
    rbenv install $ruby
  done
  rbenv global $RBENV_GLOBAL
  rbenv rehash
  gem install bundler
  gem install rails -v 6.0.0
  gem install rails -v 5.2.4
  gem install rails -v 5.0.7.2
  rbenv rehash
else
printf "
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rubyの入れ直しはしません。
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
fi

printf "\e[31m
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
途中でパスワードを求められたらMacのパスワードを入力してください。
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
\e[m
"

sudo cd .

rm -rf ~/.bundle/config
rm -rf .bundle
bundle config --global build.mysql2 --with-opt-dir="$(brew --prefix openssl)"
sudo chown -R $(whoami) $(gem environment gemdir)
sudo rm -rf $(gem environment gemdir)/specifications/default
gem update --system
gem pristine --all

bundle

printf "\e[32m
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rubyの修復が完了しました。
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
\e[m"
