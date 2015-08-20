Authentication middleware with user name and password
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can also configure Identity authentication middleware using the
:code:`admin_user` and :code:`admin_password` options.

.. note::

    The :code:`admin_token` option is deprecated and no longer used for
    configuring auth_token middleware.

For services that have a separate paste-deploy :file:`.ini` file, you can
configure the authentication middleware in the ``[keystone_authtoken]``
section of the main configuration file, such as :file:`nova.conf`. In
Compute, for example, you can remove the middleware parameters from
:file:`api-paste.ini`, as follows:

.. code:: ini

    [filter:authtoken]
    paste.filter_factory = keystonemiddleware.auth_token:filter_factory


And set the following values in :file:`nova.conf` as follows:

.. code:: ini

    [DEFAULT]
    ...
    auth_strategy=keystone

    [keystone_authtoken]
    auth_uri = http://controller:5000/v2.0
    identity_uri = http://controller:35357
    admin_user = admin
    admin_password = SuperSekretPassword
    admin_tenant_name = service

.. note::

    The middleware parameters in the paste config take priority. You
    must remove them to use the values in the ``[keystone_authtoken]``
    section.

.. note::

    Comment out any :code:`auth_host`, :code:`auth_port`, and
    :code:`auth_protocol` options because the :code:`identity_uri` option
    replaces them.

This sample paste config filter makes use of the :code:`admin_user` and
:code:`admin_password` options:

.. code:: ini

    [filter:authtoken]
    paste.filter_factory = keystonemiddleware.auth_token:filter_factory
    auth_uri = http://controller:5000/v2.0
    identity_uri = http://controller:35357
    auth_token = 012345SECRET99TOKEN012345
    admin_user = admin
    admin_password = keystone123

.. note::

    Using this option requires an admin tenant/role relationship. The
    admin user is granted access to the admin role on the admin tenant.

.. note::

    Comment out any ``auth_host``, ``auth_port``, and
    ``auth_protocol`` options because the ``identity_uri`` option
    replaces them.

