FROM php:8.0-apache

# Enable Apache modules
RUN a2enmod rewrite

# Install PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Set working directory
WORKDIR /var/www/html

# Copy project files
COPY .

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html

# Make Apache listen on Railway's PORT
RUN sed -i 's/Listen 80/Listen ${PORT}/g' /etc/apache2/ports.conf
RUN sed -i 's/:80/:${PORT}/g' /etc/apache2/sites-available/000-default.conf

# Expose port for Railway
EXPOSE ${PORT}

# Start Apache
CMD ["apache2-foreground"]