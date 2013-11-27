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
# Carry out tasks for settingup Multi Node Environment for OpenStack          #
# 									                                          #
#                                                                             #
###############################################################################

echo "Multi Node"
echo "This script is to be implemented later on, Please Refer to Single Node for now."
uname=root
pass=cloud
vm_id="d57da699-ff1e-4b24-b270-78093a2b25a9"

# Download The VM From Repo/Storage Space on Internet.

# Regester the VM & Start the VM.
# Execute the Single Node Script to configure the network.
#vboxmanage guestcontrol $vm_id execute --image "/bin/ls" --username $uname --password $pass --wait-exit --wait-stdout

# Execute the single node install scripts and take snapshots after each scriptboxmanage guestcontrol $vm_id execute --image "/bin/ls" --username $uname --password $pass --wait-exit --wait-stdout
# vboxmanage snapshot $vm_id take "test_snapshot" --description "test snapshot -- igore :D"
