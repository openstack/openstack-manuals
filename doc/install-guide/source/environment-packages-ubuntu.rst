OpenStack packages for Ubuntu
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ubuntu releases OpenStack with each Ubuntu release. Ubuntu LTS releases
are provided every two years. OpenStack packages from interim releases of
Ubuntu are made available to the prior Ubuntu LTS via the Ubuntu Cloud
Archive.

.. note::

   The archive enablement described here needs to be done on all nodes
   that run OpenStack services.


Archive Enablement
------------------

**OpenStack 2025.1 Epoxy for Ubuntu 24.04 LTS:**

.. code-block:: console

   # add-apt-repository cloud-archive:epoxy

**OpenStack 2024.2 Dalmatian for Ubuntu 24.04 LTS:**

.. code-block:: console

   # add-apt-repository cloud-archive:dalmatian

**OpenStack 2024.1 Caracal for Ubuntu 24.04 LTS:**

.. code-block:: console

   OpenStack Caracal is available by default using Ubuntu 24.04 LTS.

**OpenStack 2024.1 Caracal for Ubuntu 22.04 LTS:**

.. code-block:: console

   # add-apt-repository cloud-archive:caracal

**OpenStack 2023.2 Bobcat for Ubuntu 22.04 LTS:**

.. code-block:: console

   # add-apt-repository cloud-archive:bobcat

**OpenStack 2023.1 Antelope for Ubuntu 22.04 LTS:**

.. code-block:: console

   # add-apt-repository cloud-archive:antelope

**OpenStack Zed for Ubuntu 22.04 LTS:**

.. code-block:: console

   # add-apt-repository cloud-archive:zed

**OpenStack Yoga for Ubuntu 22.04 LTS:**

.. code-block:: console

   OpenStack Yoga is available by default using Ubuntu 22.04 LTS.

.. note::

   For a full list of supported Ubuntu OpenStack releases,
   see "Ubuntu OpenStack release cycle" at
   https://www.ubuntu.com/about/release-cycle.


Sample Installation
-------------------

For example, Nova service can be installed on compute
or control node as follows:

.. code-block:: console

   # apt install nova-compute


Client Installation
-------------------

The openstack client is the CLI for openstack operations
and is installed as follows:

.. code-block:: console

   # apt install python3-openstackclient
