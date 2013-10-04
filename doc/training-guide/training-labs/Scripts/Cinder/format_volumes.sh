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
# This Script will configure cinder volumes				      #
#                                                                             #
###############################################################################

# Note: You DoNot Need Internet for this due to the magic of --download-only
echo "Enter Location of Disk To be used for formatting"
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
