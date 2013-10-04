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
# Carry out tasks for settingup Single Node Environment for OpenStack         #
# 									                                          #
#                                                                             #
###############################################################################

echo "Single Node"

uname=
pass=
vm_id=
# Download The VM From Repo/Storage Space on Internet.

# Regester the VM & Start the VM.
# Execute the Single Node Script to configure the network and getting Ubuntu
# Ready for openstack.
vboxmanage guestcontrol $vm_id execute --image "/bin/ls" --username $uname --password $pass --wait-exit --wait-stdout
# Snapshot 1. Basic Settings

# Execute the single node install scripts and take snapshots after each script
# 1. Download all the packages using apt-get --download-only but not installing
# them.
# 2. Snapshot 2. Offline Ready


# 3. Keystone
# 4. Snapshot 3. Keystone Ready


# 5. Glance
# 6. Snapshot 4. Glance Ready


# 7. Quantum
# 8. Snapshot 5. Quantum Ready


# 9. Nova
# 10. Snapshot 6. Nova Ready


# 11. Cinder
# 12. Snapshot 7. Cinder Ready


# 13. Horizon
# 14. Snapshot 8. Horizon Ready


# 15. Configure and Kickstart VM in OpenStack
# 16. Snapshot 9. OpenStack Configured
