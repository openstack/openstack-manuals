.. _section-compute-security:

==================
Security hardening
==================

OpenStack Compute can be integrated with various third-party
technologies to increase security. For more information, see the
`OpenStack Security Guide <http://docs.openstack.org/sec/>`_.

.. :ref:section_trusted-compute-pools.rst

Encrypt Compute metadata traffic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Enabling SSL encryption**

OpenStack supports encrypting Compute metadata traffic with HTTPS.
Enable SSL encryption in the :file:`metadata_agent.ini` file.

#. Enable the HTTPS protocol::

    nova_metadata_protocol = https

#. Determine whether insecure SSL connections are accepted for Compute
   metadata server requests. The default value is ``False``::

    nova_metadata_insecure = False

#. Specify the path to the client certificate::

    nova_client_cert = PATH_TO_CERT

#. Specify the path to the private key::

    nova_client_priv_key = PATH_TO_KEY
