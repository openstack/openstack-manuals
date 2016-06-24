=========================================
Select hosts where instances are launched
=========================================

With the appropriate permissions, you can select which
host instances are launched on and which roles can boot instances
on this host.

#. To select the host where instances are launched, use
   the :option:`--availability-zone ZONE:HOST` parameter on the
   :command:`openstack server create` command.

   For example:

   .. code-block:: console

      $ openstack server create --image IMAGE --flavor m1.tiny \
        --key-name KEY --availability-zone ZONE:HOST \
        --nic net-id=UUID SERVER

#. To specify which roles can launch an instance on a
   specified host, enable the ``create:forced_host`` option in
   the ``policy.json`` file. By default, this option is
   enabled for only the admin role.

#. To view the list of valid compute hosts, use the
   :command:`openstack hypervisor list` command.

   .. code-block:: console

      $ openstack hypervisor list
      +----+---------------------+
      | ID | Hypervisor Hostname |
      +----+---------------------+
      |  1 | server2             |
      |  2 | server3             |
      |  3 | server4             |
      +----+---------------------+
