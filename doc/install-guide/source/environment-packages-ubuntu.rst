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

**OpenStack Xena for Ubuntu 20.04 LTS:**

.. code-block:: console

   # add-apt-repository cloud-archive:xena

**OpenStack Wallaby for Ubuntu 20.04 LTS:**

.. code-block:: console

   # add-apt-repository cloud-archive:wallaby

**OpenStack Victoria for Ubuntu 20.04 LTS:**

.. code-block:: console

   # add-apt-repository cloud-archive:victoria

**OpenStack Ussuri for Ubuntu 20.04 LTS:**

.. code-block:: console

   OpenStack Ussuri is available by default using Ubuntu 20.04 LTS.

**OpenStack Ussuri for Ubuntu 18.04 LTS:**

.. code-block:: console

   # add-apt-repository cloud-archive:ussuri

**OpenStack Train for Ubuntu 18.04 LTS:**

.. code-block:: console

   # add-apt-repository cloud-archive:train

**OpenStack Stein for Ubuntu 18.04 LTS:**

.. code-block:: console

   # add-apt-repository cloud-archive:stein

**OpenStack Rocky for Ubuntu 18.04 LTS:**

.. code-block:: console

   # add-apt-repository cloud-archive:rocky

**OpenStack Queens for Ubuntu 18.04 LTS:**

.. code-block:: console

   OpenStack Queens is available by default using Ubuntu 18.04 LTS.

.. note::

   For a full list of supported Ubuntu OpenStack releases,
   see "Ubuntu OpenStack release cycle" at
   https://www.ubuntu.com/about/release-cycle.


Sample Installation
-------------------

.. code-block:: console

   # apt install nova-compute


Client Installation
-------------------

.. code-block:: console

   # apt install python3-openstackclient
