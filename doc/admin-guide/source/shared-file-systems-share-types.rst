.. _shared_file_systems_share_types:

===========
Share types
===========

A share type enables you to filter or choose back ends before you create a
share and to set data for the share driver. A share type behaves in the same
way as a Block Storage volume type behaves.

In the Shared File Systems configuration file ``manila.conf``, the
administrator can set the share type used by default for the share creation
and then create a default share type.

To create a share type, use :command:`manila type-create` command as:

.. code-block:: console

   manila type-create [--snapshot_support <snapshot_support>]
                      [--is_public <is_public>]
                      <name> <spec_driver_handles_share_servers>

where the ``name`` is the share type name, ``--is_public`` defines the level of
the visibility for the share type, ``snapshot_support`` and
``spec_driver_handles_share_servers`` are the extra specifications used to
filter back ends. Administrators can create share types with these extra
specifications for the back ends filtering:

- ``driver_handles_share_servers``. Required. Defines the driver mode for share
  server lifecycle management. Valid values are ``true``/``1`` and
  ``false``/``0``.
  Set to True when the share driver can manage, or handle, the share server
  lifecycle.
  Set to False when an administrator, rather than a share driver, manages
  the bare metal storage with some net interface instead of the presence
  of the share servers.

- ``snapshot_support``. Filters back ends by whether they do or do not support
  share snapshots. Default is ``True``.
  Set to True to find back ends that support share snapshots.
  Set to False to find back ends that do not support share snapshots.

.. note::

   The extra specifications set in the share types are operated in the
   :ref:`shared_file_systems_scheduling`.

Administrators can also set additional extra specifications for a share type
for the following purposes:

- *Filter back ends*. Unqualified extra specifications written in
  this format: ``extra_spec=value``. For example, **netapp_raid_type=raid4**.

- *Set data for the driver*. Qualified extra specifications always written
  with the prefix with a colon, except for the special ``capabilities``
  prefix, in this format: ``vendor:extra_spec=value``. For example,
  **netapp:thin_provisioned=true**.

The scheduler uses the special capabilities prefix for filtering. The scheduler
can only create a share on a back end that reports capabilities matching the
un-scoped extra-spec keys for the share type. For details, see `Capabilities
and Extra-Specs <https://docs.openstack.org/developer/manila/devref/
capabilities_and_extra_specs.html>`_.

Each driver implementation determines which extra specification keys it uses.
For details, see the documentation for the driver.

An administrator can use the ``policy.json`` file to grant permissions for
share type creation with extra specifications to other roles.

You set a share type to private or public and
:ref:`manage the access<share_type_access>` to the private share types. By
default a share type is created as publicly accessible. Set
``--is_public`` to ``False`` to make the share type private.

Share type operations
---------------------

To create a new share type you need to specify the name of the new share
type. You also require an extra spec ``driver_handles_share_servers``.
The new share type can also be public.

.. code-block:: console

   $ manila type-create netapp1 False --is_public True

   $ manila type-list
   +-----+--------+-----------+-----------+-----------------------------------+-----------------------+
   | ID  | Name   | Visibility| is_default| required_extra_specs              | optional_extra_specs  |
   +-----+--------+-----------+-----------+-----------------------------------+-----------------------+
   | c0..| netapp1| public    | -         | driver_handles_share_servers:False| snapshot_support:True |
   +-----+--------+-----------+-----------+-----------------------------------+-----------------------+

You can set or unset extra specifications for a share type
using **manila type-key <share_type> set <key=value>** command. Since it is up
to each driver what extra specification keys it uses, see the documentation
for the specified driver.

.. code-block:: console

   $ manila type-key netapp1 set thin_provisioned=True

It is also possible to view a list of current share types and extra
specifications:

.. code-block:: console

   $ manila extra-specs-list
   +-------------+---------+-------------------------------------+
   | ID          | Name    | all_extra_specs                     |
   +-------------+---------+-------------------------------------+
   | c0086582-...| netapp1 | snapshot_support : True             |
   |             |         | thin_provisioned : True             |
   |             |         | driver_handles_share_servers : True |
   +-------------+---------+-------------------------------------+

Use :command:`manila type-key <share_type> unset <key>` to unset an extra
specification.

The public or private share type can be deleted with the
:command:`manila type-delete <share_type>` command.

.. _share_type_access:

Share type access
-----------------

You can manage access to a private share type for different projects.
Administrators can provide access, remove access, and retrieve
information about access for a specified private share.

Create a private type:

.. code-block:: console

   $ manila type-create my_type1 True --is_public False
   +----------------------+--------------------------------------+
   | Property             | Value                                |
   +----------------------+--------------------------------------+
   | required_extra_specs | driver_handles_share_servers : True  |
   | Name                 | my_type1                             |
   | Visibility           | private                              |
   | is_default           | -                                    |
   | ID                   | 06793be5-9a79-4516-89fe-61188cad4d6c |
   | optional_extra_specs | snapshot_support : True              |
   +----------------------+--------------------------------------+

.. note::

   If you run :command:`manila type-list` only public share types appear.
   To see private share types, run :command:`manila type-list` with
   ``--all`` optional argument.

Grant access to created private type for a demo and alt_demo projects
by providing their IDs:

.. code-block:: console

   $ manila type-access-add my_type1 d8f9af6915404114ae4f30668a4f5ba7
   $ manila type-access-add my_type1 e4970f57f1824faab2701db61ee7efdf

To view information about access for a private share, type ``my_type1``:

.. code-block:: console

   $ manila type-access-list my_type1
   +----------------------------------+
   | Project_ID                       |
   +----------------------------------+
   | d8f9af6915404114ae4f30668a4f5ba7 |
   | e4970f57f1824faab2701db61ee7efdf |
   +----------------------------------+

After granting access to the share, the target project
can see the share type in the list, and create private
shares.

To deny access for a specified project, use
:command:`manila type-access-remove <share_type> <project_id>` command.
