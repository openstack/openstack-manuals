=========================
Compute API configuration
=========================

The Compute API, run by the ``nova-api`` daemon, is the component of
OpenStack Compute that receives and responds to user requests,
whether they be direct API calls, or via the CLI tools or dashboard.

Configure Compute API password handling
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The OpenStack Compute API enables users to specify an administrative
password when they create or rebuild a server instance.
If the user does not specify a password, a random password is
generated and returned in the API response.

In practice, how the admin password is handled depends on the hypervisor
in use and might require additional configuration of the instance.
For example, you might have to install an agent to handle the password
setting. If the hypervisor and instance configuration do not support
setting a password at server create time, the password that is returned
by the create API call is misleading because it was ignored.

To prevent this confusion, use the ``enable_instance_password``
configuration option to disable the return of the admin password
for installations that do not support setting instance passwords.

Configure Compute API rate limiting
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack Compute supports API rate limiting for the OpenStack API.
The rate limiting allows an administrator to configure limits on the
type and number of API calls that can be made in a specific time interval.

When API rate limits are exceeded, HTTP requests return
an error with a status code of ``403 Forbidden``.

Rate limiting is not available for the EC2 API.

Define limits
~~~~~~~~~~~~~

To define limits, set these values:

* The **HTTP method** used in the API call,
  typically one of GET, PUT, POST, or DELETE.
* A **human readable URI** that is used as a friendly
  description of where the limit is applied.
* A **regular expression**. The limit is applied to all
  URIs that match the regular expression and HTTP method.
* A **limit value** that specifies the maximum count of
  units before the limit takes effect.
* An **interval** that specifies time frame to which the limit
  is applied. The interval can be SECOND, MINUTE, HOUR, or DAY.

Rate limits are applied in relative order to the HTTP method,
going from least to most specific.

Default limits
~~~~~~~~~~~~~~

Normally, you install OpenStack Compute with the following limits enabled:

.. list-table:: Default API rate limits
   :header-rows: 1

   * - HTTP method
     - API URI
     - API regular expression
     - Limit
   * - POST
     - any URI (\*)
     - .\*
     - 120 per minute
   * - POST
     - /servers
     - ^/servers
     - 120 per minute
   * - PUT
     - any URI (\*)
     - .\*
     - 120 per minute
   * - GET
     - \*changes-since\*
     - .\*changes-since.\*
     - 120 per minute
   * - DELETE
     - any URI (\*)
     - .\*
     - 120 per minute
   * - GET
     - \*/os-fping
     - ^/os-fping
     - 12 per minute

Configure and change limits
~~~~~~~~~~~~~~~~~~~~~~~~~~~

As part of the WSGI pipeline, the ``etc/nova/api-paste.ini`` file
defines the actual limits.

To enable limits, include the ``ratelimit`` filter in the API pipeline
specification. If the ``ratelimit`` filter is removed from the pipeline,
limiting is disabled. You must also define the rate limit filter.
The lines appear as follows:

.. code-block:: ini

   [pipeline:openstack_compute_api_v2]
   pipeline = faultwrap authtoken keystonecontext ratelimit osapi_compute_app_v2

   [pipeline:openstack_volume_api_v1]
   pipeline = faultwrap authtoken keystonecontext ratelimit osapi_volume_app_v1

   [filter:ratelimit]
   paste.filter_factory = nova.api.openstack.compute.limits:RateLimitingMiddleware.factory

To modify the limits, add a ``limits`` specification to the
``[filter:ratelimit]`` section of the file. Specify the limits in this order:

#. HTTP method
#. friendly URI
#. regex
#. limit
#. interval

The following example shows the default rate-limiting values:

.. code-block:: ini

   [filter:ratelimit]
   paste.filter_factory = nova.api.openstack.compute.limits:RateLimitingMiddleware.factory
   limits =(POST, "*", .*, 120, MINUTE);(POST, "*/servers", ^/servers, 120, MINUTE);(PUT, "*", .*, 120, MINUTE);(GET, "*changes-since*", .*changes-since.*, 120, MINUTE);(DELETE, "*", .*, 120, MINUTE);(GET, "*/os-fping", ^/os-fping, 12, MINUTE)

Configuration options
~~~~~~~~~~~~~~~~~~~~~

The Compute API configuration options are documented in the tables below.

.. include:: ../tables/nova-api.rst
.. include:: ../tables/nova-apiv21.rst
.. include:: ../tables/nova-ca.rst
