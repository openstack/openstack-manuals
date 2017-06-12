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





Enable the backports repository
-------------------------------

The Newton release is available directly through the official
Debian backports repository. To use this repository, follow
the instruction from the official
`Debian website <https://backports.debian.org/Instructions/>`_,
which basically suggest doing the following steps:

#. On all nodes, adding the Debian 8 (Jessie) backport repository to
   the source list:

   .. code-block:: console

      # echo "deb http://http.debian.net/debian jessie-backports main" \
        >>/etc/apt/sources.list

   .. end

   .. note::

      Later you can use the following command to install a package:

      .. code-block:: console

         # apt -t jessie-backports install ``PACKAGE``

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




