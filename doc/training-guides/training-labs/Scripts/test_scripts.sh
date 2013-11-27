#!/bin/bash
#
# This script is for testing Scripts inside this folder.
#
# Contact: pranav@aptira.com
# Copyright : Aptira @aptira,aptira.com
# License: Apache Software License (ASL) 2.0
###############################################################################
#                                                                             #
# Testing the Scripts				                                          #
#                                                                             #
###############################################################################

# Ignore the above content its for decorations
source Keystone/Scripts/Credentials.sh
echo -e "
    Run this script from inside your Virtual Machine or test machine
    this script is meant for testing the Scripts related to OpenStack and
    not related to Virtual Box.

    The sole aim of this script is to test all of the given OpenStack Scripts
    present in the sub folder which deploys OpenStack as it is very important
    that thee scripts install and configure OpenStack properly with a touch
    of reliability otherwise one mite as well use DevStack ;).
    "

echo -e "Warning!!! This may break your Operating System."

echo -e "Do you want to continue(y/N)?"
read cont

if [ "$cont" == "Y" -o "$cont" == "y" ]; then

    # Missing Exception Handlers :((, would have been very handy here
    echo "You Pressed Yes."
    echo -e "Testing PreInstall"
    bash PreInstall/PreInstall.sh "single-node" > Logs/PreInstall.log

    echo -e "Testing Keystone"
    bash Keystone/Keystone.sh > Logs/Keystone.log

    echo -e "Testing Glance"
    bash Glance/Glance.sh > Logs/Glance.log

    echo -e "Testing Cinder"
    bash Cinder/Cinder.sh > Logs/Cinder.log

    echo -e "Testing Neutron"
    bash Neutron/Neutron.sh > Logs/Neutron.log

    echo -e "Testing Nova"
    bash Nova/Nova.sh > Logs/Nova.log

    echo -e "Testing Horizon"
    bash Horizon/Horizon.sh > Logs/Horizon.log

    echo -e "Testing PostInstall"
    bash PostInstall/PostInstall.sh > Logs/PostInstall.log
fi
echo -e "Mostly the tests run fine ... although Im not sure !!! Please Read the Terminal Messages Carefully."
