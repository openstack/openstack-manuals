.. _launch-instance-selfservice:

Launch an instance on the self-service network
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Determine instance options
--------------------------

To launch an instance, you must at least specify the flavor, image
name, network, security group, key, and instance name.

#. On the controller node, source the ``demo`` credentials to gain access to
   user-only CLI commands:

   .. code-block:: console

      $ . demo-openrc

   .. end

#. A flavor specifies a virtual resource allocation profile which
   includes processor, memory, and storage.

   List available flavors:

   .. code-block:: console

      $ openstack flavor list

      +----+---------+-----+------+-----------+-------+-----------+
      | ID | Name    | RAM | Disk | Ephemeral | VCPUs | Is Public |
      +----+---------+-----+------+-----------+-------+-----------+
      | 0  | m1.nano |  64 |    1 |         0 |     1 | True      |
      +----+---------+-----+------+-----------+-------+-----------+

   .. end

   .. note::

      You can also reference a flavor by ID.

#. List available images:

   .. code-block:: console

      $ openstack image list

      +--------------------------------------+--------+--------+
      | ID                                   | Name   | Status |
      +--------------------------------------+--------+--------+
      | 390eb5f7-8d49-41ec-95b7-68c0d5d54b34 | cirros | active |
      +--------------------------------------+--------+--------+

   .. end

   This instance uses the ``cirros`` image.

#. List available networks:

   .. code-block:: console

      $ openstack network list

      +--------------------------------------+-------------+--------------------------------------+
      | ID                                   | Name        | Subnets                              |
      +--------------------------------------+-------------+--------------------------------------+
      | 4716ddfe-6e60-40e7-b2a8-42e57bf3c31c | selfservice | 2112d5eb-f9d6-45fd-906e-7cabd38b7c7c |
      | b5b6993c-ddf9-40e7-91d0-86806a42edb8 | provider    | 310911f6-acf0-4a47-824e-3032916582ff |
      +--------------------------------------+-------------+--------------------------------------+

   .. end

   This instance uses the ``selfservice`` self-service network. However, you
   must reference this network using the ID instead of the name.

#. List available security groups:

   .. code-block:: console

      $ openstack security group list

      +--------------------------------------+---------+------------------------+
      | ID                                   | Name    | Description            |
      +--------------------------------------+---------+------------------------+
      | dd2b614c-3dad-48ed-958b-b155a3b38515 | default | Default security group |
      +--------------------------------------+---------+------------------------+

   .. end

   This instance uses the ``default`` security group.

#. Launch the instance:

   Replace ``SELFSERVICE_NET_ID`` with the ID of the ``selfservice`` network.

   .. code-block:: console

      $ openstack server create --flavor m1.nano --image cirros \
        --nic net-id=SELFSERVICE_NET_ID --security-group default \
        --key-name mykey selfservice-instance

      +--------------------------------------+---------------------------------------+
      | Field                                | Value                                 |
      +--------------------------------------+---------------------------------------+
      | OS-DCF:diskConfig                    | MANUAL                                |
      | OS-EXT-AZ:availability_zone          |                                       |
      | OS-EXT-STS:power_state               | 0                                     |
      | OS-EXT-STS:task_state                | scheduling                            |
      | OS-EXT-STS:vm_state                  | building                              |
      | OS-SRV-USG:launched_at               | None                                  |
      | OS-SRV-USG:terminated_at             | None                                  |
      | accessIPv4                           |                                       |
      | accessIPv6                           |                                       |
      | addresses                            |                                       |
      | adminPass                            | 7KTBYHSjEz7E                          |
      | config_drive                         |                                       |
      | created                              | 2016-02-26T14:52:37Z                  |
      | flavor                               | m1.nano                               |
      | hostId                               |                                       |
      | id                                   | 113c5892-e58e-4093-88c7-e33f502eaaa4  |
      | image                                | cirros (390eb5f7-8d49-41ec-95b7-68c0d |
      |                                      | 5d54b34)                              |
      | key_name                             | mykey                                 |
      | name                                 | selfservice-instance                  |
      | os-extended-volumes:volumes_attached | []                                    |
      | progress                             | 0                                     |
      | project_id                           | ed0b60bf607743088218b0a533d5943f      |
      | properties                           |                                       |
      | security_groups                      | [{u'name': u'default'}]               |
      | status                               | BUILD                                 |
      | updated                              | 2016-02-26T14:52:38Z                  |
      | user_id                              | 58126687cbcc4888bfa9ab73a2256f27      |
      +--------------------------------------+---------------------------------------+

   .. end

#. Check the status of your instance:

   .. code-block:: console

      $ openstack server list

      +--------------------------------------+----------------------+--------+------------------------+
      | ID                                   | Name                 | Status | Networks               |
      +--------------------------------------+----------------------+--------+------------------------+
      | 113c5892-e58e-4093-88c7-e33f502eaaa4 | selfservice-instance | ACTIVE | selfservice=172.16.1.3 |
      | 181c52ba-aebc-4c32-a97d-2e8e82e4eaaf | provider-instance    | ACTIVE | provider=203.0.113.103 |
      +--------------------------------------+----------------------+--------+------------------------+

   .. end

   The status changes from ``BUILD`` to ``ACTIVE`` when the build process
   successfully completes.

Access the instance using a virtual console
-------------------------------------------

#. Obtain a :term:`Virtual Network Computing (VNC)`
   session URL for your instance and access it from a web browser:

   .. code-block:: console

      $ openstack console url show selfservice-instance

      +-------+---------------------------------------------------------------------------------+
      | Field | Value                                                                           |
      +-------+---------------------------------------------------------------------------------+
      | type  | novnc                                                                           |
      | url   | http://controller:6080/vnc_auto.html?token=5eeccb47-525c-4918-ac2a-3ad1e9f1f493 |
      +-------+---------------------------------------------------------------------------------+

   .. end

   .. note::

      If your web browser runs on a host that cannot resolve the
      ``controller`` host name, you can replace ``controller`` with the
      IP address of the management interface on your controller node.

   The CirrOS image includes conventional user name/password
   authentication and provides these credentials at the login prompt.
   After logging into CirrOS, we recommend that you verify network
   connectivity using ``ping``.

#. Verify access to the self-service network gateway:

   .. code-block:: console

      $ ping -c 4 172.16.1.1

      PING 172.16.1.1 (172.16.1.1) 56(84) bytes of data.
      64 bytes from 172.16.1.1: icmp_req=1 ttl=64 time=0.357 ms
      64 bytes from 172.16.1.1: icmp_req=2 ttl=64 time=0.473 ms
      64 bytes from 172.16.1.1: icmp_req=3 ttl=64 time=0.504 ms
      64 bytes from 172.16.1.1: icmp_req=4 ttl=64 time=0.470 ms

      --- 172.16.1.1 ping statistics ---
      4 packets transmitted, 4 received, 0% packet loss, time 2998ms
      rtt min/avg/max/mdev = 0.357/0.451/0.504/0.055 ms

   .. end

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

   .. end

Access the instance remotely
----------------------------

#. Create a :term:`floating IP address` on the provider virtual network:

   .. code-block:: console

      $ openstack floating ip create provider

      +---------------------+--------------------------------------+
      | Field               | Value                                |
      +---------------------+--------------------------------------+
      | created_at          | 2017-01-20T17:29:16Z                 |
      | description         |                                      |
      | fixed_ip_address    | None                                 |
      | floating_ip_address | 203.0.113.104                        |
      | floating_network_id | b5b6993c-ddf9-40e7-91d0-86806a42edb8 |
      | headers             |                                      |
      | id                  | 88b4d06a-d794-4406-affd-6ffa2bcf1e2a |
      | port_id             | None                                 |
      | project_id          | ed0b60bf607743088218b0a533d5943f     |
      | revision_number     | 1                                    |
      | router_id           | None                                 |
      | status              | DOWN                                 |
      | updated_at          | 2017-01-20T17:29:16Z                 |
      +---------------------+--------------------------------------+

   .. end

#. Associate the floating IP address with the instance:

   .. code-block:: console

      $ openstack server add floating ip selfservice-instance 203.0.113.104

   .. end

   .. note::

      This command provides no output.

#. Check the status of your floating IP address:

   .. code-block:: console

      $ openstack server list

      +--------------------------------------+----------------------+--------+---------------------------------------+
      | ID                                   | Name                 | Status | Networks                              |
      +--------------------------------------+----------------------+--------+---------------------------------------+
      | 113c5892-e58e-4093-88c7-e33f502eaaa4 | selfservice-instance | ACTIVE | selfservice=172.16.1.3, 203.0.113.104 |
      | 181c52ba-aebc-4c32-a97d-2e8e82e4eaaf | provider-instance    | ACTIVE | provider=203.0.113.103                |
      +--------------------------------------+----------------------+--------+---------------------------------------+

   .. end

#. Verify connectivity to the instance via floating IP address from
   the controller node or any host on the provider physical network:

   .. code-block:: console

      $ ping -c 4 203.0.113.104

      PING 203.0.113.104 (203.0.113.104) 56(84) bytes of data.
      64 bytes from 203.0.113.104: icmp_req=1 ttl=63 time=3.18 ms
      64 bytes from 203.0.113.104: icmp_req=2 ttl=63 time=0.981 ms
      64 bytes from 203.0.113.104: icmp_req=3 ttl=63 time=1.06 ms
      64 bytes from 203.0.113.104: icmp_req=4 ttl=63 time=0.929 ms

      --- 203.0.113.104 ping statistics ---
      4 packets transmitted, 4 received, 0% packet loss, time 3002ms
      rtt min/avg/max/mdev = 0.929/1.539/3.183/0.951 ms

   .. end

#. Access your instance using SSH from the controller node or any
   host on the provider physical network:

   .. code-block:: console

      $ ssh cirros@203.0.113.104

      The authenticity of host '203.0.113.104 (203.0.113.104)' can't be established.
      RSA key fingerprint is ed:05:e9:e7:52:a0:ff:83:68:94:c7:d1:f2:f8:e2:e9.
      Are you sure you want to continue connecting (yes/no)? yes
      Warning: Permanently added '203.0.113.104' (RSA) to the list of known hosts.

   .. end

If your instance does not launch or seem to work as you expect, see the
`Troubleshoot Compute documentation for Pike
<https://docs.openstack.org/nova/pike/admin/support-compute.html>`__
for more information or use one of
the :doc:`many other options <common/app-support>`
to seek assistance. We want your first installation to work!

Return to :ref:`Launch an instance <launch-instance-complete>`.
