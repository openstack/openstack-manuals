#!/bin/sh
#
# About:Setup Dependences for Virtual Box Sandbox
#       meant for OpenStack Labs.
#
# Contact: pranav@aptira.com
# Copyright : Aptira @aptira,aptira.com
# License: Apache Software License (ASL) 2.0
###############################################################################
#                                                                             #
# This Script will install Cinder related packages and after installaion, it  #
# will configure Cinder, populate the database.                               #
#                                                                             #
###############################################################################

# Note: You DoNot Need Internet for this due to the magic of --download-only
echo "Internet connection is not required for this script to run"
SCRIPT_DIR=$(cd $(dirname "$0") && pwd)

Install_Cinder() {

    # 1. Install Cinder
    apt-get install -y cinder-api cinder-scheduler cinder-volume iscsitarget open-iscsi iscsitarget-dkms

    # 2. Configure iscsi services
    sed -i 's/false/true/g' /etc/default/iscsitarget

    # 3. Restart the services
    service iscsitarget start
    service open-iscsi start

    # 4. Configure the templates
    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/api-paste.ini" /etc/cinder/api-paste.ini
    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/cinder.conf" /etc/cinder/cinder.conf

    # 5. MySQL database
    cinder-manage db sync

    # 5. Format the disks -- see if something else is available instead of
    # fdisk
    bash format_volumes # Need Expert Advice on this ....

    pvcreate /dev/sdb
    vgcreate cinder-volumes /dev/sdb

    # 6. Restart Cinder Related Services
    for i in $( ls /etc/init.d/cinder-* ); do $i restart; done
}
Install_Cinder
