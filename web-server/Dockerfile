FROM amazonlinux:latest

#Variable for client name
ENV CLIENT=
WORKDIR /opt/


#Update repo
COPY configs/nginx.repo /etc/yum.repos.d/nginx.repo
RUN yum update -y

#Install NGINX and copy configurations
RUN yum clean all && yum -y install nginx
RUN rm -rf /etc/nginx/nginx.conf
COPY configs/nginx.conf /etc/nginx/nginx.conf
COPY configs/magento.conf /etc/nginx/conf.d/magento.conf

#Install PHP
RUN amazon-linux-extras install -y epel 
RUN amazon-linux-extras install -y php7.3
RUN yum -y install php-gd \
	php-soap \
	php-mbstring \
	php-ldap \
	php-imagick \
	php-xml \
	php-pecl-apcu \
	php-opcache \
	libc-client-devel \
	php-devel \
	uw-imap-static \
	libxml2-devel \
	php-bcmath \
	certbot \
	python2-certbot-nginx \
	php-posix
COPY configs/magento-fpm.conf /etc/php-fpm.d/magento.conf

#Install COMPOSER
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv ./composer.phar /usr/bin/composer
RUN yum install -y php-intl.x86_64

COPY app/magento2 /opt/magento2

#COPY ENTRYPOINT TO CONTAINER
COPY configs/docker-entrypoint.sh /usr/bin/docker-entrypoint.sh
RUN chmod +x /usr/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
