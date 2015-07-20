==================
Launch an instance
==================

.. toctree::
   :maxdepth: 1

   launch-instance-neutron.rst
   launch-instance-nova.rst

An instance is a VM that OpenStack provisions on a compute node.
This guide shows you how to launch a minimal instance using the
:term:`CirrOS` image that you added to your environment
in the :doc:`glance` chapter. In these steps, you use the
command-line interface (CLI) on your controller node or any system with
the appropriate OpenStack client libraries. To use the dashboard, see the
`OpenStack User Guide
<http://docs.openstack.org/user-guide/dashboard.html>`__.

Launch an instance using
:doc:`OpenStack Networking (neutron) <launch-instance-neutron>` or
:doc:`legacy networking (nova-network) <launch-instance-nova>`.
For more information, see the `OpenStack User Guide
<http://docs.openstack.org/user-guide/cli_launch_instances.html>`__.

.. note::

   These steps reference example components created in previous
   chapters. You must adjust certain values such as IP addresses to
   match your environment.
