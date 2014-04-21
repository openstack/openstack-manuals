# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile
# Author: Trevor Roberts Jr (VMTrooper@gmail.com)
#
# NOTE: Before attempting to use this file, follow the required Vagrant
# deployment steps:
#
# http://docs.vagrantup.com/v2/installation/index.html
#
# This file directs Vagrant on how to deploy the student VMs.
# It is possible to do a single-VM or multi-VM deployment based on
# the entries that are enabled in the "nodes" hash at the start of this file.
#
# By default, only the single VM (allinone) deployment type is enabled.
# For multi-VM, comment out 'allinone' and uncomment 'controller', 'compute',
# and 'network'.
#
# Vagrant uses VirtualBox Guest Additions to modify VM properties
# (hostname, IP, resource allocation) according to VM function.
#
# Vagrant's shell provisioner receives deployment instructions from the
# following files:
#   allinone.sh
#   controller.sh
#   compute.sh
#   network.sh
# Removing these files without removing the shell provisioner command will
# cause Vagrant errors.
#
# After determining the deployment type, build this environment by typing this
# command at the prompt:
#
# vagrant up
#
# Verify your VM status by typing this command at the prompt:
# vagrant status
#
# SSH to your VM by typing this command at the prompt:
# vagrant ssh vmname (for example: vagrant ssh compute)
#
# See the remaining OpenStack Training Labs code for more details at GitHub:
# https://github.com/openstack/openstack-manuals/tree/master/doc/training-guides/training-labs
nodes = {
    'allinone' => 51,
#    'controller' => 51,
#    'compute' => 201,
#    'network' => 210,
}

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Every Vagrant virtual environment requires a box (similar to OVA) to build
  # from. The Vagrantfile currently uses Ubuntu 12.04 LTS (aka Precise
  # Pangolin). Modify the line below and the box_url line to use a different
  # distribution

  config.vm.box = "precise64"

  # The URL from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # Define each VM's settings (ex: hostname, IP address, RAM, vCPU, etc.)
  nodes.each do |prefix, fourth_octet|
    config.vm.define "#{prefix}" do |box|
       box.vm.hostname = "#{prefix}"
       # Management network
       box.vm.network :private_network, ip: "10.10.10.#{fourth_octet}", :netmask => "255.255.255.0"
       # Data network
       box.vm.network :private_network, ip: "10.20.20.#{fourth_octet}", :netmask => "255.255.255.0"
       # API network
       box.vm.network :private_network, ip: "192.168.100.#{fourth_octet}", :netmask => "255.255.255.0"
       # Forward port 80 to host port 8080 for only the controller or
       # all-in-one deployment for Horizon
       if prefix == "controller" or prefix == "allinone"
         box.vm.network "forwarded_port", guest: 80, host: 8080
       end
       # Run the shell provisioning script file
       box.vm.provision :shell, :path => "#{prefix}.sh"
       # Advanced VirtualBox settings
       box.vm.provider :virtualbox do |vbox|
         # Single node resource allocations; will be more selective for
         # multi-node
         vbox.customize ["modifyvm", :id, "--memory", 2048]
         vbox.customize ["modifyvm", :id, "--cpus", 2]
         # Multi-node resource allocation based on the prefix name
         if prefix == "controller"
           vbox.customize ["modifyvm", :id, "--memory", 1024]
           vbox.customize ["modifyvm", :id, "--cpus", 1]
         elsif prefix == "compute"
           vbox.customize ["modifyvm", :id, "--memory", 2048]
           vbox.customize ["modifyvm", :id, "--cpus", 2]
         elsif prefix == "network"
           vbox.customize ["modifyvm", :id, "--memory", 1024]
           vbox.customize ["modifyvm", :id, "--cpus", 1]
         end
         # nicpromisc flag begins nic count at 1, not 0
         # Setting all NICs to promiscuous mode per Pranav's specification
         vbox.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]
         vbox.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]
         vbox.customize ["modifyvm", :id, "--nicpromisc4", "allow-all"]
       end
    end
  end
end
