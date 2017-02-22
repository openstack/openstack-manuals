.. _cross-project:

=============================
Cross-origin resource sharing
=============================

.. note::

   This is a new feature in OpenStack Liberty.

OpenStack supports :term:`Cross-Origin Resource Sharing (CORS)`, a W3C
specification defining a contract by which the single-origin policy of a user
agent (usually a browser) may be relaxed. It permits the javascript engine
to access an API that does not reside on the same domain, protocol, or port.

This feature is most useful to organizations which maintain one or more
custom user interfaces for OpenStack, as it permits those interfaces to access
the services directly, rather than requiring an intermediate proxy server. It
can, however, also be misused by malicious actors; please review the
security advisory below for more information.

Enabling CORS with configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In most cases, CORS support is built directly into the service itself. To
enable it, simply follow the configuration options exposed in the default
configuration file, or add it yourself according to the pattern below.

.. code-block:: ini

   [cors]
   allowed_origin = https://first_ui.example.com
   max_age = 3600
   allow_methods = GET,POST,PUT,DELETE
   allow_headers = Content-Type,Cache-Control,Content-Language,Expires,Last-Modified,Pragma,X-Custom-Header
   expose_headers = Content-Type,Cache-Control,Content-Language,Expires,Last-Modified,Pragma,X-Custom-Header

Additional origins can be explicitly added. To express this in
your configuration file, first begin with a ``[cors]`` group as above,
into which you place your default configuration values. Then, add as many
additional configuration groups as necessary, naming them
``[cors.{something}]`` (each name must be unique). The purpose of the
suffix to ``cors.`` is legibility, we recommend using a reasonable
human-readable string:

.. code-block:: ini

   [cors.ironic_webclient]
   # CORS Configuration for a hypothetical ironic webclient, which overrides
   # authentication
   allowed_origin = https://ironic.example.com:443
   allow_credentials = True

   [cors.horizon]
   # CORS Configuration for horizon, which uses global options.
   allowed_origin = https://horizon.example.com:443

   [cors.wildcard]
   # CORS Configuration for the CORS specified domain wildcard, which only
   # permits HTTP GET requests.
   allowed_origin = *
   allow_methods = GET

For more information about CORS configuration,
see `cross-origin resource sharing
<https://docs.openstack.org/ocata/config-reference/common-configurations/cors.html>`_
in OpenStack Configuration Reference.

Enabling CORS with PasteDeploy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CORS can also be configured using PasteDeploy. First of all, ensure that
OpenStack's ``oslo_middleware`` package (version 2.4.0 or later) is
available in the Python environment that is running the service. Then,
add the following configuration block to your ``paste.ini`` file.

.. code-block:: ini

   [filter:cors]
   paste.filter_factory = oslo_middleware.cors:filter_factory
   allowed_origin = https://website.example.com:443
   max_age = 3600
   allow_methods = GET,POST,PUT,DELETE
   allow_headers = Content-Type,Cache-Control,Content-Language,Expires,Last-Modified,Pragma,X-Custom-Header
   expose_headers = Content-Type,Cache-Control,Content-Language,Expires,Last-Modified,Pragma,X-Custom-Header

.. note::
   To add an additional domain in oslo_middleware v2.4.0, add
   another filter. In v3.0.0 and after, you may add multiple domains
   in the above ``allowed_origin`` field, separated by commas.

Security concerns
~~~~~~~~~~~~~~~~~

CORS specifies a wildcard character ``*``, which permits access to all user
agents, regardless of domain, protocol, or host. While there are valid use
cases for this approach, it also permits a malicious actor to create a
convincing facsimile of a user interface, and trick users into revealing
authentication credentials. Please carefully evaluate your use case and the
relevant documentation for any risk to your organization.

.. note::

   The CORS specification does not support using this wildcard as
   a part of a URI. Setting ``allowed_origin`` to ``*`` would work, while
   ``*.openstack.org`` would not.

Troubleshooting
~~~~~~~~~~~~~~~

CORS is very easy to get wrong, as even one incorrect property will violate
the prescribed contract. Here are some steps you can take to troubleshoot
your configuration.

Check the service log
---------------------

The CORS middleware used by OpenStack provides verbose debug logging that
should reveal most configuration problems. Here are some example log
messages, and how to resolve them.

Problem
-------

``CORS request from origin 'http://example.com' not permitted.``

Solution
--------

A request was received from the origin ``http://example.com``, however this
origin was not found in the permitted list. The cause may be a superfluous
port notation (ports 80 and 443 do not need to be specified). To correct,
ensure that the configuration property for this host is identical to the
host indicated in the log message.

Problem
-------

``Request method 'DELETE' not in permitted list: GET,PUT,POST``

Solution
--------

A user agent has requested permission to perform a DELETE request, however
the CORS configuration for the domain does not permit this. To correct, add
this method to the ``allow_methods`` configuration property.

Problem
-------

``Request header 'X-Custom-Header' not in permitted list: X-Other-Header``

Solution
--------

A request was received with the header ``X-Custom-Header``, which is not
permitted. Add this header to the ``allow_headers`` configuration
property.

Open your browser's console log
-------------------------------

Most browsers provide helpful debug output when a CORS request is rejected.
Usually this happens when a request was successful, but the return headers on
the response do not permit access to a property which the browser is trying
to access.

Manually construct a CORS request
---------------------------------

By using ``curl`` or a similar tool, you can trigger a CORS response with a
properly constructed HTTP request. An example request and response might look
like this.

Request example:

.. code-block:: console

   $ curl -I -X OPTIONS https://api.example.com/api -H "Origin: https://ui.example.com"

Response example:

.. code-block:: console

   HTTP/1.1 204 No Content
   Content-Length: 0
   Access-Control-Allow-Origin: https://ui.example.com
   Access-Control-Allow-Methods: GET,POST,PUT,DELETE
   Access-Control-Expose-Headers: origin,authorization,accept,x-total,x-limit,x-marker,x-client,content-type
   Access-Control-Allow-Headers: origin,authorization,accept,x-total,x-limit,x-marker,x-client,content-type
   Access-Control-Max-Age: 3600

If the service does not return any access control headers, check the service
log, such as ``/var/log/upstart/ironic-api.log`` for an indication on what
went wrong.
