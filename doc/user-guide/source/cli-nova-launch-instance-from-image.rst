================================
Launch an instance from an image
================================

Follow the steps below to launch an instance from an image.

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
      injection, you can use the :option:`--file` option as shown in the following
      example.

   .. code-block:: console

      $ nova boot --image ubuntu-cloudimage --flavor 1 vm-name \
        --file /root/.ssh/authorized_keys=special_authorized_keysfile

#. Check if the instance is online.

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

