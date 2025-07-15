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
echo "Enter php version/versions (for example 56 70 71 72 73 74 80 81 82 83):"
read -p ">" vers

site_link="https://raw.githubusercontent.com/muratbaslamis/vestacp-centos-multi-php-selector/main/fpm"

for ver in $vers; do
    # 83 -> 8.3, 56 -> 5.6, 74 -> 7.4, 80 -> 8.0
    ver_dot="${ver:0:1}.${ver:1}"
    yum-config-manager --enable remi-php$ver
    yum install -y php$ver php$ver-php-fpm php$ver-php-cli php$ver-php-mysqlnd php$ver-php-gd php$ver-php-mbstring php$ver-php-xml php$ver-php-opcache

    # Yedekleme ve config işlemleri
    if ! [ -d /home/admin/vst_install_backups/php$ver ]; then
        if ! [ -d /home/admin/vst_install_backups ]; then
            mkdir /home/admin/vst_install_backups
        fi
        mkdir /home/admin/vst_install_backups/php$ver
    fi
    cp -r /etc/opt/remi/php$ver/ /home/admin/vst_install_backups/php$ver/
    rm -f /etc/opt/remi/php$ver/php-fpm.d/*

    wget $site_link/php-fpm-$ver_dot.stpl -O /usr/local/vesta/data/templates/web/httpd/php-fpm-$ver_dot.stpl
    wget $site_link/php-fpm-$ver_dot.tpl -O /usr/local/vesta/data/templates/web/httpd/php-fpm-$ver_dot.tpl
    wget $site_link/php-fpm-$ver_dot.sh -O /usr/local/vesta/data/templates/web/httpd/php-fpm-$ver_dot.sh
    chmod a+x /usr/local/vesta/data/templates/web/httpd/php-fpm-$ver_dot.sh

done

systemctl restart httpd
