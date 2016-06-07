=======================================
Configure the Identity service with SSL
=======================================

You can configure the Identity service to support two-way SSL.

You must obtain the x509 certificates externally and configure them.

The Identity service provides a set of sample certificates in the
``examples/pki/certs`` and ``examples/pki/private`` directories:

cacert.pem
   Certificate Authority chain to validate against.

ssl\_cert.pem
    Public certificate for Identity service server.

middleware.pem
   Public and private certificate for Identity service
   middleware/client.

cakey.pem
   Private key for the CA.

ssl\_key.pem
   Private key for the Identity service server.

.. note::

   You can choose names for these certificates. You can also combine
   public/private keys in the same file, if you wish. These certificates are
   provided as an example.

Client authentication with keystone-all
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. note::

   When running the Identity service as a WSGI service in a web server
   such as Apache HTTP Server, this configuration is done in the web server
   instead. In this case, the options in the ``[eventlet_server_ssl]``
   section are ignored.

   The eventlet support will be removed in Newton.

When running ``keystone-all``, the server can be configured to enable SSL
with client authentication using the following instructions. Modify the
``[eventlet_server_ssl]`` section in the ``/etc/keystone/keystone.conf``
file. The following SSL configuration example uses the included sample
certificates:

.. code-block:: ini

   [eventlet_server_ssl]
   enable = True
   certfile = <path to keystone.pem>
   keyfile = <path to keystonekey.pem>
   ca_certs = <path to ca.pem>
   cert_required = True

**Options**

- ``enable``
    ``True`` enables SSL. Default is ``False``.

- ``certfile``
    Path to the Identity service public certificate file.

- ``keyfile``
    Path to the Identity service private certificate file.
    If you include the private key in the certfile, you can omit the
    keyfile.

-  ``ca_certs``
    Path to the CA trust chain.

-  ``cert_required``
    Requires client certificate. Default is ``False``.
