#!/bin/bash
#
# About: Set up dependencies for VirtualBox sandbox meant for OpenStack Labs.
#
# Contact: pranav@aptira.com
# Copyright: Aptira @aptira,aptira.com
# License: Apache Software License (ASL) 2.0
###############################################################################
#                                                                             #
# This script will install Nova related packages and after installation, it   #
# will configure Nova, populate the database.                                 #
#                                                                             #
###############################################################################

# Note: No Internet access required -- packages downloaded by PreInstall.sh
echo "Internet connection is not required for this script to run"
SCRIPT_DIR=$(cd $(dirname "$0") && pwd)

nova_singlenode() {

    # 1. Install Nova, OVS etc.
    apt-get install -y kvm libvirt-bin pm-utils nova-api nova-cert novnc nova-consoleauth nova-scheduler nova-novncproxy nova-doc nova-conductor nova-compute-kvm

    # 2. Install Nova configuration files
    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/SingleNode/nova/api-paste.ini" /etc/nova/api-paste.ini
    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/SingleNode/nova/nova.conf" /etc/nova/nova.conf
    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/SingleNode/libvirt/qemu.conf" /etc/libvirt/qemu.conf
    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/SingleNode/libvirt/libvirtd.conf" /etc/libvirt/libvirtd.conf
    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/SingleNode/libvirt/libvirt-bin.conf" /etc/init/libvirt-bin.conf
    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/SingleNode/libvirt/libvirt-bin" /etc/default/libvirt-bin
    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/SingleNode/nova/nova-compute.conf" /etc/nova/nova-compute.conf

    # Destroy default virtual bridges
    virsh net-destroy default
    virsh net-undefine default

    service dbus restart && service libvirt-bin restart

    # 3. Synch database
    nova-manage db sync

    # 4. Restart Nova services
    for i in $( ls /etc/init.d/nova-* ); do sudo $i restart; done

    # 5. This is just because I like to see the smiley faces :)
    nova-manage service list
}

nova_multinode() {

    # Single node for now.
    nova_singlenode
}

# For now it is just single node

if [ "$1" == "Single" ]; then
    nova_singlenode
else
    nova_multinode
fi
