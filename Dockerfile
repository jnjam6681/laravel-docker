FROM php:7.2-fpm

#install php extentions
RUN apt-get update -y && apt-get install -y \
  gnupg \
  nginx \
  # curl \
  # git \
  # build-base \
  # libmemcached-dev \
  libmcrypt-dev \
  libjpeg-dev \
  libpng-dev \
  libmcrypt-dev \
  libxml2-dev
  # zlib-dev \
  # autoconf \
  # cyrus-sasl-dev \
  # libgsasl-dev
  # supervisor

RUN docker-php-ext-install mysqli mbstring pdo pdo_mysql tokenizer xml pcntl

# install the PHP gd library
RUN docker-php-ext-configure gd \
    --with-jpeg-dir=/usr/lib \
    --with-freetype-dir=/usr/include/freetype2 && \
    docker-php-ext-install gd

# install postgresql drivers
RUN apt-get update -y && apt-get install -y libpq-dev \
    && docker-php-ext-install pgsql pdo_pgsql

# install ZipArchive
RUN apt-get update -y && apt-get install -y libzip-dev && \
    docker-php-ext-configure zip --with-libzip && \
    # Install the zip extension
    docker-php-ext-install zip

# Install bcmath
RUN docker-php-ext-install bcmath

# install npm
# RUN curl -sL https://deb.nodesource.com/setup_11.x | bash - \
#     && apt-get update -y && apt-get install -y nodejs

# install yarn
# RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
#     && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
#     && apt-get update -y && apt-get install -y yarn

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

EXPOSE 80 443

ENTRYPOINT ["./start-up.sh"]
