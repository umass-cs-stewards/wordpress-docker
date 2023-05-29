FROM wordpress:php8.0-fpm


RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && apt-get install -y nodejs git vim
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
php composer-setup.php && \
php -r "unlink('composer-setup.php');" && \
mv composer.phar /usr/local/bin/composer
RUN composer --help
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
php wp-cli.phar --info && \
chmod +x wp-cli.phar && \
mv wp-cli.phar /usr/local/bin/wp

RUN wp --help --allow-root
