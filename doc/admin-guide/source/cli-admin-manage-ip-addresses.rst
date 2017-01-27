===================
Manage IP addresses
===================

Each instance has a private, fixed IP address that is assigned when
the instance is launched. In addition, an instance can have a public
or floating IP address. Private IP addresses are used for
communication between instances, and public IP addresses are used
for communication with networks outside the cloud, including the
Internet.

- By default, both administrative and end users can associate floating IP
  addresses with projects and instances. You can change user permissions for
  managing IP addresses by updating the ``/etc/nova/policy.json``
  file. For basic floating-IP procedures, refer to the `Allocate a
  floating address to an instance <https://docs.openstack.org/user-guide/configure-access-and-security-for-instances.html#allocate-a-floating-ip-address-to-an-instance>`_
  section in the OpenStack End User Guide.

- For details on creating public networks using OpenStack Networking
  (``neutron``), refer to :ref:`networking-adv-features`.
  No floating IP addresses are created by default in OpenStack Networking.

As an administrator using legacy networking (``nova-network``), you
can use the following bulk commands to list, create, and delete ranges
of floating IP addresses. These addresses can then be associated with
instances by end users.

List addresses for all projects
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To list all floating IP addresses for all projects, run:

.. code-block:: console

   $ openstack floating ip list
   +------------+---------------+---------------+--------+-----------+
   | project_id | address       | instance_uuid | pool   | interface |
   +------------+---------------+---------------+--------+-----------+
   | None       | 172.24.4.225  | None          | public | eth0      |
   | None       | 172.24.4.226  | None          | public | eth0      |
   | None       | 172.24.4.227  | None          | public | eth0      |
   | None       | 172.24.4.228  | None          | public | eth0      |
   | None       | 172.24.4.229  | None          | public | eth0      |
   | None       | 172.24.4.230  | None          | public | eth0      |
   | None       | 172.24.4.231  | None          | public | eth0      |
   | None       | 172.24.4.232  | None          | public | eth0      |
   | None       | 172.24.4.233  | None          | public | eth0      |
   | None       | 172.24.4.234  | None          | public | eth0      |
   | None       | 172.24.4.235  | None          | public | eth0      |
   | None       | 172.24.4.236  | None          | public | eth0      |
   | None       | 172.24.4.237  | None          | public | eth0      |
   | None       | 172.24.4.238  | None          | public | eth0      |
   | None       | 192.168.253.1 | None          | test   | eth0      |
   | None       | 192.168.253.2 | None          | test   | eth0      |
   | None       | 192.168.253.3 | None          | test   | eth0      |
   | None       | 192.168.253.4 | None          | test   | eth0      |
   | None       | 192.168.253.5 | None          | test   | eth0      |
   | None       | 192.168.253.6 | None          | test   | eth0      |
   +------------+---------------+---------------+--------+-----------+

Bulk create floating IP addresses
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To create a range of floating IP addresses, run:

.. code-block:: console

   $ nova floating-ip-bulk-create [--pool POOL_NAME] [--interface INTERFACE] RANGE_TO_CREATE

For example:

.. code-block:: console

   $ nova floating-ip-bulk-create --pool test 192.168.1.56/29

By default, ``floating-ip-bulk-create`` uses the
``public`` pool and ``eth0`` interface values.

.. note::

   You should use a range of free IP addresses that is valid for your
   network. If you are not sure, at least try to avoid the DHCP address
   range:

   - Pick a small range (/29 gives an 8 address range, 6 of
     which will be usable).

   - Use :command:`nmap` to check a range's availability. For example,
     192.168.1.56/29 represents a small range of addresses
     (192.168.1.56-63, with 57-62 usable), and you could run the
     command :command:`nmap -sn 192.168.1.56/29` to check whether the entire
     range is currently unused.

Bulk delete floating IP addresses
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To delete a range of floating IP addresses, run:

.. code-block:: console

   $ openstack floating ip delete RANGE_TO_DELETE

For example:

.. code-block:: console

   $ openstack floating ip delete 192.168.1.56/29
