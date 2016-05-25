=====================================
Install operating system on each node
=====================================

The first step in setting up your highly-available OpenStack cluster
is to install the operating system on each node.
Follow the instructions in the OpenStack Installation Guides:

- `CentOS and RHEL <http://docs.openstack.org/liberty/install-guide-rdo/environment.html>`_
- `openSUSE and SUSE Linux Enterprise Server  <http://docs.openstack.org/liberty/install-guide-obs/environment.html>`_
- `Ubuntu <http://docs.openstack.org/liberty/install-guide-ubuntu/environment.html>`_

The OpenStack Installation Guides also include a list of the services
that use passwords with important notes about using them.

This guide uses the following example IP addresses:

.. code-block:: none

   # controller
   10.0.0.11       controller # virtual IP
   10.0.0.12       controller1
   10.0.0.13       controller2
   10.0.0.14       controller3
