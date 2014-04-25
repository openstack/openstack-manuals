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
# This Script will install Nova related packages and after installaion, it    #
# will configure Nova, populate the database.                                 #
#                                                                             #
###############################################################################

# Note: You DoNot Need Internet for this due to the magic of --download-only
echo "Internet connection is not required for this script to run"
SCRIPT_DIR=$(cd $(dirname "$0") && pwd)

Nova_SingleNode() {

    # 1. Install Nova, OVS etc.
    apt-get install -y kvm libvirt-bin pm-utils nova-api nova-cert novnc nova-consoleauth nova-scheduler nova-novncproxy nova-doc nova-conductor nova-compute-kvm    

    # 2. Configure Nova Configuration files
    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/SingleNode/nova/api-paste.ini" /etc/nova/api-paste.ini
    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/SingleNode/nova/nova.conf" /etc/nova/nova.conf
    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/SingleNode/libvirt/qemu.conf" /etc/libvirt/qemu.conf
    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/SingleNode/libvirt/libvirtd.conf" /etc/libvirt/libvirtd.conf
    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/SingleNode/libvirt/libvirt-bin.conf" /etc/init/libvirt-bin.conf
    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/SingleNode/libvirt/libvirt-bin" /etc/default/libvirt-bin
    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/SingleNode/nova/nova-compute.conf" /etc/nova/nova-compute.conf
    # Destroy Default Virtual Bridges
    virsh net-destroy default
    virsh net-undefine default

    service dbus restart && service libvirt-bin restart

    # 3. Synch Database
    nova-manage db sync

    # 4. Restart Nova Services
    for i in $( ls /etc/init.d/nova-* ); do sudo $i restart; done

    # 5. This is just because I like to see the smiley faces :)
    nova-manage service list
}

Nova_MultiNode() {

    # Single Node For Now.
    Nova_SingleNode

}

# For Now its just single Node

if [ "$1" == "Single" ]; then
    Nova_SingleNode
else
    Nova_MultiNode
fi
