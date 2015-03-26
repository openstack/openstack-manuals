==================
Delete an instance
==================

When you no longer need an instance, you can delete it.

#. List all instances::


    $ nova list
    +-------------+----------------------+--------+------------+-------------+------------------+
    | ID          | Name                 | Status | Task State | Power State | Networks         |
    +-------------+----------------------+--------+------------+-------------+------------------+
    | 84c6e57d... | myCirrosServer       | ACTIVE | None       | Running     | private=10.0.0.3 |
    | 8a99547e... | myInstanceFromVolume | ACTIVE | None       | Running     | private=10.0.0.4 |
    | d7efd3e4... | newServer            | ERROR  | None       | NOSTATE     |                  |
    +-------------+----------------------+--------+------------+-------------+------------------+

#. Run the ``nova delete`` command to delete the instance. The following
   example shows deletion of the ``newServer`` instance, which is in
   ``ERROR`` state::

    $ nova delete newServer

   The command does not notify that your server was deleted.

#. To verify that the server was deleted, run the ``nova list`` command::

    $ nova list
    +-------------+----------------------+--------+------------+-------------+------------------+
    | ID          | Name                 | Status | Task State | Power State | Networks         |
    +-------------+----------------------+--------+------------+-------------+------------------+
    | 84c6e57d... | myCirrosServer       | ACTIVE | None       | Running     | private=10.0.0.3 |
    | 8a99547e... | myInstanceFromVolume | ACTIVE | None       | Running     | private=10.0.0.4 |
    +-------------+----------------------+--------+------------+-------------+------------------+

   The deleted instance does not appear in the list.
