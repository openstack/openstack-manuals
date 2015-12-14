==============
Manage volumes
==============

Depending on the setup of your cloud provider, they may give you an
endpoint to use to manage volumes, or there may be an extension under
the covers. In either case, you can use the ``nova`` CLI to manage
volumes.

.. list-table:: **nova volume commands**
   :header-rows: 1

   * - Command
     - Description
   * - volume-attach
     - Attach a volume to a server.
   * - volume-create
     - Add a new volume.
   * - volume-delete
     - Remove a volume.
   * - volume-detach
     - Detach a volume from a server.
   * - volume-list
     - List all the volumes.
   * - volume-show
     - Show details about a volume.
   * - volume-snapshot-create
     - Add a new snapshot.
   * - volume-snapshot-delete
     - Remove a snapshot.
   * - volume-snapshot-list
     - List all the snapshots.
   * - volume-snapshot-show
     - Show details about a snapshot.
   * - volume-type-create
     - Create a new volume type.
   * - volume-type-delete
     - Delete a specific flavor
   * - volume-type-list
     - Print a list of available 'volume types'.
   * - volume-update
     - Update an attached volume.

|

For example, to list IDs and names of Compute volumes, run:

.. code-block:: console

   $ nova volume-list
   +-----------+-----------+--------------+------+-------------+-------------+
   | ID        | Status    | Display Name | Size | Volume Type | Attached to |
   +-----------+-----------+--------------+------+-------------+-------------+
   | 1af4cb9...| available | PerfBlock    | 1    | Performance |             |
   +-----------+-----------+--------------+------+-------------+-------------+
