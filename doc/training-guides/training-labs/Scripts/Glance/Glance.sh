#!/bin/bash
#
# About: Set up dependencies for VirtualBox sandbox meant for OpenStack Labs.
#
# Contact: pranav@aptira.com
# Copyright: Aptira @aptira,aptira.com
# License: Apache Software License (ASL) 2.0
###############################################################################
#                                                                             #
# This script will install Glance related packages and after installation, it #
# will configure Glance                                                       #
#                                                                             #
###############################################################################

# Note: No Internet access required -- packages downloaded by PreInstall.sh
echo "Internet connection is not required for this script to run"
SCRIPT_DIR=$(cd $(dirname "$0") && pwd)

glance_conf() {

    # 1. Install Glance
    apt-get install -y glance

    # 2. Install the config files
    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/glance-api.conf" /etc/glance/glance-api.conf
    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/glance-api-paste.ini" /etc/glance/glance-api-paste.ini
    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/glance-registry-paste.ini" /etc/glance/glance-registry-paste.ini
    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/glance-registry.conf" /etc/glance/glance-registry.conf

    # 3. Restart Glance services
    service glance-api restart
    service glance-registry restart

    # 4. Sync Glance database
    glance-manage db_sync

    # 5. Upload CirrOS image to Glance
    source "$SCRIPT_DIR/../Keystone/Scripts/Credentials.sh"
    # CirrOS image downloaded in PreInstall.sh
    glance image-create --name myFirstImage --is-public true --container-format bare --disk-format qcow2 < "$SCRIPT_DIR"/cirros-*-x86_64-disk.img

    # 6. Check the image
    glance image-list
}

echo "Running Glance configuration"
glance_conf
