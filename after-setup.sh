#!/bin/bash -e

# Go to WP directory.
cd html

# Update the user password.
wp user update admin --user_pass=ediamin

# discourage search engines
wp option update blog_public 0

# this is required for the .htaccess
touch wp-cli.local.yml
echo "apache_modules:
  - mod_rewrite
" > wp-cli.local.yml

# set pretty urls
wp rewrite structure '/%postname%/' --hard
wp rewrite flush --hard

rm wp-cli.local.yml

# delete akismet and hello dolly
wp plugin delete akismet
wp plugin delete hello

# Copy the favicon
cp ../favicon.ico .