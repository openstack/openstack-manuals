.. _shared_file_systems_share_resize:

============
Resize share
============

To change file share size, use the :command:`manila extend` command and
the :command:`manila shrink` command. For most drivers it is safe
operation. If you want to be sure that your data is safe, you can make
a share back up by creating a snapshot of it.

You can extend and shrink the share with the :command:`manila extend` and
:command:`manila shrink` commands respectively, and specify the share
with the new size that does not exceed the quota. For details, see
:ref:`Quotas and Limits <shared_file_systems_quotas>`. You also cannot shrink
share size to 0 or to a greater value than the current share size.

While extending, the share has an ``extending`` status. This means that
the increase share size request was issued successfully.

To extend the share and check the result, run:

.. code-block:: console

   $ manila extend docs_resize 2
   $ manila show docs_resize
   +----------------------+--------------------------------------------------------------------------+
   | Property             | Value                                                                    |
   +----------------------+--------------------------------------------------------------------------+
   | status               | available                                                                |
   | share_type_name      | my_type                                                                  |
   | description          | None                                                                     |
   | availability_zone    | nova                                                                     |
   | share_network_id     | None                                                                     |
   | export_locations     |                                                                          |
   |                      | path = 1.0.0.4:/shares/manila_share_b8afc508_8487_442b_b170_ea65b07074a8 |
   |                      | preferred = False                                                        |
   |                      | is_admin_only = False                                                    |
   |                      | id = 3ffb76f4-92b9-4639-83fd-025bc3e302ff                                |
   |                      | share_instance_id = b8afc508-8487-442b-b170-ea65b07074a8                 |
   |                      | path = 2.0.0.3:/shares/manila_share_b8afc508_8487_442b_b170_ea65b07074a8 |
   |                      | preferred = False                                                        |
   |                      | is_admin_only = True                                                     |
   |                      | id = 1f0e263f-370d-47d3-95f6-1be64088b9da                                |
   |                      | share_instance_id = b8afc508-8487-442b-b170-ea65b07074a8                 |
   | share_server_id      | None                                                                     |
   | host                 | manila@paris#shares                                                      |
   | access_rules_status  | active                                                                   |
   | snapshot_id          | None                                                                     |
   | is_public            | False                                                                    |
   | task_state           | None                                                                     |
   | snapshot_support     | True                                                                     |
   | id                   | b07dbebe-a328-403c-b402-c8871c89e3d1                                     |
   | size                 | 2                                                                        |
   | name                 | docs_resize                                                              |
   | share_type           | 14ee8575-aac2-44af-8392-d9c9d344f392                                     |
   | has_replicas         | False                                                                    |
   | replication_type     | None                                                                     |
   | created_at           | 2016-03-25T15:33:18.000000                                               |
   | share_proto          | NFS                                                                      |
   | consistency_group_id | None                                                                     |
   | project_id           | 907004508ef4447397ce6741a8f037c1                                         |
   | metadata             | {}                                                                       |
   +----------------------+--------------------------------------------------------------------------+

While shrinking, the share has a ``shrinking`` status. This means that the
decrease share size request was issued successfully. To shrink the share and
check the result, run:

.. code-block:: console

   $ manila shrink docs_resize 1
   $ manila show docs_resize
   +----------------------+--------------------------------------------------------------------------+
   | Property             | Value                                                                    |
   +----------------------+--------------------------------------------------------------------------+
   | status               | available                                                                |
   | share_type_name      | my_type                                                                  |
   | description          | None                                                                     |
   | availability_zone    | nova                                                                     |
   | share_network_id     | None                                                                     |
   | export_locations     |                                                                          |
   |                      | path = 1.0.0.4:/shares/manila_share_b8afc508_8487_442b_b170_ea65b07074a8 |
   |                      | preferred = False                                                        |
   |                      | is_admin_only = False                                                    |
   |                      | id = 3ffb76f4-92b9-4639-83fd-025bc3e302ff                                |
   |                      | share_instance_id = b8afc508-8487-442b-b170-ea65b07074a8                 |
   |                      | path = 2.0.0.3:/shares/manila_share_b8afc508_8487_442b_b170_ea65b07074a8 |
   |                      | preferred = False                                                        |
   |                      | is_admin_only = True                                                     |
   |                      | id = 1f0e263f-370d-47d3-95f6-1be64088b9da                                |
   |                      | share_instance_id = b8afc508-8487-442b-b170-ea65b07074a8                 |
   | share_server_id      | None                                                                     |
   | host                 | manila@paris#shares                                                      |
   | access_rules_status  | active                                                                   |
   | snapshot_id          | None                                                                     |
   | is_public            | False                                                                    |
   | task_state           | None                                                                     |
   | snapshot_support     | True                                                                     |
   | id                   | b07dbebe-a328-403c-b402-c8871c89e3d1                                     |
   | size                 | 1                                                                        |
   | name                 | docs_resize                                                              |
   | share_type           | 14ee8575-aac2-44af-8392-d9c9d344f392                                     |
   | has_replicas         | False                                                                    |
   | replication_type     | None                                                                     |
   | created_at           | 2016-03-25T15:33:18.000000                                               |
   | share_proto          | NFS                                                                      |
   | consistency_group_id | None                                                                     |
   | project_id           | 907004508ef4447397ce6741a8f037c1                                         |
   | metadata             | {}                                                                       |
   +----------------------+--------------------------------------------------------------------------+
