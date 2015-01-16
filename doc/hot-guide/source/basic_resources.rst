.. _hot_basic_resources:

#########
Instances
#########

..  For consistency let's define a few values to use in the samples:
    * image name: ubuntu-trusty-x86_64
    * shared/provider network name: "public"
    * tenant network and subnet names: "private" and "private-subnet"


Manage instances
================

Create an instance
------------------

Use the :hotref:`OS::Nova::Server` resource to create a Compute instance. The
``flavor`` property is the only mandatory one, but you need to define a boot
source using one of the ``image`` or ``block_device_mapping`` properties.

You also need to define the ``networks`` property to indicate to which networks
your instance must connect if multiple networks are available in your tenant.

The following example creates a simple instance, booted from an image, and
connecting to the ``private`` network:

.. code-block:: yaml

    resources:
      instance:
        type: OS::Nova::Server
        properties:
          flavor: m1.small
          image: ubuntu-trusty-x86_64
          networks:
            - network: private


Connect an instance to a network
--------------------------------

Use the ``networks`` property of an :hotref:`OS::Nova::Server` resource to
define which networks an instance should connect to. Define each network as a
YAML map, containing one of the following keys:

``port``
    The ID of an existing Networking port. You usually create this port in the
    same template using an :hotref:`OS::Neutron::Port` resource. You will be
    able to associate a floating IP to this port, and the port to your Compute
    instance.

``network``
    The name or ID of an existing network. You don't need to create an
    :hotref:`OS::Neutron::Port` resource if you use this property, but you will
    not be able to associate a floating IP with the instance interface in the
    template.

The following example demonstrates the use of the ``port`` and ``network``
properties:

.. code-block:: yaml

    resources:
      instance_port:
        type: OS::Neutron::Port
        properties:
          network: private
          fixed_ips:
            - subnet_id: "private-subnet"

      instance1:
        type: OS::Nova::Server
        properties:
          flavor: m1.small
          image: ubuntu-trusty-x86_64
          networks:
            - port: { get_resource: instance_port }

      instance2:
        type: OS::Nova::Server
        properties:
          flavor: m1.small
          image: ubuntu-trusty-x86_64
          networks:
            - network: private


Create and associate security groups to an instance
---------------------------------------------------

Use the :hotref:`OS::Neutron::SecurityGroup` resource to create security
groups.

Define the ``security_groups`` property of the :hotref:`OS::Neutron::Port`
resource to associate security groups to a port, then associate the port to an
instance.

The following example creates a security group allowing inbound connections on
ports 80 and 443 (web server) and associates this security group to an instance
port:

.. code-block:: yaml

    resources:
      web_secgroup:
        type: OS::Neutron::SecurityGroup
        properties:
          rules:
            - protocol: tcp
              remote_ip_prefix: 0.0.0.0/0
              port_range_min: 80
              port_range_max: 80
            - protocol: tcp
              remote_ip_prefix: 0.0.0.0/0
              port_range_min: 443
              port_range_max: 443

      instance_port:
        type: OS::Neutron::Port
        properties:
          network: private
          security_groups:
            - default
            - { get_resource: web_secgroup }
          fixed_ips:
            - subnet_id: private-subnet

      instance:
        type: OS::Nova::Server
        properties:
          flavor: m1.small
          image: ubuntu-trusty-x86_64
          networks:
            - port: { get_resource: instance_port }


Create and associate a floating IP to an instance
-------------------------------------------------

You can use two sets of resources to create and associate floating IPs to
instances.

OS::Nova resources
~~~~~~~~~~~~~~~~~~

Use the :hotref:`OS::Nova::FloatingIP` resource to create a floating IP, and
the :hotref:`OS::Nova::FloatingIPAssociation` resource to associate the
floating IP to an instance.

The following example creates an instance and a floating IP, and associate the
floating IP to the instance:

.. code-block:: yaml

    resources:
      floating_ip:
        type: OS::Nova::FloatingIP
        properties:
          pool: public

      inst1:
        type: OS::Nova::Server
        properties:
          flavor: m1.small
          image: ubuntu-trusty-x86_64
          networks:
            - network: private

      association:
        type: OS::Nova::FloatingIPAssociation
        properties:
          - floating_ip: { get_resource: floating_ip }
          - server_id: { get_resource: instance }

OS::Neutron resources
~~~~~~~~~~~~~~~~~~~~~

.. note::
    The Networking service (neutron) must be enabled on your OpenStack
    deployment to use these resources.

Use the :hotref:`OS::Neutron::FloatingIP` resource to create a floating IP, and
the :hotref:`OS::Neutron::FloatingIPAssociation` resource to associate the
floating IP to a port:

.. code-block:: yaml

    parameters:
      net:
        description: name of network used to launch instance.
        type: string
        default: private

    resources:
      inst1:
        type: OS::Nova::Server
        properties:
          flavor: m1.small
          image: ubuntu-trusty-x86_64
          networks:
            - network: {get_param: net}

      floating_ip:
        type: OS::Neutron::FloatingIP
        properties:
          floating_network: public

      association:
        type: OS::Neutron::FloatingIPAssociation
        properties:
          floatingip_id: { get_resource: floating_ip }
          port_id: {get_attr: [inst1, addresses, {get_param: net}, 0, port]}


You can also create an OS::Neutron::Port and associate that with the server and
the floating IP. However the approach mentioned above will work better
with stack updates.

.. code-block:: yaml

    resources:
      instance_port:
        type: OS::Neutron::Port
        properties:
          network: private
          fixed_ips:
            - subnet_id: "private-subnet"

      floating_ip:
        type: OS::Neutron::FloatingIP
        properties:
          floating_network: public

      association:
        type: OS::Neutron::FloatingIPAssociation
        properties:
          floatingip_id: { get_resource: floating_ip }
          port_id: { get_resource: instance_port }


Enable remote access to an instance
-----------------------------------


The ``key_name`` attribute of the :hotref:`OS::Nova::Server` resource defines
the key pair to use to enable SSH remote access:

.. code-block:: yaml

    resources:
      my_instance:
        type: OS::Nova::Server
        properties:
          flavor: m1.small
          image: ubuntu-trusty-x86_64
          key_name: my_key

.. note::
    For more information about key pairs, see the `Configure access and
    security for instances`_ section of the OpenStack user guide.

.. _`Configure access and security for instances`: http://docs.openstack.org/user-guide/content/cli_configure_instances.html

Create a key pair
-----------------

You can create new key pairs with the :hotref:`OS::Nova::KeyPair` resource. Key
pairs can be imported or created during the stack creation.

If the ``public_key`` property is not specified, the Orchestration module
creates a new key pair. If the ``save_private_key`` property is set to
``true``, the ``private_key`` attribute of the resource holds the private key.

The following example creates a new key pair and uses it as authentication key
for an instance:

.. code-block:: yaml

    resources:
      my_key:
        type: OS::Nova::KeyPair
        properties:
          save_private_key: true

      my_instance:
        type: OS::Nova::Server
        properties:
          flavor: m1.small
          image: ubuntu-trusty-x86_64
          key_name: { get_resource: my_key }

    outputs:
      private_key:
        description: Private key
        value: { get_attr: [ my_key, private_key ] }



Manage networks
===============

Create a network and a subnet
-----------------------------

.. note::
    The Networking service (neutron) must be enabled on your OpenStack
    deployment to create and manage networks and subnets. Networks and subnets
    cannot be created if your deployment uses legacy networking (nova-network).

Use the :hotref:`OS::Neutron::Net` resource to create a network, and the
:hotref:`OS::Neutron::Subnet` resource to provide a subnet for this network:

.. code-block:: yaml

    resources:
      new_net:
        type: OS::Neutron::Net

      new_subnet:
        type: OS::Neutron::Subnet
        properties:
          network_id: { get_resource: new_net }
          cidr: "10.8.1.0/24"
          dns_nameservers: [ "8.8.8.8", "8.8.4.4" ]
          ip_version: 4


Create and manage a router
--------------------------

Use the :hotref:`OS::Neutron::Router` resource to create a router. You can
define its gateway with the ``external_gateway_info`` property:

.. code-block:: yaml

    resources:
      router1:
        type: OS::Neutron::Router
        properties:
          external_gateway_info: { network: public }

You can connect subnets to routers with the
:hotref:`OS::Neutron::RouterInterface` resource:

.. code-block:: yaml

    resources:
      subnet1_interface:
        type: OS::Neutron::RouterInterface
        properties:
          router_id: { get_resource: router1 }
          subnet: private-subnet


Complete network example
------------------------

The following example creates a network stack:

* A network and an associated subnet.
* A router with an external gateway.
* An interface to the new subnet for the new router.

In this example, the ``public`` network is an existing shared network:

.. code-block:: yaml

    resources:
      internal_net:
        type: OS::Neutron::Net

      internal_subnet:
        type: OS::Neutron::Subnet
        properties:
          network_id: { get_resource: internal_net }
          cidr: "10.8.1.0/24"
          dns_nameservers: [ "8.8.8.8", "8.8.4.4" ]
          ip_version: 4

      internal_router:
        type: OS::Neutron::Router
        properties:
          external_gateway_info: { network: public }

      internal_interface:
        type: OS::Neutron::RouterInterface
        properties:
          router_id: { get_resource: internal_router }
          subnet: { get_resource: internal_subnet }


Manage volumes
==============

Create a volume
---------------

Use the :hotref:`OS::Cinder::Volume` resource to create a new Block Storage
volume.

For example:

.. code-block:: yaml

    resources:
      my_new_volume:
        type: OS::Cinder::Volume
        properties:
          size: 10

The volumes that you create are empty by default. Use the ``image`` property to
create a bootable volume from an existing image:

.. code-block:: yaml

    resources:
      my_new_bootable_volume:
        type: OS::Cinder::Volume
        properties:
          size: 10
          image: ubuntu-trusty-x86_64


You can also create new volumes from another volume, a volume snapshot, or a
volume backup. Use the ``source_volid``, ``snapshot_id`` or ``backup_id``
properties to create a new volume from an existing source.

For example, to create a new volume from a backup:

.. code-block:: yaml

    resources:
      another_volume:
        type: OS::Cinder::Volume
        properties:
          backup_id: 2fff50ab-1a9c-4d45-ae60-1d054d6bc868

In this example the ``size`` property is not defined because the Block Storage
service uses the size of the backup to define the size of the new volume.


Attach a volume to an instance
------------------------------

Use the :hotref:`OS::Cinder::VolumeAttachment` resource to attach a volume to
an instance.

The following example creates a volume and an instance, and attaches the volume
to the instance:

.. code-block:: yaml

    resources:
      new_volume:
        type: OS::Cinder::Volume
        properties:
          size: 1

      new_instance:
        type: OS::Nova::Server
        properties:
          flavor: m1.small
          image: ubuntu-trusty-x86_64

      volume_attachment:
        type: OS::Cinder::VolumeAttachment
        properties:
          volume_id: { get_resource: new_volume }
          instance_uuid: { get_resource: new_instance }

Boot an instance from a volume
------------------------------

Use the ``block_device_mapping`` property of the :hotref:`OS::Nova::Server`
resource to define a volume used to boot the instance. This property is a list
of volumes to attach to the instance before its boot.

The following example creates a bootable volume from an image, and uses it to
boot an instance:

.. code-block:: yaml

    resources:
      bootable_volume:
        type: OS::Cinder::Volume
        properties:
          size: 10
          image: ubuntu-trusty-x86_64

      instance:
        type: OS::Nova::Server
        properties:
          flavor: m1.small
          networks:
            - network: private
          block_device_mapping:
            - device_name: vda
              volume_id: { get_resource: bootable_volume }
              delete_on_termination: false

.. TODO

  A few elements that probably belong here:
  - OS::Swift::Container
  - OS::Trove::Instance
