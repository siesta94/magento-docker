#!/bin/bash
set -xe

cd /opt/magento2/ && composer install
#cd /opt/magento2/ && bin/magento setup:install --base-url=http://3.8.154.4/ --db-host=magento-docker_db --db-name=magento2 --db-user=root --db-password='root' --admin-firstname=Magento --admin-lastname=User --admin-email=aiocteam22@gmail.com --admin-user=admin --admin-password=admin123 --language=en_US --currency=USD --timezone=America/Chicago --use-rewrites=1 --search-engine=elasticsearch7 --elasticsearch-host=magento-docker_elastisearch --elasticsearch-port=9200

chown -R nginx. /opt/magento2
chmod -R 755 /opt/magento2
/usr/sbin/php-fpm --daemonize && /usr/sbin/nginx -c /etc/nginx/nginx.conf -g 'daemon off;'
