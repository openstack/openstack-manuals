========================
Keystone token providers
========================

Tokens are used to interact with the various OpenStack APIs. The token type
issued by keystone is configurable through the :file:`etc/keystone.conf` file.
Currently, there are four supported token types and they include UUID, fernet,
PKI, and PKIZ.

UUID tokens
~~~~~~~~~~~

UUID was the first token type supported and is currently the default token
provider. UUID tokens are 32 bytes in length and must be persisted in a back
end. Clients must pass their UUID token to the Identity service in order to
validate it.

Fernet tokens
~~~~~~~~~~~~~

The fernet token format was introduced in the OpenStack Kilo release. Unlike
the other token types mentioned in this document, fernet tokens do not need to
be persisted in a back end. ``AES256`` encryption is used to protect the
information stored in the token and integrity is verified with a ``SHA256
HMAC`` signature. Only the Identity service should have access to the keys used
to encrypt and decrypt fernet tokens. Like UUID tokens, fernet tokens must be
passed back to the Identity service in order to validate them. For more
information on the fernet token type, see the :ref:`keystone_fernet_token_faq`.

PKI and PKIZ tokens
~~~~~~~~~~~~~~~~~~~

PKI tokens are signed documents that contain the authentication context, as
well as the service catalog. Depending on the size of the OpenStack deployment,
these tokens can be very long. The Identity service uses public/private key
pairs and certificates in order to create and validate PKI tokens.

The same concepts from PKI tokens apply to PKIZ tokens. The only difference
between the two is PKIZ tokens are compressed to help mitigate the size issues
of PKI. For more information on the certificate setup for PKI and PKIZ tokens,
see the :ref:`keystone_certificates_for_pki`.
