.. _launch-instance-public:

Launch an instance on the public network
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Determine instance options
--------------------------

To launch an instance, you must at least specify the flavor, image
name, network, security group, key, and instance name.

#. On the controller node, source the ``demo`` credentials to gain access to
   user-only CLI commands:

   .. code-block:: console

      $ source demo-openrc.sh

#. A flavor specifies a virtual resource allocation profile which
   includes processor, memory, and storage.

   List available flavors:

   .. code-block:: console

      $ nova flavor-list
      +-----+-----------+-----------+------+-----------+------+-------+-------------+-----------+
      | ID  | Name      | Memory_MB | Disk | Ephemeral | Swap | VCPUs | RXTX_Factor | Is_Public |
      +-----+-----------+-----------+------+-----------+------+-------+-------------+-----------+
      | 1   | m1.tiny   | 512       | 1    | 0         |      | 1     | 1.0         | True      |
      | 2   | m1.small  | 2048      | 20   | 0         |      | 1     | 1.0         | True      |
      | 3   | m1.medium | 4096      | 40   | 0         |      | 2     | 1.0         | True      |
      | 4   | m1.large  | 8192      | 80   | 0         |      | 4     | 1.0         | True      |
      | 5   | m1.xlarge | 16384     | 160  | 0         |      | 8     | 1.0         | True      |
      +-----+-----------+-----------+------+-----------+------+-------+-------------+-----------+

   This instance uses the ``m1.tiny`` flavor.

   .. note::

      You can also reference a flavor by ID.

#. List available images:

   .. code-block:: console

      $ nova image-list
      +--------------------------------------+--------+--------+--------+
      | ID                                   | Name   | Status | Server |
      +--------------------------------------+--------+--------+--------+
      | 38047887-61a7-41ea-9b49-27987d5e8bb9 | cirros | ACTIVE |        |
      +--------------------------------------+--------+--------+--------+

   This instance uses the ``cirros`` image.

#. List available networks:

   .. code-block:: console

      $ neutron net-list
      +--------------------------------------+---------+-----------------------------------------------------+
      | id                                   | name    | subnets                                             |
      +--------------------------------------+---------+-----------------------------------------------------+
      | 7e25a106-e978-4adb-a4ef-d46c6170254a | public  | 0e62efcd-8cee-46c7-b163-d8df05c3c5ad 203.0.113.0/24 |
      +--------------------------------------+---------+-----------------------------------------------------+

   This instance uses the ``public`` provider network. However, you must
   reference this network using the ID instead of the name.

   .. note::

      If you chose option 2, the output should also contain the private network.

#. List available security groups:

   .. code-block:: console

      $ nova secgroup-list
      +--------------------------------------+---------+-------------+
      | Id                                   | Name    | Description |
      +--------------------------------------+---------+-------------+
      | ad8d4ea5-3cad-4f7d-b164-ada67ec59473 | default | default     |
      +--------------------------------------+---------+-------------+

   This instance uses the ``default`` security group.

Launch the instance
-------------------

#. Launch the instance:

   Replace ``PUBLIC_NET_ID`` with the ID of the ``public`` provider network.

   .. note::

      If you chose option 1 and your environment contains only one network,
      you can omit the ``--nic`` option because OpenStack automatically
      chooses the only network available.

   .. code-block:: console

      $ nova boot --flavor m1.tiny --image cirros --nic net-id=PUBLIC_NET_ID \
        --security-group default --key-name mykey public-instance
      +--------------------------------------+-----------------------------------------------+
      | Property                             | Value                                         |
      +--------------------------------------+-----------------------------------------------+
      | OS-DCF:diskConfig                    | MANUAL                                        |
      | OS-EXT-AZ:availability_zone          | nova                                          |
      | OS-EXT-STS:power_state               | 0                                             |
      | OS-EXT-STS:task_state                | scheduling                                    |
      | OS-EXT-STS:vm_state                  | building                                      |
      | OS-SRV-USG:launched_at               | -                                             |
      | OS-SRV-USG:terminated_at             | -                                             |
      | accessIPv4                           |                                               |
      | accessIPv6                           |                                               |
      | adminPass                            | hdF4LMQqC5PB                                  |
      | config_drive                         |                                               |
      | created                              | 2015-09-17T21:58:18Z                          |
      | flavor                               | m1.tiny (1)                                   |
      | hostId                               |                                               |
      | id                                   | 181c52ba-aebc-4c32-a97d-2e8e82e4eaaf          |
      | image                                | cirros (38047887-61a7-41ea-9b49-27987d5e8bb9) |
      | key_name                             | mykey                                         |
      | metadata                             | {}                                            |
      | name                                 | public-instance                               |
      | os-extended-volumes:volumes_attached | []                                            |
      | progress                             | 0                                             |
      | security_groups                      | default                                       |
      | status                               | BUILD                                         |
      | tenant_id                            | f5b2ccaa75ac413591f12fcaa096aa5c              |
      | updated                              | 2015-09-17T21:58:18Z                          |
      | user_id                              | 684286a9079845359882afc3aa5011fb              |
      +--------------------------------------+-----------------------------------------------+

#. Check the status of your instance:

   .. code-block:: console

      $ nova list
      +--------------------------------------+-----------------+--------+------------+-------------+----------------------+
      | ID                                   | Name            | Status | Task State | Power State | Networks             |
      +--------------------------------------+-----------------+--------+------------+-------------+----------------------+
      | 181c52ba-aebc-4c32-a97d-2e8e82e4eaaf | public-instance | ACTIVE | -          | Running     | public=203.0.113.103 |
      +--------------------------------------+-----------------+--------+------------+-------------+----------------------+

   The status changes from ``BUILD`` to ``ACTIVE`` when the build process
   successfully completes.

Access the instance using the virtual console
---------------------------------------------

#. Obtain a :term:`Virtual Network Computing (VNC)`
   session URL for your instance and access it from a web browser:

   .. code-block:: console

      $ nova get-vnc-console public-instance novnc
      +-------+------------------------------------------------------------------------------------+
      | Type  | Url                                                                                |
      +-------+------------------------------------------------------------------------------------+
      | novnc | http://controller:6080/vnc_auto.html?token=2f6dd985-f906-4bfc-b566-e87ce656375b    |
      +-------+------------------------------------------------------------------------------------+

   .. note::

      If your web browser runs on a host that cannot resolve the
      ``controller`` host name, you can replace ``controller`` with the
      IP address of the management interface on your controller node.

   The CirrOS image includes conventional user name/password
   authentication and provides these credentials at the login prompt.
   After logging into CirrOS, we recommend that you verify network
   connectivity using ``ping``.

#. Verify access to the public provider network gateway:

   .. code-block:: console

      $ ping -c 4 203.0.113.1
      PING 203.0.113.1 (203.0.113.1) 56(84) bytes of data.
      64 bytes from 203.0.113.1: icmp_req=1 ttl=64 time=0.357 ms
      64 bytes from 203.0.113.1: icmp_req=2 ttl=64 time=0.473 ms
      64 bytes from 203.0.113.1: icmp_req=3 ttl=64 time=0.504 ms
      64 bytes from 203.0.113.1: icmp_req=4 ttl=64 time=0.470 ms

      --- 203.0.113.1 ping statistics ---
      4 packets transmitted, 4 received, 0% packet loss, time 2998ms
      rtt min/avg/max/mdev = 0.357/0.451/0.504/0.055 ms

#. Verify access to the internet:

   .. code-block:: console

      $ ping -c 4 openstack.org
      PING openstack.org (174.143.194.225) 56(84) bytes of data.
      64 bytes from 174.143.194.225: icmp_req=1 ttl=53 time=17.4 ms
      64 bytes from 174.143.194.225: icmp_req=2 ttl=53 time=17.5 ms
      64 bytes from 174.143.194.225: icmp_req=3 ttl=53 time=17.7 ms
      64 bytes from 174.143.194.225: icmp_req=4 ttl=53 time=17.5 ms

      --- openstack.org ping statistics ---
      4 packets transmitted, 4 received, 0% packet loss, time 3003ms
      rtt min/avg/max/mdev = 17.431/17.575/17.734/0.143 ms

Access the instance remotely
----------------------------

#. Verify connectivity to the instance from the controller node or any host
   on the public physical network:

   .. code-block:: console

      $ ping -c 4 203.0.113.103
      PING 203.0.113.103 (203.0.113.103) 56(84) bytes of data.
      64 bytes from 203.0.113.103: icmp_req=1 ttl=63 time=3.18 ms
      64 bytes from 203.0.113.103: icmp_req=2 ttl=63 time=0.981 ms
      64 bytes from 203.0.113.103: icmp_req=3 ttl=63 time=1.06 ms
      64 bytes from 203.0.113.103: icmp_req=4 ttl=63 time=0.929 ms

      --- 203.0.113.103 ping statistics ---
      4 packets transmitted, 4 received, 0% packet loss, time 3002ms
      rtt min/avg/max/mdev = 0.929/1.539/3.183/0.951 ms

#. Access your instance using SSH from the controller node or any
   host on the public physical network:

   .. code-block:: console

      $ ssh cirros@203.0.113.103
      The authenticity of host '203.0.113.102 (203.0.113.102)' can't be established.
      RSA key fingerprint is ed:05:e9:e7:52:a0:ff:83:68:94:c7:d1:f2:f8:e2:e9.
      Are you sure you want to continue connecting (yes/no)? yes
      Warning: Permanently added '203.0.113.102' (RSA) to the list of known hosts.
      $

   .. note::

      If your host does not contain the public/private key pair created
      in an earlier step, SSH prompts for the default password associated
      with the ``cirros`` user, ``cubswin:)``.

If your instance does not launch or seem to work as you expect, see the
`OpenStack Operations Guide <http://docs.openstack.org/ops>`__ for more
information or use one of the :doc:`many other options <common/app_support>`
to seek assistance. We want your first installation to work!

Return to :ref:`Launch an instance <launch-instance-complete>`.
