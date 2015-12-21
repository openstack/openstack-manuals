==============================================
Volume encryption supported by the key manager
==============================================

We recommend the Key management service (barbican) for storing
encryption keys used by the OpenStack volume encryption feature. It can
be enabled by updating ``cinder.conf`` and ``nova.conf``.

Initial configuration
~~~~~~~~~~~~~~~~~~~~~

Configuration changes need to be made to any nodes running the
``cinder-volume`` or ``nova-compute`` server.

Steps to update ``cinder-volume`` servers:

#. Edit the ``/etc/cinder/cinder.conf`` file to use Key management service
   as follows:

   * Look for the ``[keymgr]`` section.

   * Enter a new line directly below ``[keymgr]`` with the following:

     .. code-block:: ini

        api_class = cinder.keymgr.barbican.BarbicanKeyManager

     .. note::

        Use a '#' prefix to comment out the line in this section that
        begins with 'fixed_key'.

#. Restart ``cinder-volume``.

Update ``nova-compute`` servers:

#. Repeat the same steps above to set up the Key management service by
   editing ``/etc/nova/nova.conf``.

#. Restart ``nova-compute``.

Follow the instructions in the OpenStack Admin User Guide under the
heading `Create an encrypted volume
type <http://docs.openstack.org/user-guide-admin/dashboard_manage_volumes.html>`__
or alternatively, see ``TODO`` in this manual to do this via the
command line.

TODO: Add link to section_create-encrypted-volume-type.

Create an encrypted volume by typing the command:

.. code-block:: console

    $ cinder create --name encryptedVolume --volume-type LUKS 1

For alternate instructions and details, including the console output,
see the TODO in this document.

TODO: Add link to section_create_volume.

Create an encrypted volume type
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Block Storage volume type assignment provides scheduling to a specific
back-end, and can be used to specify actionable information for a
back-end storage device.

This example creates a volume type called LUKS and provides
configuration information for the storage system to encrypt or decrypt
the volume.

#. Source your admin credentials:

   .. code-block:: console

      $ source admin-openrc.sh

#. Create the volume type:

   .. code-block:: console

      $ cinder type-create LUKS
      +--------------------------------------+-------+
      |                  ID                  |  Name |
      +--------------------------------------+-------+
      | e64b35a4-a849-4c53-9cc7-2345d3c8fbde | LUKS  |
      +--------------------------------------+-------+

#. Mark the volume type as encrypted and provide the necessary details. Use
   ``--control_location`` to specify where encryption is performed:
   ``front-end`` (default) or ``back-end``.

   .. code-block:: console


      $ cinder encryption-type-create --cipher aes-xts-plain64 --key_size 512 \
        --control_location front-end LUKS nova.volume.encryptors.luks.LuksEncryptor
      +--------------------------------------+-------------------------------------------+-----------------+----------+------------------+
      |            Volume Type ID            |                  Provider                 |      Cipher     | Key Size | Control Location |
      +--------------------------------------+-------------------------------------------+-----------------+----------+------------------+
      | e64b35a4-a849-4c53-9cc7-2345d3c8fbde | nova.volume.encryptors.luks.LuksEncryptor | aes-xts-plain64 |   512    |    front-end     |
      +--------------------------------------+-------------------------------------------+-----------------+----------+------------------+

The OpenStack dashboard (horizon) supports creating the encrypted
volume type as of the Kilo release.

Create an encrypted volume
~~~~~~~~~~~~~~~~~~~~~~~~~~

Use the OpenStack dashboard (horizon), or the :command:`cinder`
command to create volumes just as you normally would. For an encrypted
volume use the LUKS tag, for unencrypted leave the LUKS tag off.

#. Source your admin credentials:

   .. code-block:: console

      $ source admin-openrc.sh

#. Create an unencrypted 1 GB test volume:

   .. code-block:: console


      $ cinder create --display-name 'unencrypted volume' 1
      +--------------------------------+--------------------------------------+
      |            Property            |                Value                 |
      +--------------------------------+--------------------------------------+
      |          attachments           |                  []                  |
      |       availability_zone        |                 nova                 |
      |            bootable            |                false                 |
      |           created_at           |      2014-08-10T01:24:03.000000      |
      |          description           |                 None                 |
      |           encrypted            |                False                 |
      |               id               | 081700fd-2357-44ff-860d-2cd78ad9c568 |
      |            metadata            |                  {}                  |
      |              name              |          unencrypted volume          |
      |     os-vol-host-attr:host      |              controller              |
      | os-vol-mig-status-attr:migstat |                 None                 |
      | os-vol-mig-status-attr:name_id |                 None                 |
      |  os-vol-tenant-attr:tenant_id  |   08fdea76c760475f82087a45dbe94918   |
      |              size              |                  1                   |
      |          snapshot_id           |                 None                 |
      |          source_volid          |                 None                 |
      |             status             |               creating               |
      |            user_id             |   7cbc6b58b372439e8f70e2a9103f1332   |
      |          volume_type           |                 None                 |
      +--------------------------------+--------------------------------------+

#. Create an encrypted 1 GB test volume:

   .. code-block:: console

      $ cinder create --display-name 'encrypted volume' --volume-type LUKS 1
      +--------------------------------+--------------------------------------+
      |            Property            |                Value                 |
      +--------------------------------+--------------------------------------+
      |          attachments           |                  []                  |
      |       availability_zone        |                 nova                 |
      |            bootable            |                false                 |
      |           created_at           |      2014-08-10T01:24:24.000000      |
      |          description           |                 None                 |
      |           encrypted            |                 True                 |
      |               id               | 86060306-6f43-4c92-9ab8-ddcd83acd973 |
      |            metadata            |                  {}                  |
      |              name              |           encrypted volume           |
      |     os-vol-host-attr:host      |              controller              |
      | os-vol-mig-status-attr:migstat |                 None                 |
      | os-vol-mig-status-attr:name_id |                 None                 |
      |  os-vol-tenant-attr:tenant_id  |   08fdea76c760475f82087a45dbe94918   |
      |              size              |                  1                   |
      |          snapshot_id           |                 None                 |
      |          source_volid          |                 None                 |
      |             status             |               creating               |
      |            user_id             |   7cbc6b58b372439e8f70e2a9103f1332   |
      |          volume_type           |                 LUKS                 |
      +--------------------------------+--------------------------------------+

Notice the encrypted parameter; it will show ``True`` or ``False``.
The option ``volume_type`` is also shown for easy review.

.. note::

   Due to the issue that some of the volume drivers do not set
   ``encrypted`` flag, attaching of encrypted volumes to a virtual
   guest will fail, because OpenStack Compute service will not run
   encryption providers.

Testing volume encryption
~~~~~~~~~~~~~~~~~~~~~~~~~

This is a simple test scenario to help validate your encryption. It
assumes an LVM based Block Storage server.

Perform these steps after completing the volume encryption setup and
creating the volume-type for LUKS as described in the preceding
sections.

#. Create a VM:

   .. code-block:: console

      $ nova boot --flavor m1.tiny --image cirros-0.3.1-x86_64-disk vm-test

#. Create two volumes, one encrypted and one not encrypted then attach them
   to your VM:

   .. code-block:: console


      $ cinder create --display-name 'unencrypted volume' 1
      $ cinder create --display-name 'encrypted volume' --volume-type LUKS 1
      $ cinder list
      +--------------------------------------+-----------+--------------------+------+-------------+----------+-------------+
      |                  ID                  |   Status  |        Name        | Size | Volume Type | Bootable | Attached to |
      +--------------------------------------+-----------+--------------------+------+-------------+----------+-------------+
      | 64b48a79-5686-4542-9b52-d649b51c10a2 | available | unencrypted volume |  1   |     None    |  false   |             |
      | db50b71c-bf97-47cb-a5cf-b4b43a0edab6 | available |  encrypted volume  |  1   |     LUKS    |  false   |             |
      +--------------------------------------+-----------+--------------------+------+-------------+----------+-------------+
      $ nova volume-attach vm-test 64b48a79-5686-4542-9b52-d649b51c10a2 /dev/vdb
      $ nova volume-attach vm-test db50b71c-bf97-47cb-a5cf-b4b43a0edab6 /dev/vdc

#. On the VM, send some text to the newly attached volumes and synchronize
   them:

   .. code-block:: console

      # echo "Hello, world (unencrypted /dev/vdb)" >> /dev/vdb
      # echo "Hello, world (encrypted /dev/vdc)" >> /dev/vdc
      # sync && sleep 2
      # sync && sleep 2

#. On the system hosting cinder volume services, synchronize to flush the
   I/O cache then test to see if your strings can be found:

   .. code-block:: console

      # sync && sleep 2
      # sync && sleep 2
      # strings /dev/stack-volumes/volume-* | grep "Hello"
      Hello, world (unencrypted /dev/vdb)

In the above example you see that the search returns the string
written to the unencrypted volume, but not the encrypted one.
