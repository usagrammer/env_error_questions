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

Fetching mysql2 0.5.1
Installing mysql2 0.5.1 with native extensions
Gem::Ext::BuildError: ERROR: Failed to build gem native extension.

current directory:
/Users/tech-camo/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/mysql2-0.5.1/ext/mysql2
/Users/tech-camo/.rbenv/versions/2.6.5/bin/ruby -I /Users/tech-camo/.rbenv/versions/2.6.5/lib/ruby/2.6.0 -r
./siteconf20200704-62913-17xk7y8.rb extconf.rb --with-opt-dir\=/usr/local/opt/openssl@1.1
checking for rb_absint_size()... yes
checking for rb_absint_singlebit_p()... yes
checking for rb_wait_for_single_fd()... yes
checking for -lmysqlclient... no
-----
mysql client is missing. You may need to 'brew install mysql' or 'port install mysql', and try again.
-----
*** extconf.rb failed ***
Could not create Makefile due to some reason, probably lack of necessary
libraries and/or headers.  Check the mkmf.log file for more details.  You may
need configuration options.

Provided configuration options:
	--with-opt-dir
	--with-opt-include
	--without-opt-include=${opt-dir}/include
	--with-opt-lib
	--without-opt-lib=${opt-dir}/lib
	--with-make-prog
	--without-make-prog
	--srcdir=.
	--curdir
	--ruby=/Users/tech-camo/.rbenv/versions/2.6.5/bin/$(RUBY_BASE_NAME)
	--with-mysql-dir
	--without-mysql-dir
	--with-mysql-include
	--without-mysql-include=${mysql-dir}/include
	--with-mysql-lib
	--without-mysql-lib=${mysql-dir}/lib
	--with-mysql-config
	--without-mysql-config
	--with-mysql-dir
	--without-mysql-dir
	--with-mysql-include
	--without-mysql-include=${mysql-dir}/include
	--with-mysql-lib
	--without-mysql-lib=${mysql-dir}/lib
	--with-mysqlclientlib
	--without-mysqlclientlib

To see why this extension failed to compile, please check the mkmf.log which can be found here:

/Users/tech-camo/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/extensions/x86_64-darwin-19/2.6.0/mysql2-0.5.1/mkmf.log

extconf failed, exit code 1

Gem files will remain installed in
/Users/tech-camo/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/mysql2-0.5.1 for inspection.
Results logged to
/Users/tech-camo/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/extensions/x86_64-darwin-19/2.6.0/mysql2-0.5.1/gem_make.out

\e[31m
An error occurred while installing mysql2 (0.5.3), and Bundler cannot
continue.
Make sure that gem install mysql2 -v '0.5.1' --source 'https://rubygems.org/'
succeeds before bundling.
\e[m

In Gemfile:
  mysql2

◆◆◆シチュエーション◆◆◆

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

初めてのRailsだそうですがbundle installをすると上記のエラーが出て進めないようです。

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

bundle installが成功するようにしてください。

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
