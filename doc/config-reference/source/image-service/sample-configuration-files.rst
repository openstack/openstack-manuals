========================================
Image service sample configuration files
========================================

You can find the files that are described in this section in the
``/etc/glance/`` directory.

glance-api.conf
~~~~~~~~~~~~~~~

The configuration file for the Image service API is found in the
``glance-api.conf`` file.

This file must be modified after installation.

.. remote-code-block:: ini

   https://git.openstack.org/cgit/openstack/glance/plain/etc/glance-api.conf?h=stable/liberty

glance-registry.conf
~~~~~~~~~~~~~~~~~~~~

Configuration for the Image service's registry, which stores the metadata about
images, is found in the ``glance-registry.conf`` file.

This file must be modified after installation.

.. remote-code-block:: ini

   https://git.openstack.org/cgit/openstack/glance/plain/etc/glance-registry.conf?h=stable/liberty

glance-api-paste.ini
~~~~~~~~~~~~~~~~~~~~

Configuration for the Image service's API middleware pipeline is found in the
``glance-api-paste.ini`` file.

You should not need to modify this file.

.. remote-code-block:: ini

   https://git.openstack.org/cgit/openstack/glance/plain/etc/glance-api-paste.ini?h=stable/liberty

glance-manage.conf
~~~~~~~~~~~~~~~~~~

The Image service's custom logging options are found in the
``glance-manage.conf`` file.

.. note::

    Options set in ``glance-manage.conf`` will override options of the same
    section and name set in ``glance-registry.conf`` and ``glance-api.conf``.
    Similarly, options in ``glance-api.conf`` will override options set in
    ``glance-registry.conf``.

.. remote-code-block:: ini

   https://git.openstack.org/cgit/openstack/glance/plain/etc/glance-manage.conf?h=stable/liberty

glance-registry-paste.ini
~~~~~~~~~~~~~~~~~~~~~~~~~

The Image service's middleware pipeline for its registry is found in the
``glance-registry-paste.ini`` file.

.. remote-code-block:: ini

   https://git.openstack.org/cgit/openstack/glance/plain/etc/glance-registry-paste.ini?h=stable/liberty

glance-scrubber.conf
~~~~~~~~~~~~~~~~~~~~

``glance-scrubber`` is a utility for the Image service that cleans up images
that have been deleted; its configuration is stored in the
``glance-scrubber.conf`` file.

.. remote-code-block:: ini

   https://git.openstack.org/cgit/openstack/glance/plain/etc/glance-scrubber.conf?h=stable/liberty

policy.json
~~~~~~~~~~~

The ``/etc/glance/policy.json`` file defines additional access controls that
apply to the Image service.

.. remote-code-block:: json

   https://git.openstack.org/cgit/openstack/glance/plain/etc/policy.json?h=stable/liberty
