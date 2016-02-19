.. _heat-verify:

Verify operation
~~~~~~~~~~~~~~~~

Verify operation of the Orchestration service.

.. note::

   Perform these commands on the controller node.

#. Source the ``admin`` tenant credentials:

   .. code-block:: console

      $ source admin-openrc.sh

#. List service components to verify successful launch and
   registration of each process:

   .. code-block:: console

      $ heat service-list
      +------------+-------------+--------------------------------------+------------+--------+----------------------------+--------+
      | hostname   | binary      | engine_id                            | host       | topic  | updated_at                 | status |
      +------------+-------------+--------------------------------------+------------+--------+----------------------------+--------+
      | controller | heat-engine | 3e85d1ab-a543-41aa-aa97-378c381fb958 | controller | engine | 2015-10-13T14:16:06.000000 | up     |
      | controller | heat-engine | 45dbdcf6-5660-4d5f-973a-c4fc819da678 | controller | engine | 2015-10-13T14:16:06.000000 | up     |
      | controller | heat-engine | 51162b63-ecb8-4c6c-98c6-993af899c4f7 | controller | engine | 2015-10-13T14:16:06.000000 | up     |
      | controller | heat-engine | 8d7edc6d-77a6-460d-bd2a-984d76954646 | controller | engine | 2015-10-13T14:16:06.000000 | up     |
      +------------+-------------+--------------------------------------+------------+--------+----------------------------+--------+

   .. note::

      This output should indicate four ``heat-engine`` components
      on the controller node.
