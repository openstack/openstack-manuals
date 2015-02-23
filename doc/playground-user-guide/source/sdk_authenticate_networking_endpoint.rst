==========
Networking
==========

To use the information in this section, you should have a general
understanding of OpenStack Networking, OpenStack Compute, and the
integration between the two. You should also have access to a plug-in
that implements the Networking API v2.0.

.. _set-environment-variables:

Set environment variables
~~~~~~~~~~~~~~~~~~~~~~~~~

Make sure that you set the relevant environment variables.

As an example, see the sample shell file that sets these variables to
get credentials:

.. code:: bash

    export OS_USERNAME="admin"
    export OS_PASSWORD="password"
    export OS_TENANT_NAME="admin"
    export OS_AUTH_URL="http://IPADDRESS/v2.0"

.. _get-credentials:

Get credentials
~~~~~~~~~~~~~~~

The examples in this section use the ``get_credentials`` method:

.. code:: python

    def get_credentials():
        d = {}
        d['username'] = os.environ['OS_USERNAME']
        d['password'] = os.environ['OS_PASSWORD']
        d['auth_url'] = os.environ['OS_AUTH_URL']
        d['tenant_name'] = os.environ['OS_TENANT_NAME']
        return d

This code resides in the ``credentials.py`` file, which all samples
import.

Use the ``get_credentials()`` method to populate and get a dictionary:

.. code:: python

    credentials = get_credentials()

.. _get-nova-credentials:

Get Nova credentials
~~~~~~~~~~~~~~~~~~~~

The examples in this section use the ``get_nova_credentials`` method:

.. code:: python

    def get_nova_credentials():
        d = {}
        d['username'] = os.environ['OS_USERNAME']
        d['api_key'] = os.environ['OS_PASSWORD']
        d['auth_url'] = os.environ['OS_AUTH_URL']
        d['project_id'] = os.environ['OS_TENANT_NAME']
        return d

This code resides in the ``credentials.py`` file, which all samples
import.

Use the ``get_nova_credentials()`` method to populate and get a
dictionary:

.. code:: python

    nova_credentials = get_nova_credentials()

.. _print-values:

Print values
~~~~~~~~~~~~

The examples in this section use the ``print_values`` and
``print_values_server`` methods:

.. code:: python

    def print_values(val, type):
        if type == 'ports':
            val_list = val['ports']
        if type == 'networks':
            val_list = val['networks']
        if type == 'routers':
            val_list = val['routers']
        for p in val_list:
            for k, v in p.items():
                print("%s : %s" % (k, v))
            print('\n')


    def print_values_server(val, server_id, type):
        if type == 'ports':
            val_list = val['ports']

        if type == 'networks':
            val_list = val['networks']
        for p in val_list:
            bool = False
            for k, v in p.items():
                if k == 'device_id' and v == server_id:
                    bool = True
            if bool:
                for k, v in p.items():
                    print("%s : %s" % (k, v))
                print('\n')

This code resides in the ``utils.py`` file, which all samples import.

.. _create-network:

Create network
~~~~~~~~~~~~~~

The following program creates a network:

.. code:: python

    #!/usr/bin/env python
    from neutronclient.v2_0 import client
    from credentials import get_credentials

    network_name = 'sample_network'
    credentials = get_credentials()
    neutron = client.Client(**credentials)
    try:
        body_sample = {'network': {'name': network_name,
                       'admin_state_up': True}}

        netw = neutron.create_network(body=body_sample)
        net_dict = netw['network']
        network_id = net_dict['id']
        print('Network %s created' % network_id)

        body_create_subnet = {'subnets': [{'cidr': '192.168.199.0/24',
                              'ip_version': 4, 'network_id': network_id}]}

        subnet = neutron.create_subnet(body=body_create_subnet)
        print('Created subnet %s' % subnet)
    finally:
        print("Execution completed")

.. _list-network:

List networks
~~~~~~~~~~~~~

The following program lists networks:

.. code:: python

    #!/usr/bin/env python
    from neutronclient.v2_0 import client
    from credentials import get_credentials
    from utils import print_values

    credentials = get_credentials()
    neutron = client.Client(**credentials)
    netw = neutron.list_networks()

    print_values(netw, 'networks')

For ``print_values``, see :ref:`Print values <print-values>`.

.. _create-ports:

Create ports
~~~~~~~~~~~~

The following program creates a port:

.. code:: python

    #!/usr/bin/env python
    from neutronclient.v2_0 import client
    import novaclient.v1_1.client as nvclient
    from credentials import get_credentials
    from credentials import get_nova_credentials

    credentials = get_nova_credentials()
    nova_client = nvclient.Client(**credentials)

    # Replace with server_id and network_id from your environment

    server_id = '9a52795a-a70d-49a8-a5d0-5b38d78bd12d'
    network_id = 'ce5d204a-93f5-43ef-bd89-3ab99ad09a9a'
    server_detail = nova_client.servers.get(server_id)
    print(server_detail.id)

    if server_detail != None:
        credentials = get_credentials()
        neutron = client.Client(**credentials)

        body_value = {
                         "port": {
                                 "admin_state_up": True,
                                 "device_id": server_id,
                                 "name": "port1",
                                 "network_id": network_id
                          }
                     }
        response = neutron.create_port(body=body_value)
        print(response)

For ``get_nova_credentials``, see :ref:`Get Nova credentials
<get-nova-credentials>`.

For ``get_credentials``, see :ref:`Get credentials <get-credentials>`.

.. _list-ports:

List ports
~~~~~~~~~~

The following program lists ports:

.. code:: python

    #!/usr/bin/env python
    from neutronclient.v2_0 import client
    from credentials import get_credentials
    from utils import print_values

    credentials = get_credentials()
    neutron = client.Client(**credentials)
    ports = neutron.list_ports()
    print_values(ports, 'ports')

For ``get_credentials`` see :ref:`Get credentials <get-credentials>`.

For ``print_values``, see :ref:`Print values <print-values>`.

.. _list-server-ports:

List server ports
~~~~~~~~~~~~~~~~~

The following program lists the ports for a server:

.. code:: python

    #!/usr/bin/env python
    from neutronclient.v2_0 import client
    import novaclient.v1_1.client as nvclient
    from credentials import get_credentials
    from credentials import get_nova_credentials
    from utils import print_values_server

    credentials = get_nova_credentials()
    nova_client = nvclient.Client(**credentials)

    # change these values according to your environment

    server_id = '9a52795a-a70d-49a8-a5d0-5b38d78bd12d'
    network_id = 'ce5d204a-93f5-43ef-bd89-3ab99ad09a9a'
    server_detail = nova_client.servers.get(server_id)
    print(server_detail.id)

    if server_detail is not None:
        credentials = get_credentials()
        neutron = client.Client(**credentials)
        ports = neutron.list_ports()

        print_values_server(ports, server_id, 'ports')
        body_value = {'port': {
            'admin_state_up': True,
            'device_id': server_id,
            'name': 'port1',
            'network_id': network_id,
            }}

        response = neutron.create_port(body=body_value)
        print(response)

.. _create-port-add-port-subnet:

Create router and add port to subnet
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This example queries OpenStack Networking to create a router and add a
port to a subnet.


1. Import the following modules:

.. code:: python

    from neutronclient.v2_0 import client
    import novaclient.v1_1.client as nvclient
    from credentials import get_credentials
    from credentials import get_nova_credentials
    from utils import print_values_server

2. Get Nova Credentials. See :ref:'Get Nova credentials
<get-nova-credentials>'.

3. Instantiate the ``nova_client`` client object by using the
``credentials`` dictionary object:

.. code:: python

    nova_client = nvclient.Client(**credentials)

4. Create a router and add a port to the subnet:

.. code:: python

    # Replace with network_id from your environment

    network_id = '81bf592a-9e3f-4f84-a839-ae87df188dc1'

    credentials = get_credentials()
    neutron = client.Client(**credentials)
    neutron.format = json
    request = {'router': {'name': 'router name',
                          'admin_state_up': True}}

    router = neutron.create_router(request)
    router_id = router['router']['id']
    # for example: '72cf1682-60a8-4890-b0ed-6bad7d9f5466'
    router = neutron.show_router(router_id)
    print(router)
    body_value = {'port': {
        'admin_state_up': True,
        'device_id': router_id,
        'name': 'port1',
        'network_id': network_id,
        }}

    response = neutron.create_port(body=body_value)
    print(response)
    print("Execution Completed")

Create router: complete code listing example
--------------------------------------------

.. code:: python

    #!/usr/bin/env python
    from neutronclient.v2_0 import client
    import novaclient.v1_1.client as nvclient
    from credentials import get_credentials
    from credentials import get_nova_credentials
    from utils import print_values_server

    credentials = get_nova_credentials()
    nova_client = nvclient.Client(**credentials)

    # Replace with network_id from your environment

    network_id = '81bf592a-9e3f-4f84-a839-ae87df188dc1'
    try:
        credentials = get_credentials()
        neutron = client.Client(**credentials)
        neutron.format = 'json'
        request = {'router': {'name': 'router name',
                              'admin_state_up': True}}
        router = neutron.create_router(request)
        router_id = router['router']['id']
        # for example: '72cf1682-60a8-4890-b0ed-6bad7d9f5466'
        router = neutron.show_router(router_id)
        print(router)
        body_value = {'port': {
            'admin_state_up': True,
            'device_id': router_id,
            'name': 'port1',
            'network_id': network_id,
            }}

        response = neutron.create_port(body=body_value)
        print(response)
    finally:
        print("Execution completed")

.. _delete-network:

Delete a network
~~~~~~~~~~~~~~~~

This example queries OpenStack Networking to delete a network.

To delete a network

1. Import the following modules:

.. code:: python

    from neutronclient.v2_0 import client
    from credentials import get_credentials

2. Get credentials. See :ref:`Get Nova credentials <get-nova-credentials>`.

3. Instantiate the ``neutron`` client object by using the ``credentials``
dictionary object:

.. code:: python

    neutron = client.Client(**credentials)

4. Delete the network:

.. code:: python

    body_sample = {'network': {'name': network_name,
                   'admin_state_up': True}}

    netw = neutron.create_network(body=body_sample)
    net_dict = netw['network']
    network_id = net_dict['id']
    print('Network %s created' % network_id)

    body_create_subnet = {'subnets': [{'cidr': '192.168.199.0/24',
                          'ip_version': 4, 'network_id': network_id}]}

    subnet = neutron.create_subnet(body=body_create_subnet)
    print('Created subnet %s' % subnet)

    neutron.delete_network(network_id)
    print('Deleted Network %s' % network_id)

    print("Execution completed")

Delete network: complete code listing example
---------------------------------------------

.. code:: python

    #!/usr/bin/env python
    from neutronclient.v2_0 import client
    from credentials import get_credentials

    network_name = 'temp_network'
    credentials = get_credentials()
    neutron = client.Client(**credentials)
    try:
        body_sample = {'network': {'name': network_name,
                       'admin_state_up': True}}

        netw = neutron.create_network(body=body_sample)
        net_dict = netw['network']
        network_id = net_dict['id']
        print('Network %s created' % network_id)

        body_create_subnet = {'subnets': [{'cidr': '192.168.199.0/24',
                              'ip_version': 4, 'network_id': network_id}]}

        subnet = neutron.create_subnet(body=body_create_subnet)
        print('Created subnet %s' % subnet)

        neutron.delete_network(network_id)
        print('Deleted Network %s' % network_id)
    finally:
        print("Execution Completed")

.. _list-routers:

List routers
~~~~~~~~~~~~

This example queries OpenStack Networking to list all routers.

1. Import the following modules:

.. code:: python

    from neutronclient.v2_0 import client
    from credentials import get_credentials
    from utils import print_values

2. Get credentials. See :ref:`Get Nova credentials <get-nova-credentials>`.

3. Instantiate the ``neutron`` client object by using the ``credentials``
dictionary object:

.. code:: python

    neutron = client.Client(**credentials)

4. List the routers:

.. code:: python

    routers_list = neutron.list_routers(retrieve_all=True)
    print_values(routers_list, 'routers')
    print("Execution completed")

For ``print_values``, see :ref:`Print values <print-values>`.

List routers: complete code listing example
-------------------------------------------

.. code:: python

    #!/usr/bin/env python
    from neutronclient.v2_0 import client
    from credentials import get_credentials
    from utils import print_values

    try:
        credentials = get_credentials()
        neutron = client.Client(**credentials)
        routers_list = neutron.list_routers(retrieve_all=True)
        print_values(routers_list, 'routers')
    finally:
        print("Execution completed")

.. _list-security-groups:

List security groups
~~~~~~~~~~~~~~~~~~~~

This example queries OpenStack Networking to list security groups.

1. Import the following modules:

.. code:: python

    from neutronclient.v2_0 import client
    from credentials import get_credentials
    from utils import print_values

2. Get credentials. See :ref:`Get credentials <get-credentials>`.

3. Instantiate the ``neutron`` client object by using the ``credentials``
dictionary object:

.. code:: python

    neutron = client.Client(**credentials)

4. List Security groups

.. code:: python

    sg = neutron.list_security_groups()
    print(sg)

List security groups: complete code listing example
---------------------------------------------------

.. code:: python

    #!/usr/bin/env python
    from neutronclient.v2_0 import client
    from credentials import get_credentials
    from utils import print_values

    credentials = get_credentials()
    neutron = client.Client(**credentials)
    sg = neutron.list_security_groups()
    print(sg)

    **Note**

    OpenStack Networking security groups are case-sensitive while the
    nova-network security groups are case-insensitive.

.. _list-subnets:

List subnets
~~~~~~~~~~~~

This example queries OpenStack Networking to list subnets.

1. Import the following modules:

.. code:: python

    from neutronclient.v2_0 import client
    from credentials import get_credentials
    from utils import print_values

2. Get credentials. See :ref:'Get credentials <get-credentials>'.

3. Instantiate the ``neutron`` client object by using the ``credentials``
dictionary object:

.. code:: python

    neutron = client.Client(**credentials)

4. List subnets:

.. code:: python

    subnets = neutron.list_subnets()
    print(subnets)

List subnets: complete code listing example
-------------------------------------------
.. code:: python

    #!/usr/bin/env python
    from neutronclient.v2_0 import client
    from credentials import get_credentials
    from utils import print_values

    credentials = get_credentials()
    neutron = client.Client(**credentials)
    subnets = neutron.list_subnets()
    print(subnets)
