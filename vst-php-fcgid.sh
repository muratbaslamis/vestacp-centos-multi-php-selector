#!/bin/bash

# check root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 0
fi

# check OS
if [[ ! -f /etc/centos-release ]]; then
    echo "This script must be run on CentOS 7"
    exit 0
fi

# Enable Remi repo for multiple PHP versions
if ! rpm -qa | grep -qw remi-release; then
    yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
    yum install -y yum-utils epel-release wget
fi

echo "You can enter multiple versions through 'space'."
echo "Enter php version/versions (for example 5.6 7.0 7.1 7.2 7.3 7.4 8.0 8.1 8.2 8.3):"
read -p ">" vers

site_link="https://raw.githubusercontent.com/muratbaslamis/vestacp-centos-multi-php-selector/main/fcgid"

for ver in $vers; do
    yum-config-manager --enable remi-php$ver
    yum install -y php$ver php$ver-php-cgi php$ver-php-cli php$ver-php-mysqlnd php$ver-php-gd php$ver-php-mbstring php$ver-php-xml php$ver-php-opcache

    wget $site_link/phpfcgid-$ver.stpl -O /usr/local/vesta/data/templates/web/httpd/phpfcgid-$ver.stpl
    wget $site_link/phpfcgid-$ver.tpl -O /usr/local/vesta/data/templates/web/httpd/phpfcgid-$ver.tpl
    wget $site_link/phpfcgid-$ver.sh -O /usr/local/vesta/data/templates/web/httpd/phpfcgid-$ver.sh
    chmod a+x /usr/local/vesta/data/templates/web/httpd/phpfcgid-$ver.sh

done

systemctl restart httpd
