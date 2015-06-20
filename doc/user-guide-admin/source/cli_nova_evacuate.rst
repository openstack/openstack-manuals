==================
Evacuate instances
==================

If a cloud compute node fails due to a hardware malfunction or another
reason, you can evacuate instances to make them available again. You
can optionally include the target host on the :command:`evacuate`
command. If you omit the host, the scheduler determines the target
host.

To preserve user data on server disk, you must configure shared
storage on the target host. Also, you must validate that the current
VM host is down; otherwise, the evacuation fails with an error.

#. To list hosts and find a different host for the evacuated instance, run::

   $ nova host-list

#. Evacuate the instance. You can pass the instance password to the
   command by using the :option:`--password PWD` option. If you do not
   specify a password, one is generated and printed after the command
   finishes successfully. The following command evacuates a server
   without shared storage from a host that is down to the specified
   HOST_B::

   $ nova evacuate EVACUATED_SERVER_NAME HOST_B

   The instance is booted from a new disk, but preserves its
   configuration including its ID, name, uid, IP address, and so on.
   The command returns a password::

    +-----------+--------------+
    | Property  |    Value     |
    +-----------+--------------+
    | adminPass | kRAJpErnT4xZ |
    +-----------+--------------+

#. To preserve the user disk data on the evacuated server, deploy
   OpenStack Compute with a shared file system. To configure your
   system, see `Configure migrations
   <http://docs.openstack.org/admin-guide-cloud/content/section_configuring-compute-migrations.html>`_
   in OpenStack Cloud Administrator Guide. In the following example,
   the password remains unchanged::

   $ nova evacuate EVACUATED_SERVER_NAME HOST_B --on-shared-storage
