#!/bin/bash

# Using single quotes instead of double quotes to make it work with special-character passwords
PHP_VERSION='7.2'

PASSWORD='vagrant'
PROJECTFOLDER='html'

# update / upgrade
echo "Updating apt-get..."
apt-get update > /dev/null 2>&1
apt-get -y upgrade > /dev/null 2>&1

apt-get install -y software-properties-common > /dev/null 2>&1

# install git
echo "Installing Git..."
apt-get install -y git > /dev/null 2>&1

# install nginx
echo "Installing Nginx..."
LC_ALL=C.UTF-8 apt-get install -y nginx nginx-full nginx-common > /dev/null 2>&1

#install gpg
apt-get install -y gnupg > /dev/null 2>&1

# install php7-fpm
echo "Installing PHP..."

apt-get install -y apt-transport-https lsb-release ca-certificates > /dev/null 2>&1
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list
apt update > /dev/null 2>&1

apt-get install -y php${PHP_VERSION}-mysql > /dev/null 2>&1
apt-get install -y php${PHP_VERSION}-common > /dev/null 2>&1
apt-get install -y php${PHP_VERSION}-mcrypt > /dev/null 2>&1
apt-get install -y php${PHP_VERSION}-zip > /dev/null 2>&1
apt-get install -y php${PHP_VERSION}-pdo > /dev/null 2>&1
apt-get install -y php${PHP_VERSION}-mysqlnd > /dev/null 2>&1
apt-get install -y php${PHP_VERSION}-opcache > /dev/null 2>&1
apt-get install -y php${PHP_VERSION}-xml > /dev/null 2>&1
apt-get install -y php${PHP_VERSION}-xdebug > /dev/null 2>&1
apt-get install -y php${PHP_VERSION}-gd > /dev/null 2>&1
apt-get install -y php${PHP_VERSION}-mysql > /dev/null 2>&1
apt-get install -y php${PHP_VERSION}-intl > /dev/null 2>&1
apt-get install -y php${PHP_VERSION}-mbstring > /dev/null 2>&1
apt-get install -y php${PHP_VERSION}-bcmath > /dev/null 2>&1
apt-get install -y php${PHP_VERSION}-json > /dev/null 2>&1
apt-get install -y php${PHP_VERSION}-iconv > /dev/null 2>&1
apt-get install -y php${PHP_VERSION}-soap > /dev/null 2>&1
apt-get install -y php${PHP_VERSION}-fpm > /dev/null 2>&1

# install mariadb and give password to installer
echo "Preparing MariaDB..."
apt-get install -y debconf-utils > /dev/null 2>&1
debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD"

echo "Updating apt-get..."
apt-get update > /dev/null 2>&1
 
echo "Installing MariaDB..."
apt-get install -y mariadb-server > /dev/null 2>&1

echo "Installing composer..."
apt-get -y install composer > /dev/null 2>&1

apt-get -y --fix-broken install > /dev/null 2>&1

# Nginx Config
echo "Configuring Nginx..."
cp /var/www/config/nginx_vhost /etc/nginx/sites-available/nginx_vhost
ln -s /etc/nginx/sites-available/nginx_vhost /etc/nginx/sites-enabled/

rm -rf /etc/nginx/sites-enabled/default

# Restarting Nginx for config to take effect
echo "Restarting Nginx..."
service nginx restart > /dev/null 2>&1
rm /var/www/html/index.nginx-debian.html