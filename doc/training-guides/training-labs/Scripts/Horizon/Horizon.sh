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
# This Script will install Horizon related packages.                          #
#                                                                             #
###############################################################################

# Note: You DoNot Need Internet for this due to the magic of --download-only
echo "Internet connection is not required for this script to run"
SCRIPT_DIR=$(cd $(dirname "$0") && pwd)

Install_Horizon() {

    # 1. Install Horizon
    apt-get install -y openstack-dashboard memcached

    # 2. Restart Apache2 and Memcached
    service apache2 restart
    service memcached restart

    echo " You are done with OpenStack Installation "
}
Install_Horizon
