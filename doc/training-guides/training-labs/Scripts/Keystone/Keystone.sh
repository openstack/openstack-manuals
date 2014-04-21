#!/bin/bash
#
# About: Set up dependencies for VirtualBox sandbox meant for OpenStack Labs.
#
# Contact: pranav@aptira.com
# Copyright: Aptira @aptira,aptira.com
# License: Apache Software License (ASL) 2.0
###############################################################################
#                                                                             #
# This script will install Keystone related packages and after installation,  #
# it will configure Keystone, populate the database.                          #
#                                                                             #
###############################################################################

# Note: No Internet access required -- packages downloaded by PreInstall.sh
echo "Internet connection is not required for this script to run"
SCRIPT_DIR=$(cd $(dirname "$0") && pwd)

pre_keystone() {

    # 1. Database - MySQL and Python MySQL DB Connector
    debconf-set-selections  <<< 'mysql-server mysql-server/root_password password '$MYSQL_PASS''
    debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password '$MYSQL_PASS''
    apt-get install -y mysql-server python-mysqldb

    # Configure MySQL to listen to other all IP addresses
    sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/my.cnf

    # Restart MySQL service
    service mysql restart

    # 2. Install RabbitMQ
    apt-get install -y rabbitmq-server
    apt-get install -y ntp
    apt-get install -y vlan bridge-utils

    # Enable IP Forwarding
    sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf
    sysctl net.ipv4.ip_forward=1
}

keystone_conf() {

    # 1. Install Keystone
    apt-get -y install keystone

    # Create database Keystone, Glance, Quantum, Nova, and Cinder
    mysql -u "root" -p"$MYSQL_PASS" -e "create database keystone"
    mysql -u "root" -p"$MYSQL_PASS" -e "GRANT ALL ON keystone.* TO 'keystoneUser'@'%' IDENTIFIED BY 'keystonePass';"
    mysql -u "root" -p"$MYSQL_PASS" -e "create database glance"
    mysql -u "root" -p"$MYSQL_PASS" -e "GRANT ALL ON glance.* TO 'glanceUser'@'%' IDENTIFIED BY 'glancePass';"
    mysql -u "root" -p"$MYSQL_PASS" -e "create database quantum"
    mysql -u "root" -p"$MYSQL_PASS" -e "GRANT ALL ON quantum.* TO 'quantumUser'@'%' IDENTIFIED BY 'quantumPass';"
    mysql -u "root" -p"$MYSQL_PASS" -e "create database nova"
    mysql -u "root" -p"$MYSQL_PASS" -e "GRANT ALL ON nova.* TO 'novaUser'@'%' IDENTIFIED BY 'novaPass';"
    mysql -u "root" -p"$MYSQL_PASS" -e "create database cinder"
    mysql -u "root" -p"$MYSQL_PASS" -e "GRANT ALL ON cinder.* TO 'cinderUser'@'%' IDENTIFIED BY 'cinderPass';"

    # 2. Configure Keystone scripts (copy the template file)
    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/Keystone.conf" /etc/keystone/keystone.conf

    # 3. Restart the Keystone services
    service keystone restart

    # 4. Populate the database using db_sync
    keystone-manage db_sync

    # Create user and grant access to the user
    sh "$SCRIPT_DIR/Scripts/keystone_basic.sh"
    sh "$SCRIPT_DIR/Scripts/keystone_endpoints_basic.sh"

    # Load the authentication credentials
    source "$SCRIPT_DIR/Scripts/Credentials.sh"

    # List Keystone users
    keystone user-list
}

if [ "$#" -ne 1 ]; then
    # Create and populate required MySQL databases
    echo -n "Enter MySQL root password: "
    read MYSQL_PASS
else
    MYSQL_PASS=$1
fi

echo "Running pre_keystone"
pre_keystone

echo "Running keystone_conf"
keystone_conf
