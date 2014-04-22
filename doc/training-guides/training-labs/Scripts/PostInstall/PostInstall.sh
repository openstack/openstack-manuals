#!/bin/sh
#
# About:Setup Dependences for Virtual Box Sandbox
#       meant for OpenStack Labs.
#
# Contact: pranav@aptira.com
# Copyright : Aptira @aptira,aptira.com
# License: Apache Software License (ASL) 2.0
#################################################################################
#                                                                               #
# This Script will carry out few tasks after installing OpenStack.		        #
#                                                                               #
#################################################################################
SCRIPT_DIR=$(cd $(dirname "$0") && pwd)

# Create Tenant
keystone tenant-create --name Os_Training

echo "Enter Tenant ID"
read $Tenant_ID

#Create User and assign required role
keystone user-create --name=trainee --pass=cloud --tenant-id $Tenant_ID --email=user_one@domain.com
echo "Enter User ID"
read $User_ID
keystone user-role-add --tenant-id $Tenant_ID  --user-id $User_ID --role-id $role_id

# Create Networks
quantum net-create --tenant-id $Tenant_ID training_network

# Add Subnet
quantum subnet-create --tenant-id $Tenant_ID training_network 25.25.25.0/24
echo "Enter Subnet ID"
read $Subnet_ID

# Create Router
quantum router-create --tenant-id $Tenant_ID training_router
echo "Enter Router ID"
read $training_router

# Add Router to L3 Agent
quantum agent-list (to get the l3 agent ID)
echo "Enter L3 agent ID"
read $l3_agent_ID
quantum l3-agent-router-add $l3_agent_ID training_router

# Add Router To Subnet
quantum router-interface-add $training_router $Subnet_ID


echo "For Logging into your Cloud Via. Dashboard, use the following Credentials :"
echo "User Name: trainee"
echo "Password: cloud"
