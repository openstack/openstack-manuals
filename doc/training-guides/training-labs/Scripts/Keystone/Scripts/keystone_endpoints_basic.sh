#!/bin/bash
#
# About:Setup Dependences for Virtual Box Sandbox
#       meant for OpenStack Labs.
#
# Contact: pranav@aptira.com
# License: Apache Software License (ASL) 2.0
# Inspired by https://github.com/mseknibilel/OpenStack-Grizzly-Install-Guide
###############################################################################
#                                                                             #
# This Script will pupolate database and configure keystone related packages  #
# and after installaion, itbase.                                              #
#                                                                             #
###############################################################################

# Host address
HOST_IP=10.10.10.51
EXT_HOST_IP=192.168.100.51

# MySQL definitions
MYSQL_USER=keystoneUser
MYSQL_DATABASE=keystone
MYSQL_HOST=$HOST_IP
MYSQL_PASSWORD=keystonePass

# Keystone definitions
KEYSTONE_REGION=RegionOne
export SERVICE_TOKEN=ADMIN
export SERVICE_ENDPOINT="http://${HOST_IP}:35357/v2.0"

while getopts "u:D:p:m:K:R:E:T:vh" opt; do
  case $opt in
    u)
      MYSQL_USER=$OPTARG
      ;;
    D)
      MYSQL_DATABASE=$OPTARG
      ;;
    p)
      MYSQL_PASSWORD=$OPTARG
      ;;
    m)
      MYSQL_HOST=$OPTARG
      ;;
    K)
      MASTER=$OPTARG
      ;;
    R)
      KEYSTONE_REGION=$OPTARG
      ;;
    E)
      export SERVICE_ENDPOINT=$OPTARG
      ;;
    T)
      export SERVICE_TOKEN=$OPTARG
      ;;
    v)
      set -x
      ;;
    h)
      cat <<EOF
Usage: $0 [-m mysql_hostname] [-u mysql_username] [-D mysql_database] [-p mysql_password]
       [-K keystone_master ] [ -R keystone_region ] [ -E keystone_endpoint_url ]
       [ -T keystone_token ]

Add -v for verbose mode, -h to display this message.
EOF
      exit 0
      ;;
    \?)
      echo "Unknown option -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument" >&2
      exit 1
      ;;
  esac
done

if [ -z "$KEYSTONE_REGION" ]; then
  echo "Keystone region not set. Please set with -R option or set KEYSTONE_REGION variable." >&2
  missing_args="true"
fi

if [ -z "$SERVICE_TOKEN" ]; then
  echo "Keystone service token not set. Please set with -T option or set SERVICE_TOKEN variable." >&2
  missing_args="true"
fi

if [ -z "$SERVICE_ENDPOINT" ]; then
  echo "Keystone service endpoint not set. Please set with -E option or set SERVICE_ENDPOINT variable." >&2
  missing_args="true"
fi

if [ -z "$MYSQL_PASSWORD" ]; then
  echo "MySQL password not set. Please set with -p option or set MYSQL_PASSWORD variable." >&2
  missing_args="true"
fi

if [ -n "$missing_args" ]; then
  exit 1
fi

keystone service-create --name nova --type compute --description 'OpenStack Compute Service'
keystone service-create --name cinder --type volume --description 'OpenStack Volume Service'
keystone service-create --name glance --type image --description 'OpenStack Image Service'
keystone service-create --name keystone --type identity --description 'OpenStack Identity'
keystone service-create --name ec2 --type ec2 --description 'OpenStack EC2 service'
keystone service-create --name neutron --type network --description 'OpenStack Networking service'

create_endpoint () {
  case $1 in
    compute)
    keystone endpoint-create --region $KEYSTONE_REGION --service-id $2 --publicurl 'http://'"$EXT_HOST_IP"':8774/v2/$(tenant_id)s' --adminurl 'http://'"$HOST_IP"':8774/v2/$(tenant_id)s' --internalurl 'http://'"$HOST_IP"':8774/v2/$(tenant_id)s'
    ;;
    volume)
    keystone endpoint-create --region $KEYSTONE_REGION --service-id $2 --publicurl 'http://'"$EXT_HOST_IP"':8776/v1/$(tenant_id)s' --adminurl 'http://'"$HOST_IP"':8776/v1/$(tenant_id)s' --internalurl 'http://'"$HOST_IP"':8776/v1/$(tenant_id)s'
    ;;
    image)
    keystone endpoint-create --region $KEYSTONE_REGION --service-id $2 --publicurl 'http://'"$EXT_HOST_IP"':9292/' --adminurl 'http://'"$HOST_IP"':9292/' --internalurl 'http://'"$HOST_IP"':9292/'
    ;;
    identity)
    keystone endpoint-create --region $KEYSTONE_REGION --service-id $2 --publicurl 'http://'"$EXT_HOST_IP"':5000/v2.0' --adminurl 'http://'"$HOST_IP"':35357/v2.0' --internalurl 'http://'"$HOST_IP"':5000/v2.0'
    ;;
    ec2)
    keystone endpoint-create --region $KEYSTONE_REGION --service-id $2 --publicurl 'http://'"$EXT_HOST_IP"':8773/services/Cloud' --adminurl 'http://'"$HOST_IP"':8773/services/Admin' --internalurl 'http://'"$HOST_IP"':8773/services/Cloud'
    ;;
    network)
    keystone endpoint-create --region $KEYSTONE_REGION --service-id $2 --publicurl 'http://'"$EXT_HOST_IP"':9696/' --adminurl 'http://'"$HOST_IP"':9696/' --internalurl 'http://'"$HOST_IP"':9696/'
    ;;
  esac
}

for i in compute volume image object-store identity ec2 network; do
  id=`mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" -ss -e "SELECT id FROM service WHERE type='"$i"';"` || exit 1
  create_endpoint $i $id
done
