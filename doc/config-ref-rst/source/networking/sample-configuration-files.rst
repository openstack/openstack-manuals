=====================================
Networking sample configuration files
=====================================

All the files in this section can be found in ``/etc/neutron/``.

neutron.conf
~~~~~~~~~~~~

Use the ``neutron.conf`` file to configure the majority of the OpenStack
Networking options.

.. remote-code-block:: ini

   https://git.openstack.org/cgit/openstack/neutron/plain/etc/neutron.conf?h=stable/liberty

api-paste.ini
~~~~~~~~~~~~~

Use the ``api-paste.ini`` to configure the OpenStack Networking API.

.. remote-code-block:: ini

   https://git.openstack.org/cgit/openstack/neutron/plain/etc/api-paste.ini?h=stable/liberty


policy.json
~~~~~~~~~~~

Use the ``policy.json`` file to define additional access controls that
apply to the OpenStack Networking service.

.. remote-code-block:: json

   https://git.openstack.org/cgit/openstack/neutron/plain/etc/policy.json?h=stable/liberty

rootwrap.conf
~~~~~~~~~~~~~

Use the ``rootwrap.conf`` file to define configuration values used by
the ``rootwrap`` script when the OpenStack Networking service must
escalate its privileges to those of the root user.

.. remote-code-block:: ini

   https://git.openstack.org/cgit/openstack/neutron/plain/etc/rootwrap.conf?h=stable/liberty

Configuration files for plug-in agents
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Each plug-in agent that runs on an OpenStack Networking node, to perform local
networking configuration for the node's VMs and networking services, has its
own configuration file.

dhcp_agent.ini
--------------

.. remote-code-block:: ini

   https://git.openstack.org/cgit/openstack/neutron/plain/etc/dhcp_agent.ini?h=stable/liberty

l3_agent.ini
------------

.. remote-code-block:: ini

   https://git.openstack.org/cgit/openstack/neutron/plain/etc/l3_agent.ini?h=stable/liberty

metadata_agent.ini
------------------

.. remote-code-block:: ini

   https://git.openstack.org/cgit/openstack/neutron/plain/etc/metadata_agent.ini?h=stable/liberty
