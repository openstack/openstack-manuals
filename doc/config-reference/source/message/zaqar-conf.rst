======================
Overview of zaqar.conf
======================

The ``zaqar.conf`` configuration file is an
`INI file format <https://en.wikipedia.org/wiki/INI_file>`_
as explained in :doc:`../config-format`.

This file is located in ``/etc/zaqar``. If there is a file ``zaqar.conf`` in
``~/.zaqar`` directory, it is used instead of the one in ``/etc/zaqar``
directory. When you manually install the Message service, you must generate
the zaqar.conf file using the config samples generator located inside Zaqar
installation directory and customize it according to your preferences.

To generate the sample configuration file ``zaqar/etc/zaqar.conf.sample``:

.. code-block:: console

   # pip install tox
   $ cd zaqar
   $ tox -e genconfig

Where :samp:`{zaqar}` is your Message service installation directory.

Then copy Message service configuration sample to the directory ``/etc/zaqar``:

.. code-block:: console

   # cp etc/zaqar.conf.sample /etc/zaqar/zaqar.conf

For a list of configuration options, see the tables in this guide.

.. important::

   Do not specify quotes around configuration options.

Sections
~~~~~~~~

Configuration options are grouped by section. Message service configuration
file supports the following sections:

[DEFAULT]
 Contains most configuration options. If the documentation for a configuration
 option does not specify its section, assume that it appears in this section.

[cache]
 Configures caching.

[drivers]
 Select drivers.

[transport]
 Configures general transport options.

[drivers:transport:wsgi]
 Configures the WSGI transport driver.

[drivers:transport:websocket]
 Configures the Websocket transport driver.

[storage]
 Configures general storage options.

[drivers:management_store:mongodb]
 Configures the MongoDB management storage driver.

[drivers:message_store:mongodb]
 Configures the MongoDB message storage driver.

[drivers:management_store:redis]
 Configures the Redis management storage driver.

[drivers:message_store:redis]
 Configures the Redis message storage driver.

[drivers:management_store:sqlalchemy]
 Configures the SQLalchemy management storage driver.

[keystone_authtoken]
 Configures the Identity service endpoint.

[oslo_policy]
 Configures the RBAC policy.

[pooling:catalog]
 Configures the pooling catalog.

[signed_url]
 Configures signed URLs.
