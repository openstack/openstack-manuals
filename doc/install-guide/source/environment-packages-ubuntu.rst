OpenStack packages for Ubuntu
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ubuntu releases OpenStack packages as part of each Ubuntu release and for
Ubuntu LTS releases via the Ubuntu Cloud Archive.

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

**OpenStack Queens:**

.. code-block:: console

   # apt install software-properties-common
   # add-apt-repository cloud-archive:queens

.. end

**OpenStack Pike:**

.. code-block:: console

   # apt install software-properties-common
   # add-apt-repository cloud-archive:pike

.. end

.. note::

   The Ubuntu Cloud Archive pockets for Pike and Queens provide
   OpenStack packages for Ubuntu 16.04 LTS; OpenStack Queens is
   installable direct using Ubuntu 18.04 LTS (due for release in
   April 2018).


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
