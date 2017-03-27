========================
Configuration Management
========================

Maintaining an OpenStack cloud requires that you manage multiple
physical servers, and this number might grow over time. Because managing
nodes manually is error prone, we strongly recommend that you use a
configuration-management tool. These tools automate the process of
ensuring that all your nodes are configured properly and encourage you
to maintain your configuration information (such as packages and
configuration options) in a version-controlled repository.

.. note::

   Several configuration-management tools are available, and this guide does
   not recommend a specific one. The most popular ones in the OpenStack
   community are:

   * `Puppet <https://puppetlabs.com/>`_, with available `OpenStack
     Puppet modules <https://github.com/puppetlabs/puppetlabs-openstack>`_
   * `Ansible <https://www.ansible.com/>`_, with `OpenStack Ansible
     <https://github.com/openstack/openstack-ansible>`_
   * `Chef <http://www.getchef.com/chef/>`_, with available `OpenStack Chef
     recipes <https://github.com/openstack/openstack-chef-repo>`_

   Other newer configuration tools include `Juju <https://juju.ubuntu.com/>`_
   and `Salt <http://www.saltstack.com/>`_; and more mature configuration
   management tools include `CFEngine <http://cfengine.com/>`_ and `Bcfg2
   <http://bcfg2.org/>`_.
