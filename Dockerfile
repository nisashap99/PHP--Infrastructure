# Use official PHP Apache image
FROM php:8.2-apache

# Set working directory
WORKDIR /var/www/html

# Install useful extensions
RUN docker-php-ext-install mysqli

# Copy application code
COPY index.php .

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html

# Expose web port
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]