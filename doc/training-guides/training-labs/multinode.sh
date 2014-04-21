#!/bin/sh
#
# About: Set up dependencies for VirtualBox sandbox meant for OpenStack Labs.
#
# Contact: pranav@aptira.com
# Copyright: Aptira @aptira,aptira.com
# License: Apache Software License (ASL) 2.0
###############################################################################
#                                                                             #
# Carry out tasks for setting up multi node environment for OpenStack         #
#                                                                             #
###############################################################################

echo "Multi node"
echo "This script is to be implemented later on. Please refer to single node for now."
uname=root
pass=cloud
vm_id="d57da699-ff1e-4b24-b270-78093a2b25a9"

# Download the VM from repo/storage space on the Internet

# Register the VM and start the VM
# Execute the single node script to configure the network
#vboxmanage guestcontrol $vm_id execute --image "/bin/ls" --username $uname --password $pass --wait-exit --wait-stdout

# Execute the single node install scripts and take snapshots after each script
# vboxmanage guestcontrol $vm_id execute --image "/bin/ls" --username $uname --password $pass --wait-exit --wait-stdout
# vboxmanage snapshot $vm_id take "test_snapshot" --description "test snapshot -- igore :D"
