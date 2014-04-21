#!/bin/bash
#
# About: Set up dependencies for VirtualBox sandbox meant for OpenStack Labs.
#
# Contact: pranav@aptira.com
# Copyright: Aptira @aptira,aptira.com
# License: Apache Software License (ASL) 2.0
###############################################################################
#                                                                             #
# This script will configure Cinder volumes                                   #
#                                                                             #
###############################################################################

echo -n "Enter location of disk to be used for formatting: "
read $disk
# Assuming /dev/sdb for now

cat <<EOF | fdisk /dev/sdb
n
p
1

t
8e
w
EOF
partprobe
