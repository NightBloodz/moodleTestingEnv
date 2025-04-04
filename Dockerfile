# Use official PHP image with Apache
FROM php:8.1-apache

# Install required dependencies for Xdebug and other extensions
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libzip-dev \
    libicu-dev \
    zip \
    git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli pdo pdo_mysql zip intl \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Configure Xdebug
COPY xdebug.ini /usr/local/etc/php/conf.d/
COPY custom.ini /usr/local/etc/php/conf.d/

# Expose port 80
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]
