============================
Configuring the compute node
============================

The `Installation Guides
<https://docs.openstack.org/ocata/install/>`_
provide instructions for installing multiple compute nodes.
To make the compute nodes highly available, you must configure the
environment to include multiple instances of the API and other services.

Configuring high availability for instances
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As of September 2016, the OpenStack High Availability community is
designing and developing an official and unified way to provide high
availability for instances. We are developing automatic
recovery from failures of hardware or hypervisor-related software on
the compute node, or other failures that could prevent instances from
functioning correctly, such as, issues with a cinder volume I/O path.

More details are available in the `user story
<http://specs.openstack.org/openstack/openstack-user-stories/user-stories/proposed/ha_vm.html>`_
co-authored by OpenStack's HA community and `Product Working Group
<https://wiki.openstack.org/wiki/ProductTeam>`_ (PWG), where this feature is
identified as missing functionality in OpenStack, which
should be addressed with high priority.

Existing solutions
~~~~~~~~~~~~~~~~~~

The architectural challenges of instance HA and several currently
existing solutions were presented in `a talk at the Austin summit
<https://www.openstack.org/videos/video/high-availability-for-pets-and-hypervisors-state-of-the-nation>`_,
for which `slides are also available <http://aspiers.github.io/openstack-summit-2016-austin-compute-ha/>`_.

The code for three of these solutions can be found online at the following
links:

* `a mistral-based auto-recovery workflow
  <https://github.com/gryf/mistral-evacuate>`_, by Intel
* `masakari <https://launchpad.net/masakari>`_, by NTT
* `OCF RAs
  <http://aspiers.github.io/openstack-summit-2016-austin-compute-ha/#/ocf-pros-cons>`_,
  as used by Red Hat and SUSE

Current upstream work
~~~~~~~~~~~~~~~~~~~~~

Work is in progress on a unified approach, which combines the best
aspects of existing upstream solutions. More details are available on
`the HA VMs user story wiki
<https://wiki.openstack.org/wiki/ProductTeam/User_Stories/HA_VMs>`_.

To get involved with this work, see the section on the
:doc:`ha-community`.
