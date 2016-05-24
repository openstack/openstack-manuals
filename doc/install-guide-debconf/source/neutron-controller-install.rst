Install and configure controller node
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Configure networking options
----------------------------

You can deploy the Networking service using one of two architectures
represented by options 1 and 2.

Option 1 deploys the simplest possible architecture that only supports
attaching instances to provider (external) networks. No self-service (private)
networks, routers, or floating IP addresses. Only the ``admin`` or other
privileged user can manage provider networks.

Option 2 augments option 1 with layer-3 services that support attaching
instances to self-service networks. The ``demo`` or other unprivileged
user can manage self-service networks including routers that provide
connectivity between self-service and provider networks. Additionally,
floating IP addresses provide connectivity to instances using self-service
networks from external networks such as the Internet.

Self-service networks typically use overlay networks. Overlay network
protocols such as VXLAN include additional headers that increase overhead
and decrease space available for the payload or user data. Without knowledge
of the virtual network infrastructure, instances attempt to send packets
using the default Ethernet :term:`maximum transmission unit (MTU)` of 1500
bytes. The Networking service automatically provides the correct MTU value
to instances via DHCP. However, some cloud images do not use DHCP or ignore
the DHCP MTU option and require configuration using metadata or a script.

.. note::

   Option 2 also supports attaching instances to provider networks.

Choose one of the following networking options to configure services
specific to it. Afterwards, return here and proceed to
:ref:`neutron-controller-metadata-agent`.

.. toctree::
   :maxdepth: 1

   neutron-controller-install-option1.rst
   neutron-controller-install-option2.rst

.. _neutron-controller-metadata-agent:

Configure the metadata agent
----------------------------

The :term:`metadata agent <Metadata agent>` provides configuration information
such as credentials to instances.

* Edit the ``/etc/neutron/metadata_agent.ini`` file and complete the following
  actions:

  * In the ``[DEFAULT]`` section, configure the metadata host and shared
    secret:

    .. code-block:: ini

       [DEFAULT]
       ...
       nova_metadata_ip = controller
       metadata_proxy_shared_secret = METADATA_SECRET

    Replace ``METADATA_SECRET`` with a suitable secret for the metadata proxy.

Configure Compute to use Networking
-----------------------------------

* Edit the ``/etc/nova/nova.conf`` file and perform the following actions:

  * In the ``[neutron]`` section, configure access parameters, enable the
    metadata proxy, and configure the secret:

    .. code-block:: ini

       [neutron]
       ...
       url = http://controller:9696
       auth_url = http://controller:35357
       auth_type = password
       project_domain_name = default
       user_domain_name = default
       region_name = RegionOne
       project_name = service
       username = neutron
       password = NEUTRON_PASS

       service_metadata_proxy = True
       metadata_proxy_shared_secret = METADATA_SECRET

    Replace ``NEUTRON_PASS`` with the password you chose for the ``neutron``
    user in the Identity service.

    Replace ``METADATA_SECRET`` with the secret you chose for the metadata
    proxy.
