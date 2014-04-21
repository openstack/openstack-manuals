#!/bin/bash
#
# About: Set up dependencies for VirtualBox sandbox meant for OpenStack Labs.
#
# Contact: pranav@aptira.com
# Copyright: Aptira @aptira,aptira.com
# License: Apache Software License (ASL) 2.0
################################################################################
#                                                                              #
# This script downloads the required packages and configures the network       #
# interfaces.                                                                  #
# Downloading all packages here allows the remaining scripts to run without    #
# Internet access, which may be useful for training in unusual locations.      #
#                                                                              #
################################################################################

# Note: Internet access is required for this script to run.

SCRIPT_DIR=$(cd $(dirname "$0") && pwd)

# Add a few required packages
apt-get install -y ubuntu-cloud-keyring python-software-properties software-properties-common python-keyring
# Update package index
apt-get -y update

# Add OpenStack Grizzly repo
echo deb http://ubuntu-cloud.archive.canonical.com/ubuntu precise-updates/grizzly main >> /etc/apt/sources.list.d/grizzly.list

# Update package index, upgrade installed packages and upgrade kernel
apt-get -y --download-only update
apt-get -y --download-only upgrade
apt-get -y --download-only dist-upgrade
apt-get install -y --download-only ubuntu-cloud-keyring python-software-properties software-properties-common python-keyring

# Download CirrOS images for use in Glance.sh
wget --directory-prefix="$SCRIPT_DIR/../Glance" http://download.cirros-cloud.net/0.3.2/cirros-0.3.2-x86_64-disk.img

# Configure the network interfaces by using the templates in the Templates
# directory

# TO BE ADDED LATER ON.

#service networking restart
configure_networks() {
    # Check if it is single node or multi node
    if [ "$1" == "single-node" ]; then
        # Copy Single Node interfaces file to /etc/network/
        echo "Configuring Network for Single Node"
        cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/interfaces-single" /etc/network/interfaces

    else
        if [ "$1" == "multi-node" ]; then
            # If it is multi node, check which type of node it is
            case "$2" in
                "control")
                    # Configure network for control node
                    echo "Configuring network for control node"
                    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/interfaces-control" /etc/network/interfaces
                    ;;

                "compute")
                    # Configure network for compute node
                    echo "Configuring network for compute node"
                    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/interfaces-compute" /etc/network/interfaces
                    ;;
                "network")
                    # Configure network for network node
                    echo "Configuring network for network node"
                    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/interfaces-network" /etc/network/interfaces
                    ;;
                *)
                    echo "Invalid input, cannot figure out which node this is. Error!"
            esac
        fi
    fi

    service networking restart
}

single_node() {
    # Install all package on the given virtual machine
    apt-get install -y --download-only mysql-server python-mysqldb rabbitmq-server ntp vlan bridge-utils \
        keystone glance openvswitch-switch openvswitch-datapath-dkms quantum-server quantum-plugin-openvswitch \
        quantum-plugin-openvswitch-agent dnsmasq quantum-dhcp-agent quantum-l3-agent cpu-checker kvm libvirt-bin \
        pm-utils nova-api nova-cert novnc nova-consoleauth nova-scheduler nova-novncproxy nova-doc nova-conductor \
        nova-compute-kvm cinder-api cinder-scheduler cinder-volume iscsitarget open-iscsi iscsitarget-dkms openstack-dashboard memcached

    configure_networks $1 $2
}

multi_node() {
    # $2 will be the node definition -- like control node, compute node,
    # network node.
    configure_networks $1 $2
    # Install packages as per the node definition ...

    # TO BE DONE.

    # Also need to figure out whether to download all the packages even
    # if they are not playing any role in the given node to keep the scripts
    # simpler
}

if [ "$1" == "single-node" ]; then
    single_node $1 $2
else
    if [ "$1" == "multi-node" ]; then
        multi_node $1 $2
    else
        echo "Invalid option ... cannot proceed"
    fi
fi

echo -e "Your VM is ready for installing OpenStack\nYou don't need Internet access from now on."
