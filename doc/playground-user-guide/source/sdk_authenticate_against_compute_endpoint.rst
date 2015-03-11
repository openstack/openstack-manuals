=======================================
Authenticate against a Compute endpoint
=======================================

To authenticate against a Compute endpoint, instantiate a
`novaclient.v\_1\_1.client.Client <http://docs.openstack.org/developer/python-novaclient/api/novaclient.v1_1.client.html#novaclient.v1_1.client.Client>`__ object:

.. code:: python

   from os import environ as env
   import novaclient.v1_1.client as nvclient
   nova = nvclient.Client(auth_url=env['OS_AUTH_URL'],
                          username=env['OS_USERNAME'],
                          api_key=env['OS_PASSWORD'],
                          project_id=env['OS_TENANT_NAME'],
                          region_name=env['OS_REGION_NAME'])

Alternatively, you can instantiate a ``novaclient.client.Client`` object
and pass the version number:

.. code:: python

   from os import environ as env
   import novaclient
   nova = novaclient.client.Client("1.1", auth_url=env['OS_AUTH_URL'],
                                   username=env['OS_USERNAME'],
                                   api_key=env['OS_PASSWORD'],
                                   project_id=env['OS_TENANT_NAME'],
                                   region_name=env['OS_REGION_NAME'])

If you authenticate against an endpoint that uses a custom
authentication back end, you must load the authentication plug-in and
pass it to the constructor.

The Rackspace public cloud is an OpenStack deployment that uses a custom
authentication back end. To authenticate against this cloud, you must
install the
`rackspace-novaclient <https://pypi.python.org/pypi/rackspace-novaclient/>`__
library that contains the Rackspace authentication plug-in, called
``rackspace``. The following Python code shows the additional
modifications required to instantiate a ``Client`` object that can
authenticate against the Rackspace custom authentication back end.

.. code:: python

   import novaclient.auth_plugin
   import novaclient.v1_1.client as nvclient
   from os import environ as env
   auth_system = 'rackspace'
   auth_plugin = novaclient.auth_plugin.load_plugin('rackspace')
   nova = nvclient.Client(auth_url=env['OS_AUTH_URL'],
                          username=env['OS_USERNAME'],
                          api_key=env['OS_PASSWORD'],
                          project_id=env['OS_TENANT_NAME'],
                          region_name=env['OS_REGION_NAME'],
                          auth_system='rackspace',
                          auth_plugin=auth_plugin)

If you set the ``OS_AUTH_SYSTEM`` environment variable, check for this
variable in your Python script to determine whether you need to load a
custom authentication back end:

.. code:: python

   import novaclient.auth_plugin
   import novaclient.v1_1.client as nvclient
   from os import environ as env
   auth_system = env.get('OS_AUTH_SYSTEM', 'keystone')
   if auth_system != "keystone":
     auth_plugin = novaclient.auth_plugin.load_plugin(auth_system)
   else:
     auth_plugin = None
   nova = nvclient.Client(auth_url=env['OS_AUTH_URL'],
                          username=env['OS_USERNAME'],
                          api_key=env['OS_PASSWORD'],
                          project_id=env['OS_TENANT_NAME'],
                          region_name=env['OS_REGION_NAME'],
                          auth_system=auth_system,
                          auth_plugin=auth_plugin)
