============================
Authentication With keystone
============================

Glance may optionally be integrated with the Identity service (keystone).
When setting this up remember the keystone distribution
includes the necessary middleware. Once you have installed keystone
and edited your configuration files, newly created images will have
their ``owner`` attribute set to the tenant of the authenticated users,
and the ``is_public`` attribute will cause access to those images for
which it is ``false`` to be restricted to only the owner, users with
admin context, or tenants and users with whom the image has been shared.


Configuring the glance servers to use keystone
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Keystone is integrated with glance through the use of middleware. The
default configuration files for both the glance API and the glance
registry use a single piece of middleware called ``unauthenticated-context``.
This generates a request context containing blank authentication
information. In order to configure glance to use keystone, the
``authtoken`` and ``context`` middlewares must be deployed in place of the
``unauthenticated-context`` middleware. The ``authtoken`` middleware performs
the authentication token validation and retrieves actual user authentication
information. This can be found in the keystone distribution.

Configuring the glance API to use keystone
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To configure the glance API to use keystone, ensure that declarations
for the two pieces of middleware exist in the ``glance-api-paste.ini``.
For example:

.. code-block:: console

   [filter:authtoken]
   paste.filter_factory = keystonemiddleware.auth_token:filter_factory
   auth_url = http://localhost:35357
   project_domain_id = default
   project_name = service_admins
   user_domain_id = default
   username = glance_admin
   password = password1234

The values for these variables will need to be set depending on
your situation. For more information, please refer to the
`keystone documentation <https://docs.openstack.org/developer/keystonemiddleware/middlewarearchitecture.html#configuration>`_
on the ``auth_token`` middleware.

* The ``auth_url`` variable points to the keystone service.
  This information is used by the middleware to query keystone about
  the validity of the authentication tokens.
* Use the auth credentials (``project_name``, ``project_domain_id``,
  ``user_domain_id``, ``username``, and ``password``) to
  retrieve a service token. That token will be used to authorize user
  tokens behind the scenes.

To enable using keystone authentication, the
application pipeline must be modified. By default, it looks like:

.. code-block:: console

   [pipeline:glance-api]
   pipeline = versionnegotiation unauthenticated-context apiv1app

Your particular pipeline may vary depending on other options, such as
the image cache. This must be changed by replacing ``unauthenticated-context``
with ``authtoken`` and ``context``:

.. code-block:: console

   [pipeline:glance-api]
   pipeline = versionnegotiation authtoken context apiv1app


Configuring the glance registry to use keystone
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To configure the glance registry to use keystone, the same middleware
needs to be added to ``glance-registry-paste.ini`` as was needed by
glance API. See above for an example of the ``authtoken``
configuration.

To enable using keystone authentication, the appropriate
application pipeline must be selected. By default, it looks like:

.. code-block:: console

   [pipeline:glance-registry-keystone]
   pipeline = authtoken context registryapp

To enable the above application pipeline, in your main ``glance-registry.conf``
configuration file, select the appropriate deployment flavor by adding a
``flavor`` attribute in the ``paste_deploy`` group:

.. code-block:: console

   [paste_deploy]
   flavor = keystone

.. note::

   If your authentication service uses a role other than ``admin`` to identify
   which users should be granted admin-level privileges, you must define it
   in the ``admin_role`` config attribute in both ``glance-registry.conf`` and
   ``glance-api.conf``.
