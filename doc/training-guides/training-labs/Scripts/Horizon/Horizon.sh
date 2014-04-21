#!/bin/sh
#
# About: Set up dependencies for VirtualBox sandbox meant for OpenStack Labs.
#
# Contact: pranav@aptira.com
# Copyright: Aptira @aptira,aptira.com
# License: Apache Software License (ASL) 2.0
###############################################################################
#                                                                             #
# This script will install Horizon related packages.                          #
#                                                                             #
###############################################################################

# Note: No Internet access required -- packages downloaded by PreInstall.sh
echo "Internet connection is not required for this script to run"
SCRIPT_DIR=$(cd $(dirname "$0") && pwd)

install_horizon() {

    # 1. Install Horizon
    apt-get install -y openstack-dashboard memcached

    # 2. Restart apache2 and memcached
    service apache2 restart
    service memcached restart

    echo " You are done with the OpenStack installation "
}
install_horizon
