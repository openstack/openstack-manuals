================
Launch instances
================

Instances are virtual machines that run inside the cloud.

Before you can launch an instance, gather the following parameters:

- The **instance source** can be an image, snapshot, or block storage
  volume that contains an image or snapshot.

- A **name** for your instance.

- The **flavor** for your instance, which defines the compute, memory,
  and storage capacity of nova computing instances. A flavor is an
  available hardware configuration for a server. It defines the size of
  a virtual server that can be launched.

- Any **user data** files. A user data file is a special key in the
  metadata service that holds a file that cloud-aware applications in
  the guest instance can access. For example, one application that uses
  user data is the
  `cloud-init <https://help.ubuntu.com/community/CloudInit>`__ system,
  which is an open-source package from Ubuntu that is available on
  various Linux distributions and that handles early initialization of
  a cloud instance.

- Access and security credentials, which include one or both of the
  following credentials:

- A **key pair** for your instance, which are SSH credentials that
  are injected into images when they are launched. For the key pair
  to be successfully injected, the image must contain the
  ``cloud-init`` package. Create at least one key pair for each
  project. If you already have generated a key pair with an external
  tool, you can import it into OpenStack. You can use the key pair
  for multiple instances that belong to that project.

- A **security group** that defines which incoming network traffic
  is forwarded to instances. Security groups hold a set of firewall
  policies, known as *security group rules*.

- If needed, you can assign a **floating (public) IP address** to a
  running instance.

- You can also attach a block storage device, or **volume**, for
  persistent storage.

.. note::

   Instances that use the default security group cannot, by default, be
   accessed from any IP address outside of the cloud. If you want those
   IP addresses to access the instances, you must modify the rules for
   the default security group.

   You can also assign a floating IP address to a running instance to
   make it accessible from outside the cloud. See
   :doc:`cli_manage_ip_addresses`.

After you gather the parameters that you need to launch an instance,
you can launch it from an image_ or a :ref:`volume`. You can launch an
instance directly from one of the available OpenStack images or from
an image that you have copied to a persistent volume. The OpenStack
Image service provides a pool of images that are accessible to members
of different projects.

Gather parameters to launch an instance
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Before you begin, source the OpenStack RC file.

#. List the available flavors.

   .. code-block:: console

      $ nova flavor-list

   Note the ID of the flavor that you want to use for your instance::

    +-----+-----------+-----------+------+-----------+------+-------+-------------+-----------+
    | ID  | Name      | Memory_MB | Disk | Ephemeral | Swap | VCPUs | RXTX_Factor | Is_Public |
    +-----+-----------+-----------+------+-----------+------+-------+-------------+-----------+
    | 1   | m1.tiny   | 512       | 1    | 0         |      | 1     | 1.0         | True      |
    | 2   | m1.small  | 2048      | 20   | 0         |      | 1     | 1.0         | True      |
    | 3   | m1.medium | 4096      | 40   | 0         |      | 2     | 1.0         | True      |
    | 4   | m1.large  | 8192      | 80   | 0         |      | 4     | 1.0         | True      |
    | 5   | m1.xlarge | 16384     | 160  | 0         |      | 8     | 1.0         | True      |
    +-----+-----------+-----------+------+-----------+------+-------+-------------+-----------+

#. List the available images.

   .. code-block:: console

      $ nova image-list

   Note the ID of the image from which you want to boot your instance::

    +--------------------------------------+---------------------------------+--------+--------+
    | ID                                   | Name                            | Status | Server |
    +--------------------------------------+---------------------------------+--------+--------+
    | 397e713c-b95b-4186-ad46-6126863ea0a9 | cirros-0.3.2-x86_64-uec         | ACTIVE |        |
    | df430cc2-3406-4061-b635-a51c16e488ac | cirros-0.3.2-x86_64-uec-kernel  | ACTIVE |        |
    | 3cf852bd-2332-48f4-9ae4-7d926d50945e | cirros-0.3.2-x86_64-uec-ramdisk | ACTIVE |        |
    +--------------------------------------+---------------------------------+--------+--------+

   You can also filter the image list by using :command:`grep` to find a specific
   image, as follows:

   .. code-block:: console

      $ nova image-list | grep 'kernel'

      | df430cc2-3406-4061-b635-a51c16e488ac | cirros-0.3.2-x86_64-uec-kernel  | ACTIVE |        |

#. List the available security groups.

   .. code-block:: console

      $ nova secgroup-list --all-tenants

   .. note::

      If you are an admin user, specify the `--all-tenants` parameter to
      list groups for all tenants.



   Note the ID of the security group that you want to use for your
   instance::

    +----+---------+-------------+----------------------------------+
    | Id | Name    | Description | Tenant_ID                        |
    +----+---------+-------------+----------------------------------+
    | 2  | default | default     | 66265572db174a7aa66eba661f58eb9e |
    | 1  | default | default     | b70d90d65e464582b6b2161cf3603ced |
    +----+---------+-------------+----------------------------------+

   If you have not created any security groups, you can assign the instance
   to only the default security group.

   You can view rules for a specified security group:

   .. code-block:: console

      $ nova secgroup-list-rules default

#. List the available key pairs, and note the key pair name that you use for
   SSH access.

   .. code-block:: console

      $ nova keypair-list

.. _image:

Launch an instance from an image
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. After you gather required parameters, run the following command to
   launch an instance. Specify the server name, flavor ID, and image ID.

   .. code-block:: console

      $ nova boot --flavor FLAVOR_ID --image IMAGE_ID --key-name KEY_NAME \
        --user-data USER_DATA_FILE --security-groups SEC_GROUP_NAME --meta KEY=VALUE \
        INSTANCE_NAME

   Optionally, you can provide a key name for access control and a security
   group for security. You can also include metadata key and value pairs.
   For example, you can add a description for your server by providing the
   ``--meta description="My Server"`` parameter.

   You can pass user data in a local file at instance launch by using the
   ``--user-data USER-DATA-FILE`` parameter.

   .. important::

      If you boot an instance with an INSTANCE_NAME greater than 63 characters,
      Compute truncates it automatically when turning it into a host name to
      ensure the correct work of dnsmasq. The corresponding warning is written
      into the ``nova-network.log`` file.

   The following command launches the ``MyCirrosServer`` instance with the
   ``m1.small`` flavor (ID of ``1``), ``cirros-0.3.2-x86_64-uec`` image (ID
   of ``397e713c-b95b-4186-ad46-6126863ea0a9``), ``default`` security
   group, ``KeyPair01`` key, and a user data file called
   ``cloudinit.file``:

   .. code-block:: console

      $ nova boot --flavor 1 --image 397e713c-b95b-4186-ad46-6126863ea0a9 \
        --security-groups default --key-name KeyPair01 --user-data cloudinit.file \
        myCirrosServer

   Depending on the parameters that you provide, the command returns a list
   of server properties.

   .. code-block:: console

      +-------------------------------------+-------------------------------------+
      | Property                            | Value                               |
      +-------------------------------------+-------------------------------------+
      | OS-EXT-STS:task_state               | scheduling                          |
      | image                               | cirros-0.3.2-x86_64-uec             |
      | OS-EXT-STS:vm_state                 | building                            |
      | OS-EXT-SRV-ATTR:instance_name       | instance-00000002                   |
      | flavor                              | m1.small                            |
      | id                                  | b3cdc6c0-85a7-4904-ae85-71918f734048|
      | security_groups                     | [{u'name': u'default'}]             |
      | user_id                             | 376744b5910b4b4da7d8e6cb483b06a8    |
      | OS-DCF:diskConfig                   | MANUAL                              |
      | accessIPv4                          |                                     |
      | accessIPv6                          |                                     |
      | progress                            | 0                                   |
      | OS-EXT-STS:power_state              | 0                                   |
      | OS-EXT-AZ:availability_zone         | nova                                |
      | config_drive                        |                                     |
      | status                              | BUILD                               |
      | updated                             | 2013-07-16T16:25:34Z                |
      | hostId                              |                                     |
      | OS-EXT-SRV-ATTR:host                | None                                |
      | key_name                            | KeyPair01                           |
      | OS-EXT-SRV-ATTR:hypervisor_hostname | None                                |
      | name                                | myCirrosServer                      |
      | adminPass                           | tVs5pL8HcPGw                        |
      | tenant_id                           | 66265572db174a7aa66eba661f58eb9e    |
      | created                             | 2013-07-16T16:25:34Z                |
      | metadata                            | {u'KEY': u'VALUE'}                  |
      +-------------------------------------+-------------------------------------+

   A status of ``BUILD`` indicates that the instance has started, but is
   not yet online.

   A status of ``ACTIVE`` indicates that the instance is active.

#. Copy the server ID value from the ``id`` field in the output. Use the
   ID to get server details or to delete your server.

#. Copy the administrative password value from the ``adminPass`` field. Use the
   password to log in to your server.

   .. note::

      You can also place arbitrary local files into the instance file
      system at creation time by using the ``--file <dst-path=src-path>``
      option. You can store up to five files. For example, if you have a
      special authorized keys file named ``special_authorized_keysfile`` that
      you want to put on the instance rather than using the regular SSH key
      injection, you can use the `--file` option as shown in the following
      example.

   .. code-block:: console

      $ nova boot --image ubuntu-cloudimage --flavor 1 vm-name \
        --file /root/.ssh/authorized_keys=special_authorized_keysfile

4. Check if the instance is online.

   .. code-block:: console

      $ nova list

   The list shows the ID, name, status, and private (and if assigned,
   public) IP addresses for all instances in the project to which you
   belong:

   .. code-block:: console

      +-------------+----------------------+--------+------------+-------------+------------------+
      | ID          | Name                 | Status | Task State | Power State | Networks         |
      +-------------+----------------------+--------+------------+-------------+------------------+
      | 84c6e57d... | myCirrosServer       | ACTIVE | None       | Running     | private=10.0.0.3 |
      | 8a99547e... | myInstanceFromVolume | ACTIVE | None       | Running     | private=10.0.0.4 |
      +-------------+----------------------+--------+------------+-------------+------------------+

   If the status for the instance is ACTIVE, the instance is online.

#. To view the available options for the :command:`nova list` command, run the
   following command:

   .. code-block:: console

      $ nova help list

   .. note::

      If you did not provide a key pair, security groups, or rules, you
      can access the instance only from inside the cloud through VNC. Even
      pinging the instance is not possible.

.. toctree::
   :maxdepth: 2

   cli_nova_launch_instance_from_volume.rst
   cli_nova_launch_instance_using_ISO_image.rst

