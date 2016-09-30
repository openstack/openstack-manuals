.. _cinder-verify:

Verify operation
~~~~~~~~~~~~~~~~

Verify operation of the Block Storage service.

.. note::

   Perform these commands on the controller node.

#. Source the ``admin`` credentials to gain access to
   admin-only CLI commands:

   .. code-block:: console

      $ . admin-openrc

   .. end

#. List service components to verify successful launch of each process:

   .. code-block:: console

      $ cinder service-list

      +------------------+-------------+------+---------+-------+----------------------------+-----------------+
      | Binary           | Host        | Zone | Status  | State | Updated_at                 | Disabled Reason |
      +------------------+-------------+------+---------+-------+----------------------------+-----------------+
      | cinder-scheduler | hst-os1ctl1 | nova | enabled | up    | 2016-09-30T02:27:41.000000 | -               |
      | cinder-volume    | block@lvm   | nova | enabled | up    | 2016-09-30T02:27:46.000000 | -               |
      +------------------+-------------+------+---------+-------+----------------------------+-----------------+


   .. end
