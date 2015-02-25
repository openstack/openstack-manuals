=========================================
Authenticate against an Identity endpoint
=========================================

To authenticate against the Identity v2.0 endpoint, instantiate a
`keystoneclient.v\_20.client.Client <http://docs.openstack.org/developer/python-keystoneclient/api/keystoneclient.v2_0.client.html#keystoneclient.v2_0.client.Client>`__ object:

.. code:: python

   from os import environ as env
   import keystoneclient.v2_0.client as ksclient
   keystone = ksclient.Client(auth_url=env['OS_AUTH_URL'],
                              username=env['OS_USERNAME'],
                              password=env['OS_PASSWORD'],
                              tenant_name=env['OS_TENANT_NAME'],
                              region_name=env['OS_REGION_NAME'])

After you instantiate a ``Client`` object, you can retrieve the token by
accessing its ``auth_token`` attribute object:

.. code:: python

   import keystoneclient.v2_0.client as ksclient
   keystone = ksclient.Client(...)
   print keystone.auth_token

If the OpenStack cloud is configured to use public-key infrastructure
(PKI) tokens, the Python script output looks something like this:

.. code::

   MIIQUQYJKoZIhvcNAQcCoIIQQjCCED4CAQExCTAHBgUrDgMCGjCCDqcGCSqGSIb3DQEHAaCCDpgE
   gg6UeyJhY2Nlc3MiOiB7InRva2VuIjogeyJpc3N1ZWRfYXQiOiAiMjAxMy0xMC0yMFQxNjo1NjoyNi
   4zNTg2MjUiLCAiZXhwaXJlcyI6ICIyMDEzLTEwLTIxVDE2OjU2OjI2WiIsICJpZCI6ICJwbGFjZWhv
   ...
   R3g14FJ0BxtTPbo6WarZ+sA3PZwdgIDyGNI-0Oqv-8ih4gJC9C6wBCel1dUXJ0Mn7BN-SfuxkooVk6
   e090bcKjTWet3CC8IEj7a6LyLRVTdvmKGA5-pgp2mS5fb3G2mIad4Zeeb-zQn9V3Xf9WUGxuiVu1Hn
   fhuUpJT-s9mU7+WEC3-8qkcBjEpqVCvMpmM4INI=

.. note::
   This example shows a subset of a PKI token. A complete token is over
   5000 characters long.
