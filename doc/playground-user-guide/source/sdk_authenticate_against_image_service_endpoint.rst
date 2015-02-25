==============================================
Authenticate against an Image Service endpoint
==============================================

To authenticate against an Image Service endpoint, instantiate a
`glanceclient.v2.client.Client <http://docs.openstack.org/developer/python-glanceclient/api/glanceclient.v2.client.html#glanceclient.v2.client.Client>`__ object:

.. code:: python

   from os import environ as env
   import glanceclient.v2.client as glclient
   import keystoneclient.v2_0.client as ksclient

   keystone = ksclient.Client(auth_url=env['OS_AUTH_URL'],
                              username=env['OS_USERNAME'],
                              password=env['OS_PASSWORD'],
                              tenant_name=env['OS_TENANT_NAME'],
                              region_name=env['OS_REGION_NAME'])
   glance_endpoint = keystone.service_catalog.url_for(service_type='image')
   glance = glclient.Client(glance_endpoint, token=keystone.auth_token)
