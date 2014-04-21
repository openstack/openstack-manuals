#!/bin/bash
#
# About: Set up dependencies for VirtualBox sandbox meant for OpenStack Labs.
#
# Contact: pranav@aptira.com
# Copyright: Aptira @aptira,aptira.com
# License: Apache Software License (ASL) 2.0
###############################################################################
#                                                                             #
# This script will install Quantum related packages and after installation, it#
# will configure Quantum, populate the database.                              #
#                                                                             #
###############################################################################

# Note: No Internet access required -- packages downloaded by PreInstall.sh
echo "Internet connection is not required for this script to run"
SCRIPT_DIR=$(cd $(dirname "$0") && pwd)

quantum_singlenode() {

    # 1. Install Quantum, OVS etc.
    apt-get install -y quantum-server openvswitch-switch openvswitch-datapath-dkms quantum-plugin-openvswitch quantum-plugin-openvswitch-agent dnsmasq quantum-dhcp-agent quantum-l3-agent

    # br-int will be used for VM integration
    ovs-vsctl add-br br-int
    # br-ex is used for Internet access (not covered in this guide)
    ovs-vsctl add-br br-ex
    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/SingleNode/interfaces-single" /etc/network/interfaces
    ovs-vsctl add-port br-ex eth1
    # May need to do this ...
    #iptables --table nat --append POSTROUTING --out-interface eth2 -j MASQUERADE
    #ptables --append FORWARD --in-interface br-ex -j ACCEPT

    # 2. Install Quantum configuration files
    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/SingleNode/ovs_quantum_plugin.ini" /etc/quantum/plugins/openvswitch/ovs_quantum_plugin.ini
    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/SingleNode/api-paste.ini" /etc/quantum/api-paste.ini
    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/SingleNode/quantum.conf" /etc/quantum/quantum.conf
    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/SingleNode/metadata_agent.ini" /etc/quantum/metadata_agent.ini

    # 3. Restart Quantum server
    for i in $( ls /etc/init.d/quantum-* ); do sudo $i restart; done
    service dnsmasq restart
}

quantum_multinode() {

    # Single node for now.
    quantum_singlenode
}

# For now it is just single node

if [ "$1" == "Single" ]; then
    quantum_singlenode
else
    quantum_multinode
fi
