FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    libxml2-dev \
    libzip-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev  \
    libicu-dev

# Install and configure PHP extensions required by Moodle
RUN docker-php-ext-install gd zip soap exif pdo pdo_mysql intl mysqli opcache
RUN docker-php-ext-configure gd --with-freetype --with-jpeg

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Copy php.ini-production to php.ini
RUN cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini

# Set max_input_vars in php.ini
RUN echo "max_input_vars = 5000" >> /usr/local/etc/php/php.ini

# Set the working directory
WORKDIR /var/www/html

# Copy Moodle source code into the container
COPY . .

# Set permissions (adjust as necessary)
RUN chown -R www-data:www-data /var/www/html

# Expose port 80
EXPOSE 80

# Create local directory for moodledata
# TODO: Use volume here
RUN mkdir -p /var/www/moodledata && chown -R www-data:www-data /var/www/moodledata

CMD ["apache2-foreground"]