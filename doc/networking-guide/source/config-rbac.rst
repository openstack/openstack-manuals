.. _config-rbac:

================================
Role-Based Access Control (RBAC)
================================

The Role-Based Access Control (RBAC) policy framework enables both operators
and users to grant access to resources for specific projects.


Supported objects for sharing with specific projects
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Currently, the access that can be granted using this feature
is supported by:

* Regular port creation permissions on networks (since Liberty).
* Binding QoS policies permissions to networks or ports (since Mitaka).
* Attaching router gateways to networks (since Mitaka).


Sharing an object with specific projects
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Sharing an object with a specific project is accomplished by creating
a policy entry that permits the target project the ``access_as_shared``
action on that object.


Sharing a network with specific projects
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Create a network to share:

.. code-block:: console

   $ neutron net-create secret_network

   Created a new network:
   +---------------------------+--------------------------------------+
   | Field                     | Value                                |
   +---------------------------+--------------------------------------+
   | admin_state_up            | True                                 |
   | id                        | 6532a265-43fb-4c8c-8edb-e26b39f2277c |
   | mtu                       | 1450                                 |
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

Create the policy entry using the :command:`rbac-create` command (in
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

The ``target-tenant`` parameter specifies the project that requires
access to the network. The ``action`` parameter specifies what
the project is allowed to do. The ``type`` parameter says
that the target object is a network. The final parameter is the ID of
the network we are granting access to.

Project ``e28769db97d9449da658bc6931fcb683`` will now be able to see
the network when running :command:`net-list` and :command:`net-show`
and will also be able to create ports on that network. No other users
(other than admins and the owner) will be able to see the network.

To remove access for that project, delete the policy that allows
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


Sharing a QoS policy with specific projects
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Create a QoS policy to share:

.. code-block:: console

   $ neutron qos-policy-create secret_policy

   Created a new policy:
   +-------------+--------------------------------------+
   | Field       | Value                                |
   +-------------+--------------------------------------+
   | description |                                      |
   | id          | e45e6917-3f3f-4835-ad54-d12c9151541d |
   | name        | secret_policy                        |
   | rules       |                                      |
   | shared      | False                                |
   | tenant_id   | 5b32b072f8354942ab13b6decb1294b3     |
   +-------------+--------------------------------------+

Create the RBAC policy entry using the :command:`rbac-create` command (in
this example, the ID of the project we want to share with is
``a6bf6cfbcd1f4e32a57d2138b6bd41d1``):

.. code-block:: console

   $ neutron rbac-create --target-tenant a6bf6cfbcd1f4e32a57d2138b6bd41d1 \
     --action access_as_shared --type qos-policy e45e6917-3f3f-4835-ad54-d12c9151541d

   Created a new rbac_policy:
   +---------------+--------------------------------------+
   | Field         | Value                                |
   +---------------+--------------------------------------+
   | action        | access_as_shared                     |
   | id            | ec2e3db1-de5b-4043-9d95-156f582653d0 |
   | object_id     | e45e6917-3f3f-4835-ad54-d12c9151541d |
   | object_type   | qos_policy                           |
   | target_tenant | a6bf6cfbcd1f4e32a57d2138b6bd41d1     |
   | tenant_id     | 5b32b072f8354942ab13b6decb1294b3     |
   +---------------+--------------------------------------+

The ``target-tenant`` parameter specifies the project that requires
access to the QoS policy. The ``action`` parameter specifies what
the project is allowed to do. The ``type`` parameter says
that the target object is a QoS policy. The final parameter is the ID of
the QoS policy we are granting access to.

Project ``a6bf6cfbcd1f4e32a57d2138b6bd41d1`` will now be able to see
the QoS policy when running :command:`qos-policy-list` and :command:`qos-policy-show`
and will also be able to bind it to its ports or networks. No other users
(other than admins and the owner) will be able to see the QoS policy.

To remove access for that project, delete the RBAC policy that allows
it using the :command:`rbac-delete` command:

.. code-block:: console

   $ neutron rbac-delete e45e6917-3f3f-4835-ad54-d12c9151541d
   Deleted rbac_policy: e45e6917-3f3f-4835-ad54-d12c9151541d

If that project has ports or networks with the QoS policy applied to them,
the server will not delete the RBAC policy until
the QoS policy is no longer in use:

.. code-block:: console

   $ neutron rbac-delete e45e6917-3f3f-4835-ad54-d12c9151541d
   RBAC policy on object e45e6917-3f3f-4835-ad54-d12c9151541d
   cannot be removed because other objects depend on it.

This process can be repeated any number of times to share a qos-policy
with an arbitrary number of projects.


How the 'shared' flag relates to these entries
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As introduced in other guide entries, neutron provides a means of
making an object (``network``, ``qos-policy``) available to every project.
This is accomplished using the ``shared`` flag on the supported object:

.. code-block:: console

   $ neutron net-create global_network --shared

   Created a new network:
   +---------------------------+--------------------------------------+
   | Field                     | Value                                |
   +---------------------------+--------------------------------------+
   | admin_state_up            | True                                 |
   | id                        | 9a4af544-7158-456d-b180-95f2e11eaa8c |
   | mtu                       | 1450                                 |
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
Neutron treats them as the same thing, so the policy entry for that
network should be visible using the :command:`rbac-list` command:

.. code-block:: console

   $ neutron rbac-list

   +--------------------------------------+-------------+--------------------------------------+
   | id                                   | object_type | object_id                            |
   +--------------------------------------+-------------+--------------------------------------+
   | ec2e3db1-de5b-4043-9d95-156f582653d0 | qos_policy  | e45e6917-3f3f-4835-ad54-d12c9151541d |
   | e7b7a4a7-8c3e-4003-9e15-5a9464c1ecea | network     | fcc63ae1-c56e-449d-8fb0-4f49f3cc8b55 |
   +--------------------------------------+-------------+--------------------------------------+


Use the :command:`rbac-show` command to see the details:

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

The output shows that the entry allows the action ``access_as_shared``
on object ``9a4af544-7158-456d-b180-95f2e11eaa8c`` of type ``network``
to target_tenant ``*``, which is a wildcard that represents all projects.

Currently, the ``shared`` flag is just a mapping to the underlying
RBAC policies for a network. Setting the flag to ``True`` on a network
creates a wildcard RBAC entry. Setting it to ``False`` removes the
wildcard entry.

When you run :command:`net-list` or :command:`net-show`, the
``shared`` flag is calculated by the server based on the calling
project and the RBAC entries for each network. For QoS objects
use :command:`qos-policy-list` or :command:`qos-policy-show` respectively.
If there is a wildcard entry, the ``shared`` flag is always set to ``True``.
If there are only entries that share with specific projects, only
the projects the object is shared to will see the flag as ``True``
and the rest will see the flag as ``False``.


Allowing a network to be used as an external network
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To make a network available as an external network for specific projects
rather than all projects, use the ``access_as_external`` action.

#. Create a network that you want to be available as an external network:

   .. code-block:: console

      $ neutron net-create secret_external_network

      Created a new network:
      +---------------------------+--------------------------------------+
      | Field                     | Value                                |
      +---------------------------+--------------------------------------+
      | admin_state_up            | True                                 |
      | availability_zone_hints   |                                      |
      | availability_zones        |                                      |
      | created_at                | 2016-04-30T06:51:46                  |
      | description               |                                      |
      | id                        | f9e39715-f7da-4bca-a74d-fc3675321661 |
      | ipv4_address_scope        |                                      |
      | ipv6_address_scope        |                                      |
      | mtu                       | 1450                                 |
      | name                      | secret_external_network              |
      | port_security_enabled     | True                                 |
      | provider:network_type     | vxlan                                |
      | provider:physical_network |                                      |
      | provider:segmentation_id  | 1073                                 |
      | router:external           | False                                |
      | shared                    | False                                |
      | status                    | ACTIVE                               |
      | subnets                   |                                      |
      | tags                      |                                      |
      | tenant_id                 | dfe49b63660e494fbdbf6ad2ca2a810f     |
      | updated_at                | 2016-04-30T06:51:46                  |
      +---------------------------+--------------------------------------+

#. Create a policy entry using the :command:`rbac-create` command (in
   this example, the ID of the project we want to share with is
   ``e28769db97d9449da658bc6931fcb683``):

   .. code-block:: console

      $ neutron rbac-create --target-tenant e28769db97d9449da658bc6931fcb683 \
        --action access_as_external --type network f9e39715-f7da-4bca-a74d-fc3675321661

      Created a new rbac_policy:
      +---------------+--------------------------------------+
      | Field         | Value                                |
      +---------------+--------------------------------------+
      | action        | access_as_external                   |
      | id            | c26b3b05-5781-48a1-a36a-fb63072b5e56 |
      | object_id     | f9e39715-f7da-4bca-a74d-fc3675321661 |
      | object_type   | network                              |
      | target_tenant | e28769db97d9449da658bc6931fcb683     |
      | tenant_id     | dfe49b63660e494fbdbf6ad2ca2a810f     |
      +---------------+--------------------------------------+

The ``target-tenant`` parameter specifies the project that requires
access to the network. The ``action`` parameter specifies what
the project is allowed to do. The ``type`` parameter indicates
that the target object is a network. The final parameter is the ID of
the network we are granting external access to.

Now project ``e28769db97d9449da658bc6931fcb683`` is able to see
the network when running :command:`net-list` and :command:`net-show`
and can attach router gateway ports to that network. No other users
(other than admins and the owner) are able to see the network.

To remove access for that project, delete the policy that allows
it using the :command:`rbac-delete` command:

.. code-block:: console

   $ neutron rbac-delete c26b3b05-5781-48a1-a36a-fb63072b5e56
   Deleted rbac_policy: c26b3b05-5781-48a1-a36a-fb63072b5e56

If that project has router gateway ports attached to that network,
the server prevents the policy from being deleted until the
ports have been deleted:

.. code-block:: console

   $ neutron rbac-delete c26b3b05-5781-48a1-a36a-fb63072b5e56
   RBAC policy on object f9e39715-f7da-4bca-a74d-fc3675321661
   cannot be removed because other objects depend on it.

This process can be repeated any number of times to make a network
available as external to an arbitrary number of projects.

If a network is marked as external during creation, it now implicitly
creates a wildcard RBAC policy granting everyone access to preserve
previous behavior before this feature was added.

.. code-block:: console

   $ neutron net-create global_external_network --router:external

   Created a new network:
   +---------------------------+--------------------------------------+
   | Field                     | Value                                |
   +---------------------------+--------------------------------------+
   | admin_state_up            | True                                 |
   | availability_zone_hints   |                                      |
   | availability_zones        |                                      |
   | created_at                | 2016-04-30T07:00:57                  |
   | description               |                                      |
   | id                        | cb78991c-cdde-445b-a8ca-d819b9266756 |
   | ipv4_address_scope        |                                      |
   | ipv6_address_scope        |                                      |
   | is_default                | False                                |
   | mtu                       | 1450                                 |
   | name                      | global_external_network              |
   | port_security_enabled     | True                                 |
   | provider:network_type     | vxlan                                |
   | provider:physical_network |                                      |
   | provider:segmentation_id  | 1007                                 |
   | router:external           | True                                 |
   | shared                    | False                                |
   | status                    | ACTIVE                               |
   | subnets                   |                                      |
   | tags                      |                                      |
   | tenant_id                 | dfe49b63660e494fbdbf6ad2ca2a810f     |
   | updated_at                | 2016-04-30T07:00:57                  |
   +---------------------------+--------------------------------------+

In the output above the standard ``router:external`` attribute is
``True`` as expected. Now a wildcard policy is visible in the
RBAC policy listings:

.. code-block:: console

   $ neutron rbac-list --object_id=cb78991c-cdde-445b-a8ca-d819b9266756 \
     -c id -c target_tenant

   +--------------------------------------+---------------+
   | id                                   | target_tenant |
   +--------------------------------------+---------------+
   | 2b72fe2e-20cf-4856-af12-3ac0733604d8 | *             |
   +--------------------------------------+---------------+

You can modify or delete this policy with the same constraints
as any other RBAC ``access_as_external`` policy.


Preventing regular users from sharing objects with each other
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The default ``policy.json`` file will not allow regular
users to share objects with every other project using a wildcard;
however, it will allow them to share objects with specific project
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
