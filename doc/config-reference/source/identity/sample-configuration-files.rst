===========================================
Identity service sample configuration files
===========================================

You can find the files described in this section in the ``/etc/keystone``
directory.

keystone.conf
~~~~~~~~~~~~~

Use the ``keystone.conf`` file to configure most Identity service
options:

.. remote-code-block:: ini

   https://opendev.org/openstack/keystone/raw/tag/mitaka-eol/etc/keystone.conf.sample

keystone-paste.ini
~~~~~~~~~~~~~~~~~~

Use the ``keystone-paste.ini`` file to configure the Web Service Gateway
Interface (WSGI) middleware pipeline for the Identity service:

.. remote-code-block:: ini

   https://opendev.org/openstack/keystone/raw/tag/mitaka-eol/etc/keystone-paste.ini

logging.conf
~~~~~~~~~~~~

You can specify a special logging configuration file in the ``keystone.conf``
configuration file. For example, ``/etc/keystone/logging.conf``.

For details, see the `Python logging module documentation
<http://docs.python.org/2/howto/logging.html#configuring-logging>`__.

.. remote-code-block:: ini

   https://opendev.org/openstack/keystone/raw/tag/mitaka-eol/etc/logging.conf.sample

policy.json
~~~~~~~~~~~

Use the ``policy.json`` file to define additional access controls that apply to
the Identity service:

.. remote-code-block:: json

   https://opendev.org/openstack/keystone/raw/tag/mitaka-eol/etc/policy.json
