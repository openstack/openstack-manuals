Object storage nodes (Optional)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you want to deploy the Object Storage service, configure two
additional storage nodes.

First node
----------

Configure network interfaces
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Configure the management interface:

   * IP address: ``10.0.0.51``

   * Network mask: ``255.255.255.0`` (or ``/24``)

   * Default gateway: ``10.0.0.1``

Configure name resolution
^^^^^^^^^^^^^^^^^^^^^^^^^

#. Set the hostname of the node to ``object1``.

#. Edit the ``/etc/hosts`` file to contain the following:

   .. code-block:: ini

      # controller
      10.0.0.11       controller

      # compute1
      10.0.0.31       compute1

      # block1
      10.0.0.41       block1

      # object1
      10.0.0.51       object1

      # object2
      10.0.0.52       object2

   .. warning::

      Some distributions add an extraneous entry in the ``/etc/hosts``
      file that resolves the actual hostname to another loopback IP
      address such as ``127.0.1.1``. You must comment out or remove this
      entry to prevent name resolution problems. **Do not remove the
      127.0.0.1 entry.**

#. Reboot the system to activate the changes.

Second node
-----------

Configure network interfaces
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Configure the management interface:

   * IP address: ``10.0.0.52``

   * Network mask: ``255.255.255.0`` (or ``/24``)

   * Default gateway: ``10.0.0.1``

Configure name resolution
^^^^^^^^^^^^^^^^^^^^^^^^^

#. Set the hostname of the node to ``object2``.

#. Edit the ``/etc/hosts`` file to contain the following:

   .. code-block:: ini

      # controller
      10.0.0.11       controller

      # compute1
      10.0.0.31       compute1

      # block1
      10.0.0.41       block1

      # object1
      10.0.0.51       object1

      # object2
      10.0.0.52       object2

   .. warning::

      Some distributions add an extraneous entry in the ``/etc/hosts``
      file that resolves the actual hostname to another loopback IP
      address such as ``127.0.1.1``. You must comment out or remove this
      entry to prevent name resolution problems. **Do not remove the
      127.0.0.1 entry.**

#. Reboot the system to activate the changes.
