Verify operation
~~~~~~~~~~~~~~~~

Verify operation of the Image service using
`CirrOS <http://launchpad.net/cirros>`__, a small
Linux image that helps you test your OpenStack deployment.

For more information about how to download and build images, see
`OpenStack Virtual Machine Image Guide
<http://docs.openstack.org/image-guide/>`__.
For information about how to manage images, see the
`OpenStack User Guide
<http://docs.openstack.org/user-guide/common/cli_manage_images.html>`__.

#. In each client environment script, configure the Image service
   client to use API version 2.0:

   .. code-block:: console

      $ echo "export OS_IMAGE_API_VERSION=2" \
        | tee -a admin-openrc.sh demo-openrc.sh

#. Source the ``admin`` credentials to gain access to
   admin-only CLI commands:

   .. code-block:: console

      $ source admin-openrc.sh

#. Download the source image:

   .. code-block:: console

      $ wget http://download.cirros-cloud.net/0.3.4/cirros-0.3.4-x86_64-disk.img

#. Upload the image to the Image service using the
   :term:`QCOW2 <QEMU Copy On Write 2 (QCOW2)>` disk format, :term:`bare`
   container format, and public visibility so all projects can access it:

   .. code-block:: console

      $ glance image-create --name "cirros" \
        --file cirros-0.3.4-x86_64-disk.img \
        --disk-format qcow2 --container-format bare \
        --visibility public --progress
      [=============================>] 100%
      +------------------+--------------------------------------+
      | Property         | Value                                |
      +------------------+--------------------------------------+
      | checksum         | 133eae9fb1c98f45894a4e60d8736619     |
      | container_format | bare                                 |
      | created_at       | 2015-03-26T16:52:10Z                 |
      | disk_format      | qcow2                                |
      | id               | 38047887-61a7-41ea-9b49-27987d5e8bb9 |
      | min_disk         | 0                                    |
      | min_ram          | 0                                    |
      | name             | cirros                               |
      | owner            | ae7a98326b9c455588edd2656d723b9d     |
      | protected        | False                                |
      | size             | 13200896                             |
      | status           | active                               |
      | tags             | []                                   |
      | updated_at       | 2015-03-26T16:52:10Z                 |
      | virtual_size     | None                                 |
      | visibility       | public                               |
      +------------------+--------------------------------------+

   For information about the :command:`glance image-create` parameters,
   see `Image service command-line client
   <http://docs.openstack.org/cli-reference/content/
   glanceclient_commands.html#glanceclient_subcommand_image-create_v2>`__
   in the ``OpenStack Command-Line Interface Reference``.

   For information about disk and container formats for images, see
   `Disk and container formats for images
   <http://docs.openstack.org/image-guide/image-formats.html>`__
   in the ``OpenStack Virtual Machine Image Guide``.

   .. note::

      OpenStack generates IDs dynamically, so you will see
      different values in the example command output.

#. Confirm upload of the image and validate attributes:

   .. code-block:: console

      $ glance image-list
      +--------------------------------------+--------+
      | ID                                   | Name   |
      +--------------------------------------+--------+
      | 38047887-61a7-41ea-9b49-27987d5e8bb9 | cirros |
      +--------------------------------------+--------+
