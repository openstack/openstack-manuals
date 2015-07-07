=================
Basic environment
=================

.. note::

   The draft version of this guide focuses on the future Liberty
   release and will not work for the current Kilo release. If you want
   to install Kilo, you must use the `Kilo
   version <http://docs.openstack.org>`__ of this guide instead.

This chapter explains how to configure each node in the
:ref:`overview-example-architectures`,
including the two-node architecture with legacy
networking :ref:`figure-legacy-network-hw`
and three-node architecture with OpenStack Networking
(neutron) :ref:`figure-neutron-network-hw`.

.. note::

   Although most environments include Identity, Image service, Compute,
   at least one networking service, and the dashboard, the Object
   Storage service can operate independently. If your use case only
   involves Object Storage, you can skip to :ref:`swift` after
   configuring the appropriate nodes for it. However, the dashboard requires at
   least the Image service and Compute.

.. note::

   You must use an account with administrative privileges to configure
   each node. Either run the commands as the ``root`` user or configure
   the ``sudo`` utility.

.. note::

   The :command:`systemctl enable` call on openSUSE outputs a warning message
   when the service uses SysV Init scripts instead of native systemd
   files. This warning can be ignored.


.. include:: basics-security.rst
.. include:: basics-database.rst
.. include:: basics-queue.rst

.. toctree::
   :hidden:

   basics-security.rst
   basics-database.rst
   basics-queue.rst


.. TODO(karenb)
   section_basics-prerequisites.xml
   section_basics-networking.xml
   section_basics-ntp.xml
   section_basics-packages.xml
