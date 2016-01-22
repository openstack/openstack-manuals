======================================
Role-Based Access Control for networks
======================================

A new policy framework was added during Liberty to enable both
operators and users to grant specific projects access to resources.
As of the Liberty release, the only access that can be granted via
this feature is regular port creation permissions on networks.


Sharing a network with specific projects
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Sharing a network with a specific project is accomplished by creating
a policy entry that permits the target project the ``access_as_shared``
action on that network.

First, we create a network we want to share:

.. code-block:: console

   $ neutron net-create secret_network

   Created a new network:
   +---------------------------+--------------------------------------+
   | Field                     | Value                                |
   +---------------------------+--------------------------------------+
   | admin_state_up            | True                                 |
   | id                        | 6532a265-43fb-4c8c-8edb-e26b39f2277c |
   | mtu                       | 0                                    |
   | name                      | secret_network                       |
   | port_security_enabled     | True                                 |
   | provider:network_type     | vxlan                                |
   | provider:physical_network |                                      |
   | provider:segmentation_id  | 1031                                 |
   | router:external           | False                                |
   | shared                    | False                                |
   | status                    | ACTIVE                               |
   | subnets                   |                                      |
   | tenant_id                 | de56db175c1d48b0bbe72f09a24a3b66     |
   +---------------------------+--------------------------------------+

Now we create the policy entry using the :command:`rbac-create` command (In
this example, the ID of the project we want to share with is
``e28769db97d9449da658bc6931fcb683``):

.. code-block:: console

   $ neutron rbac-create --target-tenant e28769db97d9449da658bc6931fcb683 \
     --action access_as_shared --type network 6532a265-43fb-4c8c-8edb-e26b39f2277c

   Created a new rbac_policy:
   +---------------+--------------------------------------+
   | Field         | Value                                |
   +---------------+--------------------------------------+
   | action        | access_as_shared                     |
   | id            | 1edebaf8-3fa5-47b9-b3dd-ccce2bd44411 |
   | object_id     | 6532a265-43fb-4c8c-8edb-e26b39f2277c |
   | object_type   | network                              |
   | target_tenant | e28769db97d9449da658bc6931fcb683     |
   | tenant_id     | de56db175c1d48b0bbe72f09a24a3b66     |
   +---------------+--------------------------------------+

The ``target-tenant`` parameter specifies the project that we wanted to
gain access to the network. The ``action`` parameter specifies what we
want the project to be allowed to do. The ``type`` parameter says
that the target object is a network. The final parameter is the ID of
the network we are granting access to.

Project ``e28769db97d9449da658bc6931fcb683`` will now be able to see
the network when running :command:`net-list` and :command:`net-show`
and will also be able to create ports on that network. No other users
(other than admins and the owner) will be able to see the network.

To remove access for that project, just delete the policy that allows
it using the :command:`rbac-delete` command:

.. code-block:: console

   $ neutron rbac-delete 1edebaf8-3fa5-47b9-b3dd-ccce2bd44411
   Deleted rbac_policy: 1edebaf8-3fa5-47b9-b3dd-ccce2bd44411

If that project has ports on the network, the server will prevent the
policy from being deleted until the ports have been deleted:

.. code-block:: console

   $ neutron rbac-delete 1edebaf8-3fa5-47b9-b3dd-ccce2bd44411
   RBAC policy on object 6532a265-43fb-4c8c-8edb-e26b39f2277c
   cannot be removed because other objects depend on it.

This process can be repeated any number of times to share a network
with an arbitrary number of projects.

How the 'shared' flag relates to these entries
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As introduced in other guide entries, neutron provides a means of
making a network available to every project. This is accomplished
using the ``shared`` flag on the network:

.. code-block:: console

   $ neutron net-create global_network --shared

   Created a new network:
   +---------------------------+--------------------------------------+
   | Field                     | Value                                |
   +---------------------------+--------------------------------------+
   | admin_state_up            | True                                 |
   | id                        | 9a4af544-7158-456d-b180-95f2e11eaa8c |
   | mtu                       | 0                                    |
   | name                      | global_network                       |
   | port_security_enabled     | True                                 |
   | provider:network_type     | vxlan                                |
   | provider:physical_network |                                      |
   | provider:segmentation_id  | 1010                                 |
   | router:external           | False                                |
   | shared                    | True                                 |
   | status                    | ACTIVE                               |
   | subnets                   |                                      |
   | tenant_id                 | de56db175c1d48b0bbe72f09a24a3b66     |
   +---------------------------+--------------------------------------+

This is the equivalent of creating a policy on the network that permits
every project to perform the action ``access_as_shared`` on that network.
In fact, neutron treats them as the same thing, so we should
be able to see a policy entry for that network using the :command:`rbac-list`
command:

.. code-block:: console

   $ neutron rbac-list

   +--------------------------------------+--------------------------------------+
   | id                                   | object_id                            |
   +--------------------------------------+--------------------------------------+
   | fcc63ae1-c56e-449d-8fb0-4f49f3cc8b55 | 9a4af544-7158-456d-b180-95f2e11eaa8c |
   +--------------------------------------+--------------------------------------+

Then we can use the :command:`rbac-show` command to see the details:

.. code-block:: console

   $ neutron rbac-show fcc63ae1-c56e-449d-8fb0-4f49f3cc8b55

   +---------------+--------------------------------------+
   | Field         | Value                                |
   +---------------+--------------------------------------+
   | action        | access_as_shared                     |
   | id            | fcc63ae1-c56e-449d-8fb0-4f49f3cc8b55 |
   | object_id     | 9a4af544-7158-456d-b180-95f2e11eaa8c |
   | object_type   | network                              |
   | target_tenant | *                                    |
   | tenant_id     | de56db175c1d48b0bbe72f09a24a3b66     |
   +---------------+--------------------------------------+

Above we can see that the entry allows the action ``access_as_shared``
on object ``9a4af544-7158-456d-b180-95f2e11eaa8c`` of type ``network``
to target_tenant ``*``, which is a wildcard that represents all projects.

As of Liberty, the ``shared`` flag is just a mapping to the underlying
RBAC policies for a network. Setting the flag to ``True`` on a network
creates a wildcard RBAC entry. Setting it to ``False`` removes the
wildcard entry.

When a :command:`net-list` or :command:`net-show` is done, the
``shared`` flag is calculated by the server based on the calling
project and the RBAC entries for each network. If there is a
wildcard entry, the ``shared`` flag is always set to ``True``.
If there are only entries that share with specific projects, only
the projects the network is shared to will see the flag as ``True``
and the rest will see the flag as ``False``.


Preventing regular users from sharing networks with each other
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The default ``policy.json`` shipped with neutron will not allow regular
users to share networks with every other project using a wildcard;
however, it will allow them to share networks with specific project
IDs.

If an operator wants to prevent normal users from doing this, the
``"create_rbac_policy":`` entry in ``policy.json`` can be adjusted
from ``""`` to ``"rule:admin_only"``.


Limitations
~~~~~~~~~~~

A non-admin user that shares a network with another project using this
feature will not be able to see or delete the ports created under the
other project. This is because the neutron database operations
automatically limit database queries to objects owned by the requesting
user's project unless that user is an admin or a service user.
This issue is being tracked by the following bug:
https://bugs.launchpad.net/neutron/+bug/1498790
