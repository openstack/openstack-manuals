#!/bin/bash
#
# About: Set up dependencies for VirtualBox sandbox meant for OpenStack Labs.
#
# Contact: pranav@aptira.com
# Copyright: Aptira @aptira,aptira.com
# License: Apache Software License (ASL) 2.0
################################################################################
#                                                                              #
# This script will carry out few tasks after installing OpenStack.             #
#                                                                              #
################################################################################
SCRIPT_DIR=$(cd $(dirname "$0") && pwd)

# Create tenant
keystone tenant-create --name Os_Training

echo -n "Enter tenant id: "
read TENANT_ID

# Create user and assign required role
keystone user-create --name=trainee --pass=cloud --tenant-id $TENANT_ID --email=user_one@domain.com
echo -n "Enter user id: "
read USER_ID
keystone role-list
echo -n "Enter role id: "
read ROLE_ID
keystone user-role-add --tenant-id $TENANT_ID  --user-id $USER_ID --role-id $ROLE_ID

# Create network
quantum net-create --tenant-id $TENANT_ID training_network

# Add subnet
quantum subnet-create --tenant-id $TENANT_ID training_network 25.25.25.0/24
echo -n "Enter subnet id: "
read SUBNET_ID

# Create router
quantum router-create --tenant-id $TENANT_ID training_router
echo -n "Enter router id: "
read ROUTER_ID

# Add router to L3 agent
quantum agent-list # to get the l3 agent ID
echo -n "Enter L3 agent id: "
read L3_AGENT_ID
quantum l3-agent-router-add $L3_AGENT_ID $ROUTER_ID

# Add router to subnet
quantum router-interface-add $ROUTER_ID $SUBNET_ID

echo "For logging into your cloud via Dashboard, use the following credentials:"
echo "User name: trainee"
echo "Password: cloud"
