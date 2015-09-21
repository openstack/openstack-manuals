======================================================
Launch an instance with OpenStack Networking (neutron)
======================================================

To generate a key pair
~~~~~~~~~~~~~~~~~~~~~~

Most cloud images support :term:`public key authentication`
rather than conventional user name/password authentication.
Before launching an instance, you must
generate a public/private key pair.

1. Source the ``demo`` tenant credentials:

   .. code-block:: console

      $ source demo-openrc.sh

2. Generate and add a key pair:

   .. code-block:: console

      $ nova keypair-add demo-key

3. Verify addition of the key pair:

   .. code-block:: console

      $ nova keypair-list
      +----------+-------------------------------------------------+
      | Name     | Fingerprint                                     |
      +----------+-------------------------------------------------+
      | demo-key | 6c:74:ec:3a:08:05:4e:9e:21:22:a6:dd:b2:62:b8:28 |
      +----------+-------------------------------------------------+

To launch an instance
~~~~~~~~~~~~~~~~~~~~~
To launch an instance, you must at least specify the flavor, image
name, network, security group, key, and instance name.

1. A flavor specifies a virtual resource allocation profile which
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

   Your first instance uses the ``m1.tiny`` flavor.

   .. note::

      You can also reference a flavor by ID.

2. List available images:

   .. code-block:: console

      $ nova image-list
      +--------------------------------------+---------------------+--------+--------+
      | ID                                   | Name                | Status | Server |
      +--------------------------------------+---------------------+--------+--------+
      | acafc7c0-40aa-4026-9673-b879898e1fc2 | cirros-0.3.4-x86_64 | ACTIVE |        |
      +--------------------------------------+---------------------+--------+--------+

   Your first instance uses the ``cirros-0.3.4-x86_64`` image.

3. List available networks:

   .. code-block:: console

      $ neutron net-list
      +------------------------+----------+-----------------------------------------+
      | id                     | name     | subnets                                 |
      +------------------------+----------+-----------------------------------------+
      | 3c612b5a-d1db-498a-... | demo-net | 20bcd3fd-5785-41fe-... 192.168.1.0/24   |
      | 9bce64a3-a963-4c05-... | ext-net  | b54a8d85-b434-4e85-... 203.0.113.0/24   |
      +------------------------+----------+-----------------------------------------+

   Your first instance uses the ``demo-net`` tenant network. However,
   you must reference this network using the ID instead of the name.

4. List available security groups:

   .. code-block:: console

      $ nova secgroup-list
      +--------------------------------------+---------+-------------+
      | Id                                   | Name    | Description |
      +--------------------------------------+---------+-------------+
      | ad8d4ea5-3cad-4f7d-b164-ada67ec59473 | default | default     |
      +--------------------------------------+---------+-------------+

   Your first instance uses the ``default`` security
   group. By default, this security group implements a firewall that
   blocks remote access to instances. If you would like to permit
   remote access to your instance, launch it and then
   :ref:`configure remote access <launch-instance-neutron-remoteaccess>`.

5. Launch the instance:

   Replace ``DEMO_NET_ID`` with the ID of the ``demo-net`` tenant network.

   .. code-block:: console

      $ nova boot --flavor m1.tiny --image cirros-0.3.4-x86_64 --nic net-id=DEMO_NET_ID \
        --security-group default --key-name demo-key demo-instance1
      +--------------------------------------+------------------------------------+
      | Property                             | Value                              |
      +--------------------------------------+------------------------------------+
      | OS-DCF:diskConfig                    | MANUAL                             |
      | OS-EXT-AZ:availability_zone          | nova                               |
      | OS-EXT-STS:power_state               | 0                                  |
      | OS-EXT-STS:task_state                | scheduling                         |
      | OS-EXT-STS:vm_state                  | building                           |
      | OS-SRV-USG:launched_at               | -                                  |
      | OS-SRV-USG:terminated_at             | -                                  |
      | accessIPv4                           |                                    |
      | accessIPv6                           |                                    |
      | adminPass                            | vFW7Bp8PQGNo                       |
      | config_drive                         |                                    |
      | created                              | 2014-04-09T19:24:27Z               |
      | flavor                               | m1.tiny (1)                        |
      | hostId                               |                                    |
      | id                                   | 05682b91-81a1-464c-8f40-8b3da7e... |
      | image                                | cirros-0.3.4-x86_64 (acafc7c0-...) |
      | key_name                             | demo-key                           |
      | metadata                             | {}                                 |
      | name                                 | demo-instance1                     |
      | os-extended-volumes:volumes_attached | []                                 |
      | progress                             | 0                                  |
      | security_groups                      | default                            |
      | status                               | BUILD                              |
      | tenant_id                            | 7cf50047f8df4824bc76c2fdf66d11ec   |
      | updated                              | 2014-04-09T19:24:27Z               |
      | user_id                              | 0e47686e72114d7182f7569d70c519c9   |
      +--------------------------------------+------------------------------------+

6. Check the status of your instance:

   .. code-block:: console

      $ nova list
      +--------------+----------------+--------+------------+-------------+-------------------------+
      | ID           | Name           | Status | Task State | Power State | Networks                |
      +--------------+----------------+--------+------------+-------------+-------------------------+
      | 05682b91-... | demo-instance1 | ACTIVE | -          | Running     | demo-net=192.168.1.3    |
      +--------------+----------------+--------+------------+-------------+-------------------------+

   The status changes from ``BUILD`` to ``ACTIVE``
   when your instance finishes the build process.

To access your instance using a virtual console
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Obtain a :term:`Virtual Network Computing (VNC)`
   session URL for your instance and access it from a web browser:

   .. code-block:: console

      $ nova get-vnc-console demo-instance1 novnc
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

   Verify the ``demo-net`` tenant network gateway:

   .. code-block:: console

      $ ping -c 4 192.168.1.1
      PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
      64 bytes from 192.168.1.1: icmp_req=1 ttl=64 time=0.357 ms
      64 bytes from 192.168.1.1: icmp_req=2 ttl=64 time=0.473 ms
      64 bytes from 192.168.1.1: icmp_req=3 ttl=64 time=0.504 ms
      64 bytes from 192.168.1.1: icmp_req=4 ttl=64 time=0.470 ms

      --- 192.168.1.1 ping statistics ---
      4 packets transmitted, 4 received, 0% packet loss, time 2998ms
      rtt min/avg/max/mdev = 0.357/0.451/0.504/0.055 ms

   Verify the ``ext-net`` external network:

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


.. _launch-instance-neutron-remoteaccess:

To access your instance remotely
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Add rules to the ``default`` security group:

   a. Permit :term:`ICMP` (ping):

      .. code-block:: console

         $ nova secgroup-add-rule default icmp -1 -1 0.0.0.0/0
         +-------------+-----------+---------+-----------+--------------+
         | IP Protocol | From Port | To Port | IP Range  | Source Group |
         +-------------+-----------+---------+-----------+--------------+
         | icmp        | -1        | -1      | 0.0.0.0/0 |              |
         +-------------+-----------+---------+-----------+--------------+

   b. Permit secure shell (SSH) access:

      .. code-block:: console

         $ nova secgroup-add-rule default tcp 22 22 0.0.0.0/0
         +-------------+-----------+---------+-----------+--------------+
         | IP Protocol | From Port | To Port | IP Range  | Source Group |
         +-------------+-----------+---------+-----------+--------------+
         | tcp         | 22        | 22      | 0.0.0.0/0 |              |
         +-------------+-----------+---------+-----------+--------------+

2. Create a :term:`floating IP address` on the ``ext-net`` external network:

   .. code-block:: console

      $ neutron floatingip-create ext-net
      Created a new floatingip:
      +---------------------+--------------------------------------+
      | Field               | Value                                |
      +---------------------+--------------------------------------+
      | fixed_ip_address    |                                      |
      | floating_ip_address | 203.0.113.102                        |
      | floating_network_id | 9bce64a3-a963-4c05-bfcd-161f708042d1 |
      | id                  | 05e36754-e7f3-46bb-9eaa-3521623b3722 |
      | port_id             |                                      |
      | router_id           |                                      |
      | status              | DOWN                                 |
      | tenant_id           | 7cf50047f8df4824bc76c2fdf66d11ec     |
      +---------------------+--------------------------------------+

3. Associate the floating IP address with your instance:

   .. code-block:: console

      $ nova floating-ip-associate demo-instance1 203.0.113.102

   .. note::

      This command provides no output.

4. Check the status of your floating IP address:

   .. code-block:: console

      $ nova list
      +--------------+----------------+--------+------------+-------------+-----------------------------------------+
      | ID           | Name           | Status | Task State | Power State | Networks                                |
      +--------------+----------------+--------+------------+-------------+-----------------------------------------+
      | 05682b91-... | demo-instance1 | ACTIVE | -          | Running     | demo-net=192.168.1.3, 203.0.113.102     |
      +--------------+----------------+--------+------------+-------------+-----------------------------------------+

5. Verify network connectivity using :command:`ping` from the
   controller node or any host on the external network:

   .. code-block:: console

      $ ping -c 4 203.0.113.102
      PING 203.0.113.102 (203.0.113.112) 56(84) bytes of data.
      64 bytes from 203.0.113.102: icmp_req=1 ttl=63 time=3.18 ms
      64 bytes from 203.0.113.102: icmp_req=2 ttl=63 time=0.981 ms
      64 bytes from 203.0.113.102: icmp_req=3 ttl=63 time=1.06 ms
      64 bytes from 203.0.113.102: icmp_req=4 ttl=63 time=0.929 ms

      --- 203.0.113.102 ping statistics ---
      4 packets transmitted, 4 received, 0% packet loss, time 3002ms
      rtt min/avg/max/mdev = 0.929/1.539/3.183/0.951 ms

6. Access your instance using SSH from the controller node or any
   host on the external network:

   .. code-block:: console

      $ ssh cirros@203.0.113.102
      The authenticity of host '203.0.113.102 (203.0.113.102)' can't be established.
      RSA key fingerprint is ed:05:e9:e7:52:a0:ff:83:68:94:c7:d1:f2:f8:e2:e9.
      Are you sure you want to continue connecting (yes/no)? yes
      Warning: Permanently added '203.0.113.102' (RSA) to the list of known hosts.
      $

   .. note::

      If your host does not contain the public/private key pair created
      in an earlier step, originally SSH prompts for the password associated
      with the ``cirros`` user that is ``cubswin:)``.

To attach a Block Storage volume to your instance
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If your environment includes the Block Storage service, you can
attach a volume to the instance.

1. Source the ``demo`` credentials:

   .. code-block:: console

      $ source demo-openrc.sh

2. List volumes:

   .. code-block:: console

      $ nova volume-list
      +--------------+-----------+--------------+------+-------------+-------------+
      | ID           | Status    | Display Name | Size | Volume Type | Attached to |
      +--------------+-----------+--------------+------+-------------+-------------+
      | 158bea89-... | available |              | 1    | -           |             |
      +--------------+-----------+--------------+------+-------------+-------------+

3. Attach the ``demo-volume1`` volume to the ``demo-instance1`` instance:

   .. code-block:: console

      $ nova volume-attach demo-instance1 158bea89-07db-4ac2-8115-66c0d6a4bb48
      +----------+--------------------------------------+
      | Property | Value                                |
      +----------+--------------------------------------+
      | device   | /dev/vdb                             |
      | id       | 158bea89-07db-4ac2-8115-66c0d6a4bb48 |
      | serverId | 05682b91-81a1-464c-8f40-8b3da7ee92c5 |
      | volumeId | 158bea89-07db-4ac2-8115-66c0d6a4bb48 |
      +----------+--------------------------------------+

   .. note::

      You must reference volumes using the IDs instead of names.

4. List volumes:

   .. code-block:: console

      $ nova volume-list
      +--------------+-----------+--------------+------+-------------+--------------+
      | ID           | Status    | Display Name | Size | Volume Type | Attached to  |
      +--------------+-----------+--------------+------+-------------+--------------+
      | 158bea89-... | in-use    |              | 1    | -           | 05682b91-... |
      +--------------+-----------+--------------+------+-------------+--------------+

   The ID of the ``demo-volume1`` volume should indicate ``in-use``
   status by the ID of the ``demo-instance1`` instance.

5. Access your instance using SSH from the controller node or any
   host on the external network and use the :command:`fdisk`
   command to verify presence of the volume as the
   ``/dev/vdb`` block storage device:

   .. code-block:: console

      $ ssh cirros@203.0.113.102
      $ sudo fdisk -l

      Disk /dev/vda: 1073 MB, 1073741824 bytes
      255 heads, 63 sectors/track, 130 cylinders, total 2097152 sectors
      Units = sectors of 1 * 512 = 512 bytes
      Sector size (logical/physical): 512 bytes / 512 bytes
      I/O size (minimum/optimal): 512 bytes / 512 bytes
      Disk identifier: 0x00000000

         Device Boot      Start         End      Blocks   Id  System
      /dev/vda1   *       16065     2088449     1036192+  83  Linux

      Disk /dev/vdb: 1073 MB, 1073741824 bytes
      16 heads, 63 sectors/track, 2080 cylinders, total 2097152 sectors
      Units = sectors of 1 * 512 = 512 bytes
      Sector size (logical/physical): 512 bytes / 512 bytes
      I/O size (minimum/optimal): 512 bytes / 512 bytes
      Disk identifier: 0x00000000

      Disk /dev/vdb doesn't contain a valid partition table

   .. note::

      You must create a partition table and file system to use the volume.

If your instance does not launch or seem to work as you expect, see the
`OpenStack Operations Guide <http://docs.openstack.org/ops>`__ for more
information or use one of the :doc:`many other options <common/app_support>`
to seek assistance. We want your environment to work!
