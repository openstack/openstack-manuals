.. :orphan:

Caching layer
~~~~~~~~~~~~~

OpenStack Identity supports a caching layer that is above the
configurable subsystems (for example, token, assignment). OpenStack
Identity uses the
`dogpile.cache <http://dogpilecache.readthedocs.org/en/latest/>`__
library which allows flexible cache back ends. The majority of the
caching configuration options are set in the ``[cache]`` section of the
``keystone.conf`` file. However, each section that has the capability to
be cached usually has a caching boolean value that toggles caching.

So to enable only the token back end caching, set the values as follows:

.. code-block:: ini

   [cache]
   enabled=true

   [assignment]
   caching=false

   [token]
   caching=true

.. note::

   Since the Juno release, the default setting is enabled for subsystem
   caching, but the global toggle is disabled. As a result, no caching
   in available unless the global toggle for ``[cache]`` is enabled by
   setting the value to ``true``.

Caching for tokens and tokens validation
----------------------------------------

The token system has a separate ``cache_time`` configuration option,
that can be set to a value above or below the global ``expiration_time``
default, allowing for different caching behavior from the other systems
in OpenStack Identity. This option is set in the ``[token]`` section of
the configuration file. Fernet tokens do not need to be persisted in a
back end and therefore must not be cached.

The token revocation list cache time is handled by the configuration
option ``revocation_cache_time`` in the ``[token]`` section. The
revocation list is refreshed whenever a token is revoked. It typically
sees significantly more requests than specific token retrievals or token
validation calls.

Here is a list of actions that are affected by the cached time: getting
a new token, revoking tokens, validating tokens, checking v2 tokens, and
checking v3 tokens.

The delete token API calls invalidate the cache for the tokens being
acted upon, as well as invalidating the cache for the revoked token list
and the validate/check token calls.

Token caching is configurable independently of the ``revocation_list``
caching. Lifted expiration checks from the token drivers to the token
manager. This ensures that cached tokens will still raise a
``TokenNotFound`` flag when expired.

For cache consistency, all token IDs are transformed into the short
token hash at the provider and token driver level. Some methods have
access to the full ID (PKI Tokens), and some methods do not. Cache
invalidation is inconsistent without token ID normalization.

Caching around assignment CRUD
------------------------------

The assignment system has a separate ``cache_time`` configuration
option, that can be set to a value above or below the global
``expiration_time`` default, allowing for different caching behavior
from the other systems in Identity service. This option is set in the
``[assignment]`` section of the configuration file.

Currently ``assignment`` has caching for ``project``, ``domain``, and
``role`` specific requests (primarily around the CRUD actions). Caching
is currently not implemented on grants. The ``list`` methods are not
subject to caching.

Here is a list of actions that are affected by the assignment: assign
domain API, assign project API, and assign role API.

The create, update, and delete actions for domains, projects and roles
will perform proper invalidations of the cached methods listed above.

.. note::

   If a read-only ``assignment`` back end is in use, the cache will not
   immediately reflect changes on the back end. Any given change may
   take up to the ``cache_time`` (if set in the ``[assignment]``
   section of the configuration file) or the global ``expiration_time``
   (set in the ``[cache]`` section of the configuration file) before it
   is reflected. If this type of delay (when using a read-only
   ``assignment`` back end) is an issue, it is recommended that caching
   be disabled on ``assignment``. To disable caching specifically on
   ``assignment``, in the ``[assignment]`` section of the configuration
   set ``caching`` to ``False``.

For more information about the different back ends (and configuration
options), see:

- `dogpile.cache.backends.memory <http://dogpilecache.readthedocs.org/en/latest/api.html#memory-backend>`__

- `dogpile.cache.backends.memcached <http://dogpilecache.readthedocs.org/en/latest/api.html#memcached-backends>`__

  .. note::

     The memory back end is not suitable for use in a production
     environment.

- `dogpile.cache.backends.redis <http://dogpilecache.readthedocs.org/en/latest/api.html#redis-backends>`__

- `dogpile.cache.backends.file <http://dogpilecache.readthedocs.org/en/latest/api.html#file-backends>`__

- ``keystone.common.cache.backends.mongo``

Configure the Memcached back end example
----------------------------------------

The following example shows how to configure the memcached back end:

.. code-block:: ini

   [cache]

   enabled = true
   backend = dogpile.cache.memcached
   backend_argument = url:127.0.0.1:11211

You need to specify the URL to reach the ``memcached`` instance with the
``backend_argument`` parameter.
