ENV_QUESTION_NUMBER="5問目_"
source ~/projects/env_error_questions/env_error_tools/script.sh

if [[ $SETTINGS_COMPLETE != "true" ]] ; then
  SETTINGS_COMPLETE=false
  return 2>&- || exit
fi

ENV_QUESTION_NUMBER=""

bundle config --delete build.mysql2
gem uninstall mysql2 -v 0.5.1

source ~/projects/env_error_questions/env_error_tools/setting_completed.sh

  printf "
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Installing mysql2 0.5.1 with native extensions
Gem::Ext::BuildError: ERROR: Failed to build gem native extension.

current directory:
/Users/tech-camo/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/mysql2-0.5.1/ext/mysql2
/Users/tech-camo/.rbenv/versions/2.6.5/bin/ruby -I /Users/tech-camo/.rbenv/versions/2.6.5/lib/ruby/2.6.0 -r
./siteconf20200704-65486-1hj92ri.rb extconf.rb
checking for rb_absint_size()... yes
checking for rb_absint_singlebit_p()... yes
checking for rb_wait_for_single_fd()... yes
-----
Using mysql_config at /usr/local/opt/mysql@5.7/bin/mysql_config
-----
checking for mysql.h... yes
checking for errmsg.h... yes
checking for SSL_MODE_DISABLED in mysql.h... yes
checking for SSL_MODE_PREFERRED in mysql.h... yes
checking for SSL_MODE_REQUIRED in mysql.h... yes
checking for SSL_MODE_VERIFY_CA in mysql.h... yes
checking for SSL_MODE_VERIFY_IDENTITY in mysql.h... yes
checking for MYSQL.net.vio in mysql.h... yes
checking for MYSQL.net.pvio in mysql.h... no
checking for MYSQL_ENABLE_CLEARTEXT_PLUGIN in mysql.h... yes
checking for SERVER_QUERY_NO_GOOD_INDEX_USED in mysql.h... yes
checking for SERVER_QUERY_NO_INDEX_USED in mysql.h... yes
checking for SERVER_QUERY_WAS_SLOW in mysql.h... yes
checking for MYSQL_OPTION_MULTI_STATEMENTS_ON in mysql.h... yes
checking for MYSQL_OPTION_MULTI_STATEMENTS_OFF in mysql.h... yes
checking for my_bool in mysql.h... yes
-----
Don't know how to set rpath on your system, if MySQL libraries are not in path mysql2 may not load
-----
-----
Setting libpath to /usr/local/opt/mysql@5.7/lib
-----
creating Makefile

current directory: /Users/tech-camo/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/mysql2-0.5.1/ext/mysql2
make "DESTDIR=" clean

current directory: /Users/tech-camo/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/mysql2-0.5.1/ext/mysql2
make "DESTDIR="
compiling client.c
compiling infile.c
compiling mysql2_ext.c
compiling result.c
compiling statement.c
linking shared-object mysql2/mysql2.bundle
ld: library not found for -lssl
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [mysql2.bundle] Error 1

make failed, exit code 2

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
