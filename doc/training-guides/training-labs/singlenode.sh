#!/bin/sh
#
# About: Set up dependencies for VirtualBox sandbox meant for OpenStack Labs.
#
# Contact: pranav@aptira.com
# Copyright: Aptira @aptira,aptira.com
# License: Apache Software License (ASL) 2.0
###############################################################################
#                                                                             #
# Carry out tasks for setting up single node environment for OpenStack        #
#                                                                             #
###############################################################################

echo "Single node"

uname=
pass=
vm_id=
# Download the VM from repo/storage space on the Internet

# Register the VM and start the VM
# Execute the single node script to configure the network and getting Ubuntu
# ready for OpenStack
vboxmanage guestcontrol $vm_id execute --image "/bin/ls" --username $uname --password $pass --wait-exit --wait-stdout
# Snapshot 1. Basic settings

# Execute the single node install scripts and take snapshots after each script
# 1. Download all the packages using apt-get --download-only but not installing
# them.
# 2. Snapshot 2. Offline ready


# 3. Keystone
# 4. Snapshot 3. Keystone ready


# 5. Glance
# 6. Snapshot 4. Glance ready


# 7. Quantum
# 8. Snapshot 5. Quantum ready


# 9. Nova
# 10. Snapshot 6. Nova ready


# 11. Cinder
# 12. Snapshot 7. Cinder ready


# 13. Horizon
# 14. Snapshot 8. Horizon ready


# 15. Configure and kickstart VM in OpenStack
# 16. Snapshot 9. OpenStack configured
