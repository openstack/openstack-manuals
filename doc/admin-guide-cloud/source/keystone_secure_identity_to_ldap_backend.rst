Secure the OpenStack Identity service connection to an LDAP back end
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Identity service supports the use of TLS to encrypt LDAP traffic.
Before configuring this, you must first verify where your certificate
authority file is located. For more information, see ?.

.. TODO (DC) figure out how to reference
   keystone_integrate_identity_with_ldap.rst with orphan tag

Once you verify the location of your certificate authority file:

**Configuring TLS encryption on LDAP traffic**

#. Open the :file:`/etc/keystone/keystone.conf` configuration file.

#. Find the ``[ldap]`` section.

#. In the ``[ldap]`` section, set the ``use_tls`` configuration key to
   ``True``. Doing so will enable TLS.

#. Configure the Identity service to use your certificate authorities file.
   To do so, set the ``tls_cacertfile`` configuration key in the ``ldap``
   section to the certificate authorities file's path.

   .. note::

      You can also set the ``tls_cacertdir`` (also in the ``ldap``
      section) to the directory where all certificate authorities files
      are kept. If both ``tls_cacertfile`` and ``tls_cacertdir`` are set,
      then the latter will be ignored.

#. Specify what client certificate checks to perform on incoming TLS
   sessions from the LDAP server. To do so, set the ``tls_req_cert``
   configuration key in the ``[ldap]`` section to ``demand``, ``allow``, or
   ``never``:

   - ``demand``
        A certificate will always be requested from the LDAP
        server. The session will be terminated if no certificate is provided,
        or if the certificate provided cannot be verified against the
        existing certificate authorities file.

   - ``allow``
        A certificate will always be requested from the LDAP
        server. The session will proceed as normal even if a certificate is
        not provided. If a certificate is provided but it cannot be verified
        against the existing certificate authorities file, the certificate
        will be ignored and the session will proceed as normal.

   -  ``never``
         A certificate will never be requested.

On distributions that include openstack-config, you can configure TLS
encryption on LDAP traffic by running the following commands instead::

   # openstack-config --set /etc/keystone/keystone.conf \
     ldap use_tls True
   # openstack-config --set /etc/keystone/keystone.conf \
     ldap tls_cacertfile ``CA_FILE``
   # openstack-config --set /etc/keystone/keystone.conf \
     ldap tls_req_cert ``CERT_BEHAVIOR``

Where:

- ``CA_FILE`` is the absolute path to the certificate authorities file
  that should be used to encrypt LDAP traffic.

- ``CERT_BEHAVIOR`` specifies what client certificate checks to perform
  on an incoming TLS session from the LDAP server (``demand``,
  ``allow``, or ``never``).
