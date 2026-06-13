#!/bin/bash

set -e -x

apt update -y
apt upgrade -y

apt install -y apache2 mariadb-server php php-mysql wget tar unzip

# Download the latest WordPress Installation Package
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz

# SQL setup variables
DB_NAME="wordpress_db"
DB_USER="wordpress_user"
DB_PASSWORD="your_strong_password"
DB_HOST="localhost"

# Create user and database for WordPress installation

sudo systemctl enable mariadb
sudo systemctl start mariadb
mysql -e "CREATE USER '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASSWORD}';"
mysql -e "CREATE DATABASE ${DB_NAME};"
mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO ${DB_USER}@localhost;"
mysql -e "FLUSH PRIVILEGES;"


# Create blog directory under document root and Install WordPress files 

mkdir /var/www/html/blog
cp -r wordpress/* /var/www/html/blog/

# Rename the sample config file for use

cp /var/www/html/blog/wp-config-sample.php /var/www/html/blog/wp-config.php

sudo sed -i "s/database_name_here/${DB_NAME}/g" /var/www/html/blog/wp-config.php
sudo sed -i "s/username_here/${DB_USER}/g" /var/www/html/blog/wp-config.php
sudo sed -i "s/password_here/${DB_PASSWORD}/g" /var/www/html/blog/wp-config.php
sudo sed -i "s/localhost/${DB_HOST}/g" /var/www/html/blog/wp-config.php


# Fix file permissions for Apache web server

sudo chown -R www-data:www-data /var/www/html/blog


# Run WordPress installation script 

sudo systemctl enable apache2
sudo systemctl start apache2
