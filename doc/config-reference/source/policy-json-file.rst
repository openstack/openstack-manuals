====================
The policy.json file
====================

Each OpenStack service, Identity, Compute, Networking and so on, has its
own role-based access policies. They determine which user can access
which objects in which way, and are defined in the service's
``policy.json`` file.

Whenever an API call to an OpenStack service is made, the service's
policy engine uses the appropriate policy definitions to determine if
the call can be accepted. Any changes to ``policy.json`` are effective
immediately, which allows new policies to be implemented while the
service is running.

A ``policy.json`` file is a text file in JSON (Javascript Object
Notation) format. Each policy is defined by a one-line statement in the
form ``"<target>" : "<rule>"``.

The policy target, also named "action", represents an API call like
"start an instance" or "attach a volume".

Action names are usually qualified. Example: OpenStack Compute features
API calls to list instances, volumes and networks. In
``/etc/nova/policy.json``, these APIs are represented by
``compute:get_all``, ``volume:get_all`` and ``network:get_all``,
respectively.

The mapping between API calls and actions is not generally documented.

The policy rule determines under which circumstances the API call is
permitted. Usually this involves the user who makes the call (hereafter
named the "API user") and often the object on which the API call
operates. A typical rule checks if the API user is the object's owner.

.. warning::

    **Modifying the policy**

    While recipes for editing ``policy.json`` files are found on blogs,
    modifying the policy can have unexpected side effects and is not
    encouraged.

Examples
~~~~~~~~

A simple rule might look like this:

.. code-block:: json

    "compute:get_all" : ""

The target is ``"compute:get_all"``, the "list all instances" API of the
Compute service. The rule is an empty string meaning "always". This
policy allows anybody to list instances.

You can also decline permission to use an API:

.. code-block:: json

    "compute:shelve": "!"

The exclamation mark stands for "never" or "nobody", which effectively
disables the Compute API "shelve an instance".

Many APIs can only be called by admin users. This can be expressed by
the rule ``"role:admin"``. The following policy ensures that only
administrators can create new users in the Identity database:

.. code-block:: json

    "identity:create_user" : "role:admin"

You can limit APIs to any role. For example, the Orchestration service
defines a role named ``heat_stack_user``. Whoever has this role isn't
allowed to create stacks:

.. code-block:: json

    "stacks:create": "not role:heat_stack_user"

This rule makes use of the boolean operator ``not``. More complex rules
can be built using operators ``and``, ``or`` and parentheses.

You can define aliases for rules:

.. code-block:: json

    "deny_stack_user": "not role:heat_stack_user"

The policy engine understands that ``"deny_stack_user"`` is not an API
and consequently interprets it as an alias. The stack creation policy
above can then be written as:

.. code-block:: json

    "stacks:create": "rule:deny_stack_user"

This is taken verbatim from ``/etc/heat/policy.json``.

Rules can compare API attributes to object attributes. For example:

.. code-block:: json

    "os_compute_api:servers:start" : "project_id:%(project_id)s"

states that only the owner of an instance can start it up. The
``project_id`` string before the colon is an API attribute, namely the project
ID of the API user. It is compared with the project ID of the object (in
this case, an instance); more precisely, it is compared with the
``project_id`` field of that object in the database. If the two values are
equal, permission is granted.

An admin user always has permission to call APIs. This is how
``/etc/keystone/policy.json`` makes this policy explicit:

.. code-block:: json

    "admin_required": "role:admin or is_admin:1",
    "owner" : "user_id:%(user_id)s",
    "admin_or_owner": "rule:admin_required or rule:owner",
    "identity:change_password": "rule:admin_or_owner"

The first line defines an alias for "user is an admin user". The
``is_admin`` flag is only used when setting up the Identity service for
the first time. It indicates that the user has admin privileges granted
by the service token (``--os-token`` parameter of the ``keystone``
command line client).

The second line creates an alias for "user owns the object" by comparing
the API's user ID with the object's user ID.

Line 3 defines a third alias ``admin_or_owner``, combining the two first
aliases with the Boolean operator ``or``.

Line 4 sets up the policy that a password can only be modified by its
owner or an admin user.

As a final example, let's examine a more complex rule:

.. code-block:: json

    "identity:ec2_delete_credential": "rule:admin_required or
                 (rule:owner and user_id:%(target.credential.user_id)s)"


This rule determines who can use the Identity API "delete EC2
credential". Here, boolean operators and parentheses combine three
simpler rules. ``admin_required`` and ``owner`` are the same aliases as
in the previous example. ``user_id:%(target.credential.user_id)s``
compares the API user with the user ID of the credential object
associated with the target.

Syntax
~~~~~~

A ``policy.json`` file consists of policies and aliases of the form
``target:rule`` or ``alias:definition``, separated by commas and
enclosed in curly braces:

.. code-block:: json

     {
           "alias 1" : "definition 1",
           "alias 2" : "definition 2",
           ...
           "target 1" : "rule 1",
           "target 2" : "rule 2",
           ....
    }

Targets are APIs and are written ``"service:API"`` or simply ``"API"``.
For example, ``"compute:create"`` or ``"add_image"``.

Rules determine whether the API call is allowed.

Rules can be:

-  always true. The action is always permitted. This can be written as
   ``""`` (empty string), ``[]``, or ``"@"``.

-  always false. The action is never permitted. Written as ``"!"``.

-  a special check

-  a comparison of two values

-  boolean expressions based on simpler rules

Special checks are

-  ``<role>:<role name>``, a test whether the API credentials contain
   this role.

-  ``<rule>:<rule name>``, the definition of an alias.

-  ``http:<target URL>``, which delegates the check to a remote server.
   The API is authorized when the server returns True.

Developers can define additional special checks.

Two values are compared in the following way:

.. code-block:: json

    "value1 : value2"

Possible values are

-  constants: Strings, numbers, ``true``, ``false``

-  API attributes

-  target object attributes

-  the flag ``is_admin``

API attributes can be ``project_id``, ``user_id`` or ``domain_id``.

Target object attributes are fields from the object description in the
database. For example in the case of the ``"compute:start"`` API, the
object is the instance to be started. The policy for starting instances
could use the ``%(project_id)s`` attribute, that is the project that
owns the instance. The trailing s indicates this is a string.

``is_admin`` indicates that administrative privileges are granted via
the admin token mechanism (the ``--os-token`` option of the ``keystone``
command). The admin token allows initialisation of the identity database
before the admin role exists.

The alias construct exists for convenience. An alias is short name for a
complex or hard to understand rule. It is defined in the same way as a
policy:

.. code-block:: json

    alias name : alias definition

Once an alias is defined, use the ``rule`` keyword to use it in a policy
rule.

Older syntax
~~~~~~~~~~~~

You may encounter older ``policy.json`` files that feature a different
syntax, where JavaScript arrays are used instead of boolean operators.
For example, the EC2 credentials rule above would have been written as
follows:

.. code-block:: json

    "identity:ec2_delete_credential": [ [ "rule:admin_required ],
                 [ "rule:owner", "user_id:%(target.credential.user_id)s)" ] ]


The rule is an array of arrays. The innermost arrays are or'ed together,
whereas elements inside the innermost arrays are and'ed.

While the old syntax is still supported, we recommend using the newer,
more intuitive syntax.
