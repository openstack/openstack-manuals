===========================================
Create an OpenStack Development Environment
===========================================

To create a development environment, you can use DevStack. DevStack is
essentially a collection of shell scripts and configuration files that
builds an OpenStack development environment for you. You use it to
create such an environment for developing a new feature.

You can find all of the documentation at the
`DevStack <http://docs.openstack.org/developer/devstack/>`_ website.

**To run DevStack on an instance in your OpenStack cloud:**

#. Boot an instance from the dashboard or the nova command-line interface
   (CLI) with the following parameters:

   -  Name: devstack

   -  Image: Ubuntu 14.04 LTS

   -  Memory Size: 4 GB RAM

   -  Disk Size: minimum 5 GB

   If you are using the ``nova`` client, specify :option:`--flavor 3` for the
   :command:`nova boot` command to get adequate memory and disk sizes.

#. Log in and set up DevStack. Here's an example of the commands you can
   use to set up DevStack on a virtual machine:

   #. Log in to the instance:

      .. code-block:: console

         $ ssh username@my.instance.ip.address

   #. Update the virtual machine's operating system:

      .. code-block:: console

         # apt-get update

   #. Install git:

      .. code-block:: console

         # apt-get install git

   #. Clone the ``devstack`` repository:

      .. code-block:: console

         $ git clone https://git.openstack.org/openstack-dev/devstack

   #. Change to the ``devstack`` repository:

      .. code-block:: console

         $ cd devstack

#. (Optional) If you've logged in to your instance as the root user, you
   must create a "stack" user; otherwise you'll run into permission issues.
   If you've logged in as a user other than root, you can skip these steps:

   #. Run the DevStack script to create the stack user:

      .. code-block:: console

         # tools/create-stack-user.sh

   #. Give ownership of the ``devstack`` directory to the stack user:

      .. code-block:: console

         # chown -R stack:stack /root/devstack

   #. Set some permissions you can use to view the DevStack screen later:

      .. code-block:: console

         # chmod o+rwx /dev/pts/0

   #. Switch to the stack user:

      .. code-block:: console

         $ su stack

#. Edit the ``local.conf`` configuration file that controls what DevStack
   will deploy. Copy the example ``local.conf`` file at the end of this
   section (:ref:`local.conf`):

   .. code-block:: console

      $ vim local.conf

#. Run the stack script that will install OpenStack:

   .. code-block:: console

      $ ./stack.sh

#. When the stack script is done, you can open the screen session it
   started to view all of the running OpenStack services:

   .. code-block:: console

      $ screen -r stack

#. Press ``Ctrl+A`` followed by 0 to go to the first ``screen`` window.

.. note::

   -  The ``stack.sh`` script takes a while to run. Perhaps you can
      take this opportunity to `join the OpenStack
      Foundation <https://www.openstack.org/join/>`__.

   -  ``Screen`` is a useful program for viewing many related services
      at once. For more information, see the `GNU screen quick
      reference <http://aperiodic.net/screen/quick_reference>`__.

Now that you have an OpenStack development environment, you're free to
hack around without worrying about damaging your production deployment.
:ref:`local.conf` provides a working environment for running
Identity service, Compute service, Block Storage service, Image service,
Dashboard, and Object Storage service as the starting point.

.. _local.conf:

local.conf
~~~~~~~~~~

.. code-block:: bash

   [[local|localrc]]
   FLOATING_RANGE=192.168.1.224/27
   FIXED_RANGE=10.11.12.0/24
   FIXED_NETWORK_SIZE=256
   FLAT_INTERFACE=eth0
   ADMIN_PASSWORD=supersecret
   DATABASE_PASSWORD=iheartdatabases
   RABBIT_PASSWORD=flopsymopsy
   SERVICE_PASSWORD=iheartksl
   SERVICE_TOKEN=xyzpdqlazydog
