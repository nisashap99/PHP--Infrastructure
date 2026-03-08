#!/bin/bash

# Update server
sudo dnf update -y

# Install Apache Web Server
sudo dnf install httpd -y

# Start Apache
sudo systemctl start httpd

# Enable Apache on boot
sudo systemctl enable httpd

# Check Apache status
sudo systemctl status httpd

# Install PHP
sudo dnf install php php-mysqlnd php-fpm php-json php-cli -y

# Check PHP version
php -v

# Restart Apache
sudo systemctl restart httpd

dnf -y install dnf-plugins-core
dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user
