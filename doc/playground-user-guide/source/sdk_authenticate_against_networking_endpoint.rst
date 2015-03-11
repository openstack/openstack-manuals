==========================================
Authenticate against a Networking endpoint
==========================================

To authenticate against a Networking endpoint, instantiate a
``neutronclient.v_2_0.client.Client`` object:

.. code:: python

   from os import environ as env
   from neutronclient.v2_0 import client as neutronclient
   neutron = neutronclient.Client(auth_url=env['OS_AUTH_URL'],
                                  username=env['OS_USERNAME'],
                                  password=env['OS_PASSWORD'],
                                  tenant_name=env['OS_TENANT_NAME'],
                                  region_name=env['OS_REGION_NAME'])

You can also authenticate by explicitly specifying the endpoint and
token:

.. code:: python

   from os import environ as env
   import keystoneclient.v2_0.client as ksclient
   from neutronclient.v2_0 import client as neutronclient
   keystone = ksclient.Client(auth_url=env['OS_AUTH_URL'],
                              username=env['OS_USERNAME'],
                              password=env['OS_PASSWORD'],
                              tenant_name=env['OS_TENANT_NAME'],
                              region_name=env['OS_REGION_NAME'])
   endpoint_url = keystone.service_catalog.url_for(service_type='network')
   token = keystone.auth_token
   neutron = neutronclient.Client(endpoint_url=endpoint_url, token=token)
