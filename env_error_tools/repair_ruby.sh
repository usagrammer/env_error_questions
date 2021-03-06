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
printf "\e[32m
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rubyの入れ直しを行います。
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
\e[m
"

printf "\e[32m
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
opensslの入れ直しを行います。
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
\e[m
"

  brew uninstall --ignore-dependencies openssl
  brew uninstall --ignore-dependencies openssl
printf "\e[31m
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
パスワードの入力を求められたらMacのパスワードを入力してください。
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
\e[m
"
  sudo rm -rf /usr/local/etc/openssl@1.1
  sudo rm -rf /usr/local/etc/openssl
  brew install openssl

  sed -i .bak '/export PATH=\/usr\/local\/opt\/openssl/d' ~/.$ENV_FILE
  echo "export PATH=`brew --prefix openssl`/bin:\$PATH" >> ~/.$ENV_FILE
  PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
  source ~/.$ENV_FILE
  OPENSSL_VERSION=`openssl version`
  OPENSSL_VERSION=(`echo $OPENSSL_VERSION`)
  brew switch openssl $OPENSSL_VERSION[2]

printf "\e[32m
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
opensslの入れ直しが完了しました。
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
\e[m
"

  sudo cd .

  RUBY_VERSIONS=($(ls -1 ~/.rbenv/versions))
  sudo rm -rf $(gem environment gemdir)/specifications/default

  RAILS_VERSIONS=($(gem list ^rails$))
  RAILS_VERSIONS=`echo $RAILS_VERSIONS | cut -d"(" -f2 | cut -d")" -f1 | sed 's/,//g'`
  RAILS_VERSIONS=($(echo $RAILS_VERSIONS))

  BUNDLER_VERSIONS=($(gem list ^bundler$))
  BUNDLER_VERSIONS=`echo $BUNDLER_VERSIONS | cut -d"(" -f2 | cut -d")" -f1 | sed 's/,//g'`
  BUNDLER_VERSIONS=($(echo $BUNDLER_VERSIONS))

  if [[ $RAILS_VERSIONS == "" ]] ; then RAILS_VERSIONS="6.0.2" ; fi
  if [[ $BUNDLER_VERSIONS == "" ]] ; then BUNDLER_VERSIONS="2.1.4" ; fi

printf "
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rubyを全て削除します。
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
  sudo rm -rf ~/.rbenv
printf "
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
以下のバージョンのrubyを入れ直します。
$RUBY_VERSIONS
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
  for ruby in $RUBY_VERSIONS; do
    RUBY_CONFIGURE_OPTS="--with-readline-dir=`brew --prefix readline` --with-openssl-dir=`brew --prefix openssl`"
printf "
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
ruby$rubyをインストールしています（かなり時間がかかります）。
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
    rbenv install $ruby -v
printf "
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
ruby$rubyのインストールが完了しました。
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
  done
  rbenv global $RBENV_GLOBAL
  rbenv rehash

printf "
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
以下のバージョンのbundlerを入れ直します。
$BUNDLER_VERSIONS
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
for bundler in $BUNDLER_VERSIONS; do
printf "
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
bundler$bundlerをインストールしています。
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
    gem install bundler -v $bundler
printf "
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
bundler$bundlerのインストールが完了しました。
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
done

rbenv rehash

  printf "
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
以下のバージョンのrailsを入れ直します。
$RAILS_VERSIONS
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
  for rails in $RAILS_VERSIONS; do
printf "
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rails$railsをインストールしています。
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
    gem install rails -v $rails
printf "
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rails$railsのインストールが完了しました。
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
  done

rbenv rehash

else
printf "
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rubyの入れ直しはしません。
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
fi

printf "\e[32m
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
bundle configを修正します。
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
\e[m
"
rm -rf ~/.bundle/config
rm -rf .bundle
bundle config --global build.mysql2 --with-opt-dir="$(brew --prefix openssl)"
printf "\e[32m
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
gemを修正します。
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
\e[m
"

printf "\e[31m
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
パスワードの入力を求められたらMacのパスワードを入力してください。
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
\e[m
"

sudo chown -R $(whoami) $(gem environment gemdir)
sudo rm -rf $(gem environment gemdir)/specifications/default
gem update --system
gem pristine --all
sudo rm -rf $(gem environment gemdir)/specifications/default

bundle

printf "\e[32m
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rubyの修復が完了しました。
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
\e[m"
