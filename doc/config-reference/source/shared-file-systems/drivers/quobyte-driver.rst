==============
Quobyte Driver
==============

Quobyte can be used as a storage back end for the OpenStack Shared File
System service. Shares in the Shared File System service are mapped 1:1
to Quobyte volumes. Access is provided via NFS protocol and IP-based
authentication. The Quobyte driver uses the Quobyte API service.

Supported shared filesystems and operations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The drivers supports NFS shares.

The following operations are supported:

- Create a share.

- Delete a share.

- Allow share access.

  Note the following limitations:

  - Only IP access type is supported.

- Deny share access.


Driver options
~~~~~~~~~~~~~~

The following table contains the configuration options specific to the
share driver.

.. include:: ../../tables/manila-quobyte.rst

Configuration
~~~~~~~~~~~~~~

To configure Quobyte access for the Shared File System service, a back end
configuration section has to be added in the ``manila.conf`` file. Add the
name of the configuration section to ``enabled_share_backends`` in the
``manila.conf`` file. For example, if the section is named ``Quobyte``:

.. code-block:: ini

   enabled_share_backends = Quobyte

Create the new back end configuration section, in this case named
``Quobyte``:

.. code-block:: ini

   [Quobyte]

   share_driver = manila.share.drivers.quobyte.quobyte.QuobyteShareDriver
   share_backend_name = QUOBYTE
   quobyte_api_url = http://api.myserver.com:1234/
   quobyte_delete_shares = False
   quobyte_volume_configuration = BASE
   quobyte_default_volume_user = myuser
   quobyte_default_volume_group = mygroup

The section name must match the name used in the
``enabled_share_backends`` option described above.
The ``share_driver`` setting is required as shown, the
other options should be set according to your local Quobyte setup.

Other security-related options are:

.. code-block:: ini

   quobyte_api_ca = /path/to/API/server/verification/certificate
   quobyte_api_username = api_user
   quobyte_api_password = api_user_pwd

Quobyte support can be found at the `Quobyte support webpage
<http://support.quobyte.com>`_.
