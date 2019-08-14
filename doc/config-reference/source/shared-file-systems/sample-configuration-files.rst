==============================================
Shared File Systems sample configuration files
==============================================

All the files in this section can be found in ``/etc/manila``.

manila.conf
-----------

The ``manila.conf`` file is installed in ``/etc/manila`` by default.
When you manually install the Shared File Systems service, the options
in the ``manila.conf`` file are set to default values.

The ``manila.conf`` file contains most of the options to configure the
Shared File Systems service.

.. literalinclude:: ../samples/manila.conf.sample
   :language: ini

api-paste.ini
-------------

Use the ``api-paste.ini`` file to configure the Shared File Systems API
service.

.. remote-code-block:: ini

   https://opendev.org/openstack/manila/raw/tag/mitaka-eol/etc/manila/api-paste.ini

policy.json
-----------

The ``policy.json`` file defines additional access controls that apply
to the Shared File Systems service.

.. remote-code-block:: json

   https://opendev.org/openstack/manila/raw/tag/mitaka-eol/etc/manila/policy.json

rootwrap.conf
-------------

The ``rootwrap.conf`` file defines configuration values used by the
``rootwrap`` script when the Shared File Systems service must escalate
its privileges to those of the root user.

.. remote-code-block:: ini

   https://opendev.org/openstack/manila/raw/tag/mitaka-eol/etc/manila/rootwrap.conf
