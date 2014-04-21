#!/bin/sh
#
# About: Set up dependencies for VirtualBox sandbox meant for OpenStack Labs.
#
# Contact: pranav@aptira.com
# Copyright: Aptira @aptira,aptira.com
# License: Apache Software License (ASL) 2.0
###############################################################################
#                                                                             #
# This script will install Cinder related packages and after installation, it #
# will configure Cinder, populate the database.                               #
#                                                                             #
###############################################################################

# Note: No Internet access required -- packages downloaded by PreInstall.sh
echo "Internet connection is not required for this script to run"
SCRIPT_DIR=$(cd $(dirname "$0") && pwd)

install_cinder() {

    # 1. Install Cinder
    apt-get install -y cinder-api cinder-scheduler cinder-volume iscsitarget open-iscsi iscsitarget-dkms

    # 2. Configure iscsi services
    sed -i 's/false/true/g' /etc/default/iscsitarget

    # 3. Restart the services
    service iscsitarget start
    service open-iscsi start

    # 4. Install the templates
    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/api-paste.ini" /etc/cinder/api-paste.ini
    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/cinder.conf" /etc/cinder/cinder.conf

    # 5. MySQL database
    cinder-manage db sync

    # 6. Format the disks -- see if something else is available instead of
    #    fdisk
    bash format_volumes # Need expert advice on this ....

    pvcreate /dev/sdb
    vgcreate cinder-volumes /dev/sdb

    # 7. Restart Cinder related services
    for i in $( ls /etc/init.d/cinder-* ); do $i restart; done
}
install_cinder
