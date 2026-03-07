#!/bin/bash

# Update server
sudo yum update -y

# Install Apache Web Server
sudo yum install httpd -y

# Start Apache
sudo systemctl start httpd

# Enable Apache on boot
sudo systemctl enable httpd

# Check Apache status
sudo systemctl status httpd

# Install PHP
sudo yum install php php-mysqlnd php-fpm php-json php-cli -y

# Check PHP version
php -v

# Restart Apache
sudo systemctl restart httpd