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
# This Script will install Neutron related packages and after installaion, it #
# will configure Neutron, populate the database.                              #
#                                                                             #
###############################################################################

# Note: You DoNot Need Internet for this due to the magic of --download-only
echo "Internet connection is not required for this script to run"
SCRIPT_DIR=$(cd $(dirname "$0") && pwd)

Neutron_SingleNode() {

    # 1. Install Neutron, OVS etc.
    apt-get install -y quantum-server openvswitch-switch openvswitch-datapath-dkms quantum-plugin-openvswitch quantum-plugin-openvswitch-agent dnsmasq quantum-dhcp-agent quantum-l3-agent

    #br-int will be used for VM integration
    ovs-vsctl add-br br-int
    #br-ex is used to make to access the internet (not covered in this guide)
    ovs-vsctl add-br br-ex
    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/SingleNode/interfaces-single" /etc/network/interfaces
    ovs-vsctl add-port br-ex eth1
    #iptables --table nat --append POSTROUTING --out-interface eth2 -j MASQUERADE # May need to do this ... 
    #ptables --append FORWARD --in-interface br-ex -j ACCEPT

    # 2. Configure Quantum Configuration files
    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/SingleNode/ovs_quantum_plugin.ini" /etc/quantum/plugins/openvswitch/ovs_quantum_plugin.ini
    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/SingleNode/api-paste.ini" /etc/quantum/api-paste.ini
    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/SingleNode/quantum.conf" /etc/quantum/quantum.conf
    cp --no-preserve=mode,ownership "$SCRIPT_DIR/Templates/SingleNode/metadata_agent.ini" /etc/quantum/metadata_agent.ini

    # 3. Restart Quantum Server
    for i in $( ls /etc/init.d/quantum-* ); do sudo $i restart; done
    service dnsmasq restart
}

Neutron_MultiNode() {

    # Single Node For Now.
    Neutron_SingleNode

}

# For Now its just single Node

if [ "$1" == "Single" ]; then
    Neutron_SingleNode
else
    Neutron_MultiNode
fi
