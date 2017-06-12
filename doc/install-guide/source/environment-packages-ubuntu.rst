OpenStack packages
~~~~~~~~~~~~~~~~~~

Distributions release OpenStack packages as part of the distribution or
using other methods because of differing release schedules. Perform
these procedures on all nodes.

.. note::

   The set up of OpenStack packages described here needs to be done on
   all nodes: controller, compute, and Block Storage nodes.

.. warning::

   Your hosts must contain the latest versions of base installation
   packages available for your distribution before proceeding further.

.. note::

   Disable or remove any automatic update services because they can
   impact your OpenStack environment.


Enable the OpenStack repository
-------------------------------

.. code-block:: console

   # apt install software-properties-common
   # add-apt-repository cloud-archive:ocata

.. end





Finalize the installation
-------------------------

1. Upgrade the packages on all nodes:


.. code-block:: console

   # apt update && apt dist-upgrade

.. end




   .. note::

      If the upgrade process includes a new kernel, reboot your host
      to activate it.

2. Install the OpenStack client:


.. code-block:: console

   # apt install python-openstackclient

.. end




