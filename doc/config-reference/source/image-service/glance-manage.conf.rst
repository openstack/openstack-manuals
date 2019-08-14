==================
glance-manage.conf
==================

Configuration options for the `glance database management tool
<http://docs.openstack.org/developer/glance/man/glancemanage.html>`_
are found in the ``glance-manage.conf`` file.

.. note::

    Options set in ``glance-manage.conf`` will override options of the same
    section and name set in ``glance-registry.conf`` and ``glance-api.conf``.
    Similarly, options in ``glance-api.conf`` will override options set in
    ``glance-registry.conf``.

.. remote-code-block:: ini

   https://opendev.org/openstack/glance/raw/tag/mitaka-eol/etc/glance-manage.conf
