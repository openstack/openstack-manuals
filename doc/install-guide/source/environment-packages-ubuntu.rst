OpenStack packages for Ubuntu
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ubuntu releases OpenStack with each Ubuntu release. Ubuntu LTS releases
are provided every two years. OpenStack packages from interim releases of
Ubuntu are made available to the prior Ubuntu LTS via the Ubuntu Cloud
Archive.

OpenStack Queens is available directly using Ubuntu 18.04 LTS and
OpenStack Mitaka is available directly using Ubuntu 16.04 LTS without
having to enable an Ubuntu Cloud Archive repository.

.. note::

   The set up of OpenStack packages described here needs to be done on
   all nodes: controller, compute, and Block Storage nodes.

.. warning::

   Your hosts must contain the latest versions of base installation
   packages available for your distribution before proceeding further.

.. note::

   Disable or remove any automatic update services because they can
   impact your OpenStack environment.


Enable the repository for Ubuntu Cloud Archive
----------------------------------------------

**OpenStack Stein for Ubuntu 18.04 LTS:**

.. code-block:: console

   # add-apt-repository cloud-archive:stein

**OpenStack Rocky for Ubuntu 18.04 LTS:**

.. code-block:: console

   # add-apt-repository cloud-archive:rocky

**OpenStack Queens for Ubuntu 16.04 LTS:**

.. code-block:: console

   # apt install software-properties-common
   # add-apt-repository cloud-archive:queens

Note that OpenStack Queens is included in Ubuntu 18.04 LTS without
enabling the Ubuntu Cloud Archive.

**OpenStack Pike for Ubuntu 16.04 LTS:**

.. code-block:: console

   # apt install software-properties-common
   # add-apt-repository cloud-archive:pike

.. note::

   For a full list of supported Ubuntu OpenStack releases,
   see "Ubuntu OpenStack release cycle" at
   https://www.ubuntu.com/about/release-cycle.


Finalize the installation
-------------------------

1. Upgrade packages on all nodes:

   .. code-block:: console

      # apt update && apt dist-upgrade

   .. note::

      If the upgrade process includes a new kernel, reboot your host
      to activate it.

2. Install the OpenStack client:

   **OpenStack Stein for Ubuntu 18.04 LTS:**

   .. code-block:: console

      # apt install python3-openstackclient

   **Others:**

   .. code-block:: console

      # apt install python-openstackclient
