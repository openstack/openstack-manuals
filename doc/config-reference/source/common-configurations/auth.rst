================================
Authentication and authorization
================================

All requests to the API may only be performed by an authenticated agent.

The preferred authentication system is Identity service.

Identity service authentication
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To authenticate, an agent issues an authentication request to an Identity
service endpoint. In response to valid credentials, Identity service responds
with an authentication token and a service catalog that contains a list of
all services and endpoints available for the given token.

Multiple endpoints may be returned for each OpenStack service according to
physical locations and performance/availability characteristics of different
deployments.

Normally, Identity service middleware provides the ``X-Project-Id`` header
based on the authentication token submitted by the service client.

For this to work, clients must specify a valid authentication token in the
``X-Auth-Token`` header for each request to each OpenStack service API.
The API validates authentication tokens against Identity service before
servicing each request.

No authentication
~~~~~~~~~~~~~~~~~

If authentication is not enabled, clients must provide the ``X-Project-Id``
header themselves.

Options
~~~~~~~

Configure the authentication and authorization strategy through these options:

.. include:: ../tables/common-auth.rst
.. include:: ../tables/common-auth_token.rst
