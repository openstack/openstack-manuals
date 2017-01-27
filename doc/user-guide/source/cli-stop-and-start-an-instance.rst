==========================
Stop and start an instance
==========================

Use one of the following methods to stop and start an instance.

Pause and unpause an instance
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To pause an instance, run the following command:

.. code-block:: console

   $ openstack server pause INSTANCE_NAME

This command stores the state of the VM in RAM. A paused instance
continues to run in a frozen state.

To unpause an instance, run the following command:

.. code-block:: console

   $ openstack server unpause INSTANCE_NAME

Suspend and resume an instance
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To initiate a hypervisor-level suspend operation, run the following
command:

.. code-block:: console

   $ openstack server suspend INSTANCE_NAME

To resume a suspended instance, run the following command:

.. code-block:: console

   $ openstack server resume INSTANCE_NAME

Shelve and unshelve an instance
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Shelving is useful if you have an instance that you are not using, but
would like retain in your list of servers. For example, you can stop an
instance at the end of a work week, and resume work again at the start
of the next week. All associated data and resources are kept; however,
anything still in memory is not retained. If a shelved instance is no
longer needed, it can also be entirely removed.

You can run the following shelving tasks:

- Shelve an instance - Shuts down the instance, and stores it together
  with associated data and resources (a snapshot is taken if not volume
  backed). Anything in memory is lost.

.. code-block:: console

   $ openstack server shelve SERVERNAME

.. note::

   By default, the :command:`openstack server shelve` command gives the guest
   operating system a chance to perform a controlled shutdown before the
   instance is powered off. The shutdown behavior is configured by the
   ``shutdown_timeout`` parameter that can be set in the
   :file:`nova.conf` file. Its value stands for the overall
   period (in seconds) a guest operation system is allowed
   to complete the shutdown. The default timeout is 60 seconds.
   See `Description of Compute configuration options
   <https://docs.openstack.org/newton/config-reference/compute/config-options.html>`_
   for details.

   The timeout value can be overridden on a per image basis
   by means of ``os_shutdown_timeout`` that is an image metadata
   setting allowing different types of operating systems to specify
   how much time they need to shut down cleanly.

- Unshelve an instance - Restores the instance.

.. code-block:: console

   $ openstack server unshelve SERVERNAME

- Remove a shelved instance - Removes the instance from the server;
  data and resource associations are deleted. If an instance is no longer
  needed, you can move the instance off the hypervisor in order to minimize
  resource usage.

.. code-block:: console

   $ nova shelve-offload SERVERNAME
