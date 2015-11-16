Object storage nodes (Optional)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you want to deploy the Object Storage service, configure two
additional storage nodes.

First node
----------

Configure network interfaces
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* Configure the management interface:

  * IP address: ``10.0.0.51``

  * Network mask: ``255.255.255.0`` (or ``/24``)

  * Default gateway: ``10.0.0.1``

Configure name resolution
^^^^^^^^^^^^^^^^^^^^^^^^^

#. Set the hostname of the node to ``object1``.

#. .. include:: shared/edit_hosts_file.txt

#. Reboot the system to activate the changes.

Second node
-----------

Configure network interfaces
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* Configure the management interface:

  * IP address: ``10.0.0.52``

  * Network mask: ``255.255.255.0`` (or ``/24``)

  * Default gateway: ``10.0.0.1``

Configure name resolution
^^^^^^^^^^^^^^^^^^^^^^^^^

#. Set the hostname of the node to ``object2``.

#. .. include:: shared/edit_hosts_file.txt

#. Reboot the system to activate the changes.
