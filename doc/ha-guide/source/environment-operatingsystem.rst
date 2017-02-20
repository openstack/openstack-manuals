===============================
Installing the operating system
===============================

The first step in setting up your highly available OpenStack cluster
is to install the operating system on each node.
Follow the instructions in the *Environment* section of the
`Installation Tutorials and Guides <https://docs.openstack.org/project-install-guide/ocata>`_
depending on your distribution.

The OpenStack Installation Tutorials and Guides also include a list of
the services that use passwords with important notes about using
them.

.. note::

   Before following this guide to configure the highly available
   OpenStack cluster, ensure the IP ``10.0.0.11`` and hostname
   ``controller`` are not in use.

This guide uses the following example IP addresses:

.. code-block:: none

   # controller
   10.0.0.11       controller # virtual IP
   10.0.0.12       controller1
   10.0.0.13       controller2
   10.0.0.14       controller3
