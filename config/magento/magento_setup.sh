#!/bin/bash

PROJECT_NAME='[__PROJECT_NAME__]'

cd /var/www/html/

# Import database
echo 'Importing database...'
mysql -u root -pvagrant ${PROJECT_NAME} -e "CREATE DATABASE IF NOT EXISTS ${PROJECT_NAME} DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;"
zcat /var/www/config/database.sql.gz | mysql -u root -pvagrant ${PROJECT_NAME}
mysql -u root -pvagrant ${PROJECT_NAME} -e "UPDATE core_config_data SET value = 'http://${PROJECT_NAME}.vbox/' WHERE path LIKE '%/base_url%' AND scope = 'default'"

# Composer packages
echo 'Installing composer packages...'
cp /var/www/config/magento/env.php /var/www/html/app/etc/
composer install > /dev/null 2>&1

# Install magento
echo 'Running bin/magento setup:upgrade && setup:di:compile...'
php bin/magento setup:upgrade > /dev/null 2>&1
php bin/magento setup:di:compile > /dev/null 2>&1

# Static content
echo 'Deploying static content...'
php bin/magento setup:static-content:deploy -f en_US sv_SE
