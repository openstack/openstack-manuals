==============
Use Networking
==============

You can manage OpenStack Networking services by using the service
command. For example:

.. code-block:: console

   # service neutron-server stop
   # service neutron-server status
   # service neutron-server start
   # service neutron-server restart

Log files are in the ``/var/log/neutron`` directory.

Configuration files are in the ``/etc/neutron`` directory.

Administrators and tenants can use OpenStack Networking to build
rich network topologies. Administrators can create network
connectivity on behalf of tenants.

Core Networking API features
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

After you install and configure Networking, tenants and administrators
can perform create-read-update-delete (CRUD) API networking operations
by using the Networking API directly or neutron command-line interface
(CLI). The neutron CLI is a wrapper around the Networking API. Every
Networking API call has a corresponding neutron command.

The CLI includes a number of options. For details, see the `Create and manage
networks <http://docs.openstack.org/user-guide/cli-create-and-manage-networks.html>`__.

Basic Networking operations
---------------------------

To learn about advanced capabilities available through the neutron
command-line interface (CLI), read the networking section in the
`OpenStack End User
Guide <http://docs.openstack.org/user-guide/index.html>`__.

This table shows example neutron commands that enable you to complete
basic network operations:

+-------------------------+-------------------------------------------------+
| Operation               | Command                                         |
+=========================+=================================================+
|Creates a network.       |                                                 |
|                         |                                                 |
|                         |     ``$ neutron net-create net1``               |
+-------------------------+-------------------------------------------------+
|Creates a subnet that is |                                                 |
|associated with net1.    |                                                 |
|                         |                                                 |
|                         |     ``$ neutron subnet-create``                 |
|                         |     ``net1 10.0.0.0/24``                        |
+-------------------------+-------------------------------------------------+
|Lists ports for a        |                                                 |
|specified tenant.        |                                                 |
|                         |                                                 |
|                         |     ``$ neutron port-list``                     |
+-------------------------+-------------------------------------------------+
|Lists ports for a        |                                                 |
|specified tenant         |                                                 |
|and displays the ``id``, |                                                 |
|``fixed_ips``,           |                                                 |
|and ``device_owner``     |                                                 |
|columns.                 |                                                 |
|                         |                                                 |
|                         |     ``$ neutron port-list -c id``               |
|                         |     ``-c fixed_ips -c device_owner``            |
+-------------------------+-------------------------------------------------+
|Shows information for a  |                                                 |
|specified port.          |                                                 |
|                         |     ``$ neutron port-show PORT_ID``             |
+-------------------------+-------------------------------------------------+

**Basic Networking operations**

.. note::

   The ``device_owner`` field describes who owns the port. A port whose
   ``device_owner`` begins with:

   -  ``network`` is created by Networking.

   -  ``compute`` is created by Compute.

Administrative operations
-------------------------

The administrator can run any :command:`neutron` command on behalf of
tenants by specifying an Identity ``tenant_id`` in the command, as
follows:

.. code-block:: console

   $ neutron net-create --tenant-id TENANT_ID NETWORK_NAME

For example:

.. code-block:: console

   $ neutron net-create --tenant-id 5e4bbe24b67a4410bc4d9fae29ec394e net1

.. note::

   To view all tenant IDs in Identity, run the following command as an
   Identity service admin user:

   .. code-block:: console

      $ openstack project list

Advanced Networking operations
------------------------------

This table shows example Networking commands that enable you to complete
advanced network operations:

+-------------------------------+--------------------------------------------+
| Operation                     | Command                                    |
+===============================+============================================+
|Creates a network that         |                                            |
|all tenants can use.           |                                            |
|                               |                                            |
|                               |     ``$ neutron net-create``               |
|                               |     ``--shared public-net``                |
+-------------------------------+--------------------------------------------+
|Creates a subnet with a        |                                            |
|specified gateway IP address.  |                                            |
|                               |                                            |
|                               |   ``$ neutron subnet-create``              |
|                               |   ``--gateway 10.0.0.254 net1 10.0.0.0/24``|
+-------------------------------+--------------------------------------------+
|Creates a subnet that has      |                                            |
|no gateway IP address.         |                                            |
|                               |                                            |
|                               |     ``$ neutron subnet-create``            |
|                               |     ``--no-gateway net1 10.0.0.0/24``      |
+-------------------------------+--------------------------------------------+
|Creates a subnet with DHCP     |                                            |
|disabled.                      |                                            |
|                               |                                            |
|                               |   ``$ neutron subnet-create``              |
|                               |   ``net1 10.0.0.0/24 --enable-dhcp=False`` |
+-------------------------------+--------------------------------------------+
|Specifies a set of host routes |                                            |
|                               |                                            |
|                               |     ``$ neutron subnet-create``            |
|                               |     ``test-net1 40.0.0.0/24 --host-routes``|
|                               |     ``type=dict list=true``                |
|                               |     ``destination=40.0.1.0/24,``           |
|                               |     ``nexthop=40.0.0.2``                   |
+-------------------------------+--------------------------------------------+
|Creates a subnet with a        |                                            |
|specified set of dns name      |                                            |
|servers.                       |                                            |
|                               |                                            |
|                               |     ``$ neutron subnet-create test-net1``  |
|                               |     ``40.0.0.0/24 --dns-nameservers``      |
|                               |     ``list=true 8.8.4.4 8.8.8.8``          |
+-------------------------------+--------------------------------------------+
|Displays all ports and         |                                            |
|IPs allocated on a network.    |                                            |
|                               |                                            |
|                               | ``$ neutron port-list --network_id NET_ID``|
+-------------------------------+--------------------------------------------+

**Advanced Networking operations**

Use Compute with Networking
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Basic Compute and Networking operations
---------------------------------------

This table shows example neutron and nova commands that enable you to
complete basic VM networking operations:

+----------------------------------+-----------------------------------------+
| Action                           | Command                                 |
+==================================+=========================================+
|Checks available networks.        |                                         |
|                                  |                                         |
|                                  |    ``$ neutron net-list``               |
+----------------------------------+-----------------------------------------+
|Boots a VM with a single NIC on   |                                         |
|a selected Networking network.    |                                         |
|                                  |                                         |
|                                  |  ``$ nova boot --image IMAGE --flavor`` |
|                                  |  ``FLAVOR --nic net-id=NET_ID VM_NAME`` |
+----------------------------------+-----------------------------------------+
|Searches for ports with a         |                                         |
|``device_id`` that matches the    |                                         |
|Compute instance UUID. See :ref:  |                                         |
|`Create and delete VMs`           |                                         |
|                                  |                                         |
|                                  |``$ neutron port-list --device_id VM_ID``|
+----------------------------------+-----------------------------------------+
|Searches for ports, but shows     |                                         |
|only the ``mac_address`` of       |                                         |
|the port.                         |                                         |
|                                  |                                         |
|                                  |    ``$ neutron port-list --field``      |
|                                  |    ``mac_address --device_id VM_ID``    |
+----------------------------------+-----------------------------------------+
|Temporarily disables a port from  |                                         |
|sending traffic.                  |                                         |
|                                  |                                         |
|                                  |  ``$ neutron port-update PORT_ID``      |
|                                  |  ``--admin_state_up False``             |
+----------------------------------+-----------------------------------------+

**Basic Compute and Networking operations**

.. note::

   The ``device_id`` can also be a logical router ID.

.. note::

   -  When you boot a Compute VM, a port on the network that
      corresponds to the VM NIC is automatically created and associated
      with the default security group. You can configure `security
      group rules <#enabling_ping_and_ssh>`__ to enable users to access
      the VM.

.. _Create and delete VMs:
    -  When you delete a Compute VM, the underlying Networking port is
       automatically deleted.

Advanced VM creation operations
-------------------------------

This table shows example nova and neutron commands that enable you to
complete advanced VM creation operations:

+-------------------------------------+--------------------------------------+
| Operation                           | Command                              |
+=====================================+======================================+
|Boots a VM with multiple             |                                      |
|NICs.                                |                                      |
|                                     |                                      |
|                                     |``$ nova boot --image IMAGE --flavor``|
|                                     |``FLAVOR --nic net-id=NET1-ID --nic`` |
|                                     |``net-id=NET2-ID VM_NAME``            |
+-------------------------------------+--------------------------------------+
|Boots a VM with a specific IP        |                                      |
|address. Note that you cannot        |                                      |
|use the ``--num-instances``          |                                      |
|parameter in this case.              |                                      |
|                                     |                                      |
|                                     |``$ nova boot --image IMAGE --flavor``|
|                                     |``FLAVOR --nic net-id=NET-ID,``       |
|                                     |``v4-fixed-ip=IP-ADDR VM_NAME``       |
+-------------------------------------+--------------------------------------+
|Boots a VM that connects to all      |                                      |
|networks that are accessible to the  |                                      |
|tenant who submits the request       |                                      |
|(without the ``--nic`` option).      |                                      |
|                                     |                                      |
|                                     |``$ nova boot --image IMAGE --flavor``|
|                                     |``FLAVOR VM_NAME``                    |
+-------------------------------------+--------------------------------------+

**Advanced VM creation operations**

.. note::

   Cloud images that distribution vendors offer usually have only one
   active NIC configured. When you boot with multiple NICs, you must
   configure additional interfaces on the image or the NICs are not
   reachable.

   The following Debian/Ubuntu-based example shows how to set up the
   interfaces within the instance in the ``/etc/network/interfaces``
   file. You must apply this configuration to the image.

   .. code-block:: bash

      # The loopback network interface
      auto lo
      iface lo inet loopback

      auto eth0
      iface eth0 inet dhcp

      auto eth1
      iface eth1 inet dhcp

Enable ping and SSH on VMs (security groups)
--------------------------------------------

You must configure security group rules depending on the type of plug-in
you are using. If you are using a plug-in that:

-  Implements Networking security groups, you can configure security
   group rules directly by using the :command:`neutron security-group-rule-create`
   command. This example enables ``ping`` and ``ssh`` access to your VMs.

   .. code-block:: console

      $ neutron security-group-rule-create --protocol icmp \
          --direction ingress default

   .. code-block:: console

      $ neutron security-group-rule-create --protocol tcp --port-range-min 22 \
          --port-range-max 22 --direction ingress default

-  Does not implement Networking security groups, you can configure
   security group rules by using the :command:`nova secgroup-add-rule` or
   :command:`euca-authorize` command. These :command:`nova` commands enable
   ``ping`` and ``ssh`` access to your VMs.

   .. code-block:: console

      $ nova secgroup-add-rule default icmp -1 -1 0.0.0.0/0
      $ nova secgroup-add-rule default tcp 22 22 0.0.0.0/0

.. note::

    If your plug-in implements Networking security groups, you can also
    leverage Compute security groups by setting
    ``security_group_api = neutron`` in the ``nova.conf`` file. After
    you set this option, all Compute security group commands are proxied
    to Networking.
