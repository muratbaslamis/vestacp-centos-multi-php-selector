#!/bin/bash
# Adding php wrapper
user="$1"
domain="$2"
ip="$3"
home_dir="$4"
docroot="$5"

wrapper_script="#!/bin/sh
PHPRC=/opt/remi/php80/root/etc
export PHPRC
export PHP_FCGI_MAX_REQUESTS=1000
export PHP_FCGI_CHILDREN=20
exec /opt/remi/php80/root/usr/bin/php-cgi
"
wrapper_file="$home_dir/$user/web/$domain/cgi-bin/fcgi-starter"

echo "$wrapper_script" > $wrapper_file
chown $user:$user $wrapper_file
chmod -f 751 $wrapper_file

exit 0
