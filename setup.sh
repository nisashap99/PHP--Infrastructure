#!/bin/bash

# Update system
dnf update -y

# Install Apache
dnf install -y httpd

systemctl enable httpd
systemctl start httpd

# Install PHP
dnf install -y php php-cli php-fpm php-mysqlnd php-json

# Install Git
dnf install -y git

# Go to web directory
cd /var/www/html

# Clone PHP application
git clone https://github.com/shahabsb94/PHP-Application.git .

# Set permissions
chown -R apache:apache /var/www/html

# Restart Apache
systemctl restart httpd


############################
# Install Docker
############################

dnf install -y dnf-plugins-core

dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo

dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

systemctl start docker
systemctl enable docker

usermod -aG docker ec2-user


############################
# Install Java & Jenkins
############################

dnf install -y java-17-openjdk fontconfig

wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

dnf install -y jenkins

systemctl daemon-reexec
systemctl enable jenkins
systemctl start jenkins

# Display Jenkins admin password
cat /var/lib/jenkins/secrets/initialAdminPassword