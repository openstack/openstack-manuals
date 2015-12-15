.. _shared_file_systems_share_resize:

============
Resize share
============

To change file share size, use :command:`manila extend` and
:command:`manila shrink`. For most drivers it is safe operation. If you want to
be sure that your data is safe, you can make a share back up by creating a
snapshot of it.

You can extend and shrink the share with the :command:`manila extend` and
:command:`manila shrink` commands respectively and specifying the share
with the new size that does not exceed the quota. For details, see
:ref:`Quotas and Limits <shared_file_systems_quotas>`. You also cannot shrink
size to 0 or to a greater value than the current share size.

While extending the share gets ``extending`` status that means that the
increase share size request was issued successfully.

To extend the share and check the result, run:

.. code-block:: console

   $ manila extend Share1 2
   $ manila show Share1
   +-----------------------------+-------------------------------------------+
   | Property                    | Value                                     |
   +-----------------------------+-------------------------------------------+
   | status                      | available                                 |
   | share_type_name             | default                                   |
   | description                 | My first share. Updated                   |
   | availability_zone           | nova                                      |
   | share_network_id            | 5c3cbabb-f4da-465f-bc7f-fadbe047b85a      |
   | export_locations            | 10.254.0.3:/shares/share-2d5e2c0a-1f84-...|
   | share_server_id             | 41b7829d-7f6b-4c96-aea5-d106c2959961      |
   | host                        | manila@generic1#GENERIC1                  |
   | snapshot_id                 | None                                      |
   | is_public                   | False                                     |
   | task_state                  | None                                      |
   | snapshot_support            | True                                      |
   | id                          | aca648eb-8c03-4394-a5cc-755066b7eb66      |
   | size                        | 2                                         |
   | name                        | Share1                                    |
   | share_type                  | c0086582-30a6-4060-b096-a42ec9d66b86      |
   | created_at                  | 2015-09-24T12:19:06.000000                |
   | share_proto                 | NFS                                       |
   | consistency_group_id        | None                                      |
   | source_cgsnapshot_member_id | None                                      |
   | project_id                  | 20787a7ba11946adad976463b57d8a2f          |
   | metadata                    | {u'deadline': u'01/30/16'}                |
   +-----------------------------+-------------------------------------------+

While shrinking the share gets ``shrinking`` status that means that the
decrease share size request was issued successfully. To shrink the share and
check the result, run:

.. code-block:: console

   $ manila shrink Share1 1
   $ manila show Share1
   +-----------------------------+-------------------------------------------+
   | Property                    | Value                                     |
   +-----------------------------+-------------------------------------------+
   | status                      | available                                 |
   | share_type_name             | default                                   |
   | description                 | My first share. Updated                   |
   | availability_zone           | nova                                      |
   | share_network_id            | 5c3cbabb-f4da-465f-bc7f-fadbe047b85a      |
   | export_locations            | 10.254.0.3:/shares/share-2d5e2c0a-1f84-...|
   | share_server_id             | 41b7829d-7f6b-4c96-aea5-d106c2959961      |
   | host                        | manila@generic1#GENERIC1                  |
   | snapshot_id                 | None                                      |
   | is_public                   | False                                     |
   | task_state                  | None                                      |
   | snapshot_support            | True                                      |
   | id                          | aca648eb-8c03-4394-a5cc-755066b7eb66      |
   | size                        | 1                                         |
   | name                        | Share1                                    |
   | share_type                  | c0086582-30a6-4060-b096-a42ec9d66b86      |
   | created_at                  | 2015-09-24T12:19:06.000000                |
   | share_proto                 | NFS                                       |
   | consistency_group_id        | None                                      |
   | source_cgsnapshot_member_id | None                                      |
   | project_id                  | 20787a7ba11946adad976463b57d8a2f          |
   | metadata                    | {u'deadline': u'01/30/16'}                |
   +-----------------------------+-------------------------------------------+
