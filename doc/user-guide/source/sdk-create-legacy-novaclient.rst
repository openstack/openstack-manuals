=============================
Create a Legacy Client Object
=============================

All of the legacy client objects can be constructed the same way - the only
difference is the first argument to ``make_client``. The examples will use
``compute`` to get a nova client, but neutron can be accessed instead by
replacing ``compute`` with ``network``.

To use the legacy ``python-novaclient`` with a Compute endpoint, instantiate a
`novaclient.v2.client.Client
<https://docs.openstack.org/developer/python-novaclient/ref/v2/client.html>`__
object using ``os-client-config``:

.. code-block:: python

   import os_client_config

   nova = os_client_config.make_client(
       'compute',
       auth_url='https://example.com',
       username='example-openstack-user',
       password='example-password',
       project_name='example-project-name',
       region_name='example-region-name')

If you desire a specific micro-version of the Nova API, you can pass that
as the ``version`` parameter:


.. code-block:: python

   import os_client_config

   nova = os_client_config.make_client(
       'compute',
       version='2.10',
       auth_url='https://example.com',
       username='example-openstack-user',
       password='example-password',
       project_name='example-project-name',
       region_name='example-region-name')

If you authenticate against an endpoint that uses a custom
authentication back end, you must provide the name of the plugin in the
``auth_type`` parameter.

For instance, the Rackspace public cloud is an OpenStack deployment that has
an optional custom authentication back end. While normal keystone password
authentication works perfectly well, you may want to use the
custom Rackspace keystoneauth API Key plugin found in
`rackspace-keystoneauth-plugin <https://pypi.python.org/pypi/rackspaceauth>`_.

.. code-block:: python

   nova = os_client_config.make_client(
       'compute',
       auth_type='rackspace_apikey',
       auth_url='https://example.com',
       username='example-openstack-user',
       api_key='example-apikey',
       project_name='example-project-name',
       region_name='example-region-name')
