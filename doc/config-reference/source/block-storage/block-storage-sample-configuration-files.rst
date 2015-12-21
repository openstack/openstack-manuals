.. _block-storage-sample-configuration-file:

========================================
Block Storage sample configuration files
========================================

All the files in this section can be found in ``/etc/cinder``.

cinder.conf
~~~~~~~~~~~

The ``cinder.conf`` file is installed in ``/etc/cinder`` by default.
When you manually install the Block Storage service, the options in the
``cinder.conf`` file are set to default values.

The ``cinder.conf`` file contains most of the options to configure the
Block Storage service.

.. literalinclude:: ../../../common/samples/cinder.conf.sample
   :language: ini

api-paste.ini
~~~~~~~~~~~~~

Use the ``api-paste.ini`` file to configure the Block Storage API
service.

.. remote-code-block:: ini

   https://git.openstack.org/cgit/openstack/cinder/plain/etc/cinder/api-paste.ini?h=stable/liberty

policy.json
~~~~~~~~~~~

The ``policy.json`` file defines additional access controls that apply
to the Block Storage service.

.. remote-code-block:: ini

   https://git.openstack.org/cgit/openstack/cinder/plain/etc/cinder/policy.json?h=stable/liberty

rootwrap.conf
~~~~~~~~~~~~~

The ``rootwrap.conf`` file defines configuration values used by the
``rootwrap`` script when the Block Storage service must escalate its
privileges to those of the root user.

.. remote-code-block:: ini

   https://git.openstack.org/cgit/openstack/cinder/plain/etc/cinder/rootwrap.conf?h=stable/liberty
