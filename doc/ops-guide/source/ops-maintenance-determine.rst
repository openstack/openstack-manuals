=====================================
Determining Which Component Is Broken
=====================================

OpenStack's collection of different components interact with each other
strongly. For example, uploading an image requires interaction from
``nova-api``, ``glance-api``, ``glance-registry``, keystone, and
potentially ``swift-proxy``. As a result, it is sometimes difficult to
determine exactly where problems lie. Assisting in this is the purpose
of this section.

Tailing Logs
~~~~~~~~~~~~

The first place to look is the log file related to the command you are
trying to run. For example, if ``openstack server list`` is failing, try
tailing a nova log file and running the command again:

Terminal 1:

.. code-block:: console

   # tail -f /var/log/nova/nova-api.log

Terminal 2:

.. code-block:: console

   # openstack server list

Look for any errors or traces in the log file. For more information, see
:doc:`ops-logging-monitoring`.

If the error indicates that the problem is with another component,
switch to tailing that component's log file. For example, if nova cannot
access glance, look at the ``glance-api`` log:

Terminal 1:

.. code-block:: console

   # tail -f /var/log/glance/api.log

Terminal 2:

.. code-block:: console

   # openstack server list

Wash, rinse, and repeat until you find the core cause of the problem.

Running Daemons on the CLI
~~~~~~~~~~~~~~~~~~~~~~~~~~

Unfortunately, sometimes the error is not apparent from the log files.
In this case, switch tactics and use a different command; maybe run the
service directly on the command line. For example, if the ``glance-api``
service refuses to start and stay running, try launching the daemon from
the command line:

.. code-block:: console

   # sudo -u glance -H glance-api

This might print the error and cause of the problem.

.. note::

   The ``-H`` flag is required when running the daemons with sudo
   because some daemons will write files relative to the user's home
   directory, and this write may fail if ``-H`` is left off.

.. Tip::

   **Example of Complexity**

   One morning, a compute node failed to run any instances. The log files
   were a bit vague, claiming that a certain instance was unable to be
   started. This ended up being a red herring because the instance was
   simply the first instance in alphabetical order, so it was the first
   instance that ``nova-compute`` would touch.

   Further troubleshooting showed that libvirt was not running at all. This
   made more sense. If libvirt wasn't running, then no instance could be
   virtualized through KVM. Upon trying to start libvirt, it would silently
   die immediately. The libvirt logs did not explain why.

   Next, the ``libvirtd`` daemon was run on the command line. Finally a
   helpful error message: it could not connect to d-bus. As ridiculous as
   it sounds, libvirt, and thus ``nova-compute``, relies on d-bus and
   somehow d-bus crashed. Simply starting d-bus set the entire chain back
   on track, and soon everything was back up and running.
