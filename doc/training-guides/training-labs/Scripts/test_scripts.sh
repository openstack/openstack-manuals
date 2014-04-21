#!/bin/bash
#
# This script is for testing scripts inside this folder.
#
# Contact: pranav@aptira.com
# Copyright: Aptira @aptira,aptira.com
# License: Apache Software License (ASL) 2.0
###############################################################################
#                                                                             #
# Testing the scripts                                                         #
#                                                                             #
###############################################################################

source Keystone/Scripts/Credentials.sh
echo "
    Run this script from inside your virtual machine or test machine.
    This script is meant for testing the scripts related to OpenStack and
    not related to VirtualBox.

    The sole aim of this script is to test all of the OpenStack scripts
    present in the sub folder which deploys OpenStack, as it is very important
    that the scripts install and configure OpenStack properly with a touch
    of reliability otherwise one might as well use DevStack ;).
    "

echo "Warning!!! This may break your operating system."

echo -n "Do you want to continue (y/N)? "
read cont

if [ "$cont" == "Y" -o "$cont" == "y" ]; then

    # Missing Exception Handlers :((, would have been very handy here
    echo "You pressed Yes."
    echo "Testing PreInstall.sh"
    bash PreInstall/PreInstall.sh "single-node" > Logs/PreInstall.log

    echo "Testing Keystone.sh"
    bash Keystone/Keystone.sh > Logs/Keystone.log

    echo "Testing Glance.sh"
    bash Glance/Glance.sh > Logs/Glance.log

    echo "Testing Cinder.sh"
    bash Cinder/Cinder.sh > Logs/Cinder.log

    echo "Testing Neutron.sh"
    bash Neutron/Neutron.sh > Logs/Neutron.log

    echo "Testing Nova.sh"
    bash Nova/Nova.sh > Logs/Nova.log

    echo "Testing Horizon.sh"
    bash Horizon/Horizon.sh > Logs/Horizon.log

    echo "Testing PostInstall.sh"
    bash PostInstall/PostInstall.sh > Logs/PostInstall.log
fi
echo "Mostly the tests run fine ... although I'm not sure."
echo "Please read the terminal messages carefully."
