FROM epcallan/php7-testing-phpunit:7.2-phpunit7
MAINTAINER Navalona Ramanantoanina <job.navds@gmail.com>

RUN apt-get update \
    && apt-get install -y librabbitmq-dev curl software-properties-common \
        libfreetype6-dev libjpeg62-turbo-dev libssl-dev libicu-dev \
        libcurl4-openssl-dev libzip-dev libbz2-dev libmcrypt-dev git openssl zip 

RUN docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install iconv \
    && docker-php-ext-install intl \
    && docker-php-ext-install bz2 \
    && docker-php-ext-install bcmath 

RUN pecl install mongodb amqp \
    && docker-php-ext-install mongodb \
    && docker-php-ext-enable amqp \
    && echo "extension=mongodb.so" > /usr/local/etc/php/conf.d/ext-mongodb.ini

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt install -y nodejs \
    && npm install -g yarn
