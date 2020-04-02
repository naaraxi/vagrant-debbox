#!/bin/bash

# Using single quotes instead of double quotes to make it work with special-character passwords
PASSWORD='vagrant'
PROJECTFOLDER='html'
PHP_VERSION='7.2'

# update / upgrade
echo "Updating apt-get..."
apt-get update
apt-get -y upgrade

apt-get install -y software-properties-common

# install git
echo "Installing Git..."
apt-get install -y git

# install nginx
echo "Installing Nginx..."
LC_ALL=C.UTF-8 apt-get install -y nginx nginx-full nginx-common

#install gpg
apt-get install -y gnupg > /dev/null 2>&1

# install php7-fpm
echo "Installing PHP..."

apt-get install -y apt-transport-https lsb-release ca-certificates
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list
apt update

apt-get install -y php${PHP_VERSION}-mysql
apt-get install -y php${PHP_VERSION}-common
apt-get install -y php${PHP_VERSION}-mcrypt
apt-get install -y php${PHP_VERSION}-zip
apt-get install -y php${PHP_VERSION}-pdo
apt-get install -y php${PHP_VERSION}-mysqlnd
apt-get install -y php${PHP_VERSION}-opcache
apt-get install -y php${PHP_VERSION}-xml
apt-get install -y php${PHP_VERSION}-xdebug
apt-get install -y php${PHP_VERSION}-gd
apt-get install -y php${PHP_VERSION}-mysql
apt-get install -y php${PHP_VERSION}-intl
apt-get install -y php${PHP_VERSION}-mbstring
apt-get install -y php${PHP_VERSION}-bcmath
apt-get install -y php${PHP_VERSION}-json
apt-get install -y php${PHP_VERSION}-iconv
apt-get install -y php${PHP_VERSION}-soap
apt-get install -y php${PHP_VERSION}-fpm

# install mariadb and give password to installer
echo "Preparing MariaDB..."
apt-get install -y debconf-utils
debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD"

echo "Updating apt-get..."
apt-get update
 
echo "Installing MariaDB..."
apt-get install -y mariadb-server

apt-get -y --fix-broken install

# Nginx Config
echo "Configuring Nginx..."
cp /var/www/config/nginx_vhost /etc/nginx/sites-available/nginx_vhost
ln -s /etc/nginx/sites-available/nginx_vhost /etc/nginx/sites-enabled/

rm -rf /etc/nginx/sites-enabled/default

# Restarting Nginx for config to take effect
echo "Restarting Nginx..."
service nginx restart