#!/bin/bash
# Adding php wrapper
user="$1"
domain="$2"
ip="$3"
home_dir="$4"
docroot="$5"

wrapper_script='#!/opt/remi/php56/root/usr/bin/php-cgi -c /opt/remi/php56/root/etc/php.ini'
wrapper_file="$home_dir/$user/web/$domain/cgi-bin/php"

echo "$wrapper_script" > $wrapper_file
chown $user:$user $wrapper_file
chmod -f 751 $wrapper_file

exit 0
