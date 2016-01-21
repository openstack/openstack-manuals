==============================
Change the size of your server
==============================

Change the size of a server by changing its flavor.

#. Show information about your server, including its size, which is shown
   as the value of the flavor property:

   .. code-block:: console

      $ nova show myCirrosServer
      +-------------------------------------+-------------------------------------+
      | Property                            | Value                               |
      +-------------------------------------+-------------------------------------+
      | status                              | ACTIVE                              |
      | updated                             | 2013-07-18T15:08:20Z                |
      | OS-EXT-STS:task_state               | None                                |
      | OS-EXT-SRV-ATTR:host                | devstack                            |
      | key_name                            | None                                |
      | image                               | cirros-0.3.2-x86_64-uec (397e71...  |
      | private network                     | 10.0.0.3                            |
      | hostId                              | 6e1e69b71ac9b1e6871f91e2dfc9a9b9... |
      | OS-EXT-STS:vm_state                 | active                              |
      | OS-EXT-SRV-ATTR:instance_name       | instance-00000005                   |
      | OS-EXT-SRV-ATTR:hypervisor_hostname | devstack                            |
      | flavor                              | m1.small (2)                        |
      | id                                  | 84c6e57d-a6b1-44b6-81eb-fcb36afd31b5|
      | security_groups                     | [{u'name': u'default'}]             |
      | user_id                             | 376744b5910b4b4da7d8e6cb483b06a8    |
      | name                                | myCirrosServer                      |
      | created                             | 2013-07-18T15:07:59Z                |
      | tenant_id                           | 66265572db174a7aa66eba661f58eb9e    |
      | OS-DCF:diskConfig                   | MANUAL                              |
      | metadata                            | {u'description': u'Small test ima...|
      | accessIPv4                          |                                     |
      | accessIPv6                          |                                     |
      | progress                            | 0                                   |
      | OS-EXT-STS:power_state              | 1                                   |
      | OS-EXT-AZ:availability_zone         | nova                                |
      | config_drive                        |                                     |
      +-------------------------------------+-------------------------------------+

   The size (flavor) of the server is ``m1.small (2)``.

#. List the available flavors with the following command:

   .. code-block:: console

      $ nova flavor-list
      +-----+-----------+-----------+------+-----------+------+-------+-------------+----------+
      | ID  | Name      | Memory_MB | Disk | Ephemeral | Swap | VCPUs | RXTX_Factor | Is_Public|
      +-----+-----------+-----------+------+-----------+------+-------+-------------+----------+
      | 1   | m1.tiny   | 512       | 1    | 0         |      | 1     | 1.0         | True     |
      | 2   | m1.small  | 2048      | 20   | 0         |      | 1     | 1.0         | True     |
      | 3   | m1.medium | 4096      | 40   | 0         |      | 2     | 1.0         | True     |
      | 4   | m1.large  | 8192      | 80   | 0         |      | 4     | 1.0         | True     |
      | 5   | m1.xlarge | 16384     | 160  | 0         |      | 8     | 1.0         | True     |
      +-----+-----------+-----------+------+-----------+------+-------+-------------+----------+

#. To resize the server, use the :command:`nova resize` command and add
   the server ID or name and the new flavor. Include the `--poll`
   parameter to display the resize progress. For example:

   .. code-block:: console

      $ nova resize myCirrosServer 4 --poll

    Instance resizing... 100% complete
    Finished

   .. note::

      By default, the :command:`nova resize` command gives the guest operating
      system a chance to perform a controlled shutdown before the instance
      is powered off and the instance is resized.
      The shutdown behavior is configured by the
      ``shutdown_timeout`` parameter that can be set in the
      ``nova.conf`` file. Its value stands for the overall
      period (in seconds) a guest operation system is allowed
      to complete the shutdown. The default timeout is 60 seconds.
      See `Description of Compute configuration options
      <http://docs.openstack.org/liberty/config-reference/content/list-of-compute-config-options.html>`_
      for details.

      The timeout value can be overridden on a per image basis
      by means of ``os_shutdown_timeout`` that is an image metadata
      setting allowing different types of operating systems to specify
      how much time they need to shut down cleanly.

#. Show the status for your server.

   .. code-block:: console

      $ nova list
      +----------------------+----------------+--------+-----------------------------------------+
      | ID                   | Name           | Status | Networks                                |
      +----------------------+----------------+--------+-----------------------------------------+
      | 84c6e57d-a6b1-44b... | myCirrosServer | RESIZE | private=172.16.101.6, public=10.4.113.6 |
      +----------------------+----------------+--------+-----------------------------------------+

   When the resize completes, the status becomes VERIFY\_RESIZE.

#. Confirm the resize,for example:

   .. code-block:: console

      $ nova resize-confirm 84c6e57d-a6b1-44b6-81eb-fcb36afd31b5

   The server status becomes ACTIVE.

#. If the resize fails or does not work as expected, you can revert the
   resize. For example:

   .. code-block:: console

      $ nova resize-revert 84c6e57d-a6b1-44b6-81eb-fcb36afd31b5

   The server status becomes ACTIVE.
