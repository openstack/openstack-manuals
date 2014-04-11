# network.sh
#
# Author: Trevor Roberts Jr (VMTrooper@gmail.com)
# This script is called by the Vagrant Shell Provisioner to build the student's lab machine.
#
# Vagrant's Shell Provisioner receives deployment instructions from this file.
# Removing this file without removing the Shell Provisioner command in the Vagrantfile
# will cause deployment errors
#
# See the remaining OpenStack Training Labs code for more details at GitHub:
# https://github.com/openstack/openstack-manuals/tree/master/doc/training-guides/training-labs

#Change to the root user
sudo su -
cd ~

#Get latest catalogs from Ubuntu
apt-get update
apt-get install -y vim

#Copy the deployment scripts to /root
cp -avr /vagrant/Scripts .
cd Scripts
mkdir Logs

#Execute the deployment scripts
#./auto_scripts.sh
echo "Execute PreInstall Script to Build Student Environment"
bash PreInstall/PreInstall.sh "single-node" > Logs/PreInstall.log

