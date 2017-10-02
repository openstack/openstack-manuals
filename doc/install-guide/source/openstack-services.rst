==========================
Install OpenStack services
==========================

The installation of individual OpenStack services is covered in the
Project Installation Guides that are available at the following
locations:

* `OpenStack Installation Guides for Pike
  <https://docs.openstack.org/pike/install/>`_

.. Note that this guide is release independent, so we will add more
   entries to the list above.

Minimal deployment
==================

At a minimum, you need to install the following services. Install the services
in the order specified below:

* Identity service – `keystone installation for Pike
  <https://docs.openstack.org/keystone/pike/install/>`_
* Image service – `glance installation for Pike
  <https://docs.openstack.org/glance/pike/install/>`_
* Compute service – `nova installation for Pike
  <https://docs.openstack.org/nova/pike/install/>`_
* Networking service – `neutron installation for Pike
  <https://docs.openstack.org/neutron/pike/install/>`_

We advise to also install the following components after you have installed the
minimal deployment services:

* Dashboard – `horizon installation for Pike <https://docs.openstack.org/horizon/pike/install/>`_
* Block Storage service – `cinder installation for Pike <https://docs.openstack.org/cinder/pike/install/>`_
