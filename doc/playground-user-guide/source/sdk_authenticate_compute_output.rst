=======
Compute
=======

To use the information in this section, you must be familiar with
OpenStack Compute.

Set environment variables
~~~~~~~~~~~~~~~~~~~~~~~~~

To set up environmental variables and authenticate against Compute API
endpoints, see :role:`Authenticate <sdk_authenticate.rst>`.

.. _get-openstack-credentials:

Get OpenStack credentials (API v2)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This example uses the ``get_nova_credentials_v2`` method:

.. code:: python

    def get_nova_credentials_v2():
        d = {}
        d['version'] = '2'
        d['username'] = os.environ['OS_USERNAME']
        d['api_key'] = os.environ['OS_PASSWORD']
        d['auth_url'] = os.environ['OS_AUTH_URL']
        d['project_id'] = os.environ['OS_TENANT_NAME']
        return d

This code resides in the ``credentials.py`` file, which all samples
import.

Use the ``get_nova_credentials_v2()`` method to populate and get a
dictionary:

.. code:: python

    credentials = get_nova_credentials_v2()

List servers (API v2)
~~~~~~~~~~~~~~~~~~~~~

The following program lists servers by using the Compute API v2.

1. Import the following modules:

.. code:: python

    from credentials import get_nova_credentials_v2
    from novaclient.client import Client

2. Get Nova credentials. See :ref:`Get OpenStack credentials (API v2)
<get-openstack-credentials>`.

3. Instantiate the ``nova_client`` client object by using the
``credentials`` dictionary object:

.. code:: python

    nova_client = Client(**credentials)

4. List servers by calling ``servers.list`` on ``nova_client`` object:

.. code:: python

    print(nova_client.servers.list())

List server code listing example
--------------------------------

.. code:: python

    #!/usr/bin/env python
    from credentials import get_nova_credentials_v2
    from novaclient.client import Client

    credentials = get_nova_credentials_v2()
    nova_client = Client(**credentials)

    print(nova_client.servers.list())

Create server (API v2)
~~~~~~~~~~~~~~~~~~~~~~

The following program creates a server (VM) by using the Compute API v2.

1. Import the following modules:

.. code:: python

    import time
    from credentials import get_nova_credentials_v2
    from novaclient.client import Client

2. Get OpenStack credentials. See :ref:`Get OpenStack credentials (API v2)
<get-openstack-credentials>`.

3. Instantiate the ``nova_client`` client object by using the
``credentials`` dictionary object:

.. code:: python

    nova_client = Client(**credentials)

4. Get the flavor and image to use to create a server. This code uses
the ``cirros`` image, the ``m1.tiny`` flavor, and the ``private``
network:

.. code:: python

    image = nova_client.images.find(name="cirros")
    flavor = nova_client.flavors.find(name="m1.tiny")
    net = nova_client.networks.find(label="private")

5. To create the server, use the network, image, and flavor:

.. code:: python

    nics = [{'net-id': net.id}]
    instance = nova_client.servers.create(name="vm2", image=image,
    flavor=flavor, key_name="keypair-1", nics=nics)

6.  Run the "Sleep for five seconds" command, and determine whether
the server/vm was
created by calling ``nova_client.servers.list()``:

.. code:: python

    print("Sleeping for 5s after create command")
    time.sleep(5)
    print("List of VMs")
    print(nova_client.servers.list())

Create server code listing example
----------------------------------

.. code:: python

    #!/usr/bin/env python
    import time
    from credentials import get_nova_credentials_v2
    from novaclient.client import Client

    try:
        credentials = get_nova_credentials_v2()
        nova_client = Client(**credentials)

        image = nova_client.images.find(name="cirros")
        flavor = nova_client.flavors.find(name="m1.tiny")
        net = nova_client.networks.find(label="private")
        nics = [{'net-id': net.id}]
        instance = nova_client.servers.create(name="vm2", image=image,
                                          flavor=flavor, key_name="keypair-1", nics=nics)
        print("Sleeping for 5s after create command")
        time.sleep(5)
        print("List of VMs")
        print(nova_client.servers.list())
    finally:
        print("Execution Completed")

Delete server (API v2)
~~~~~~~~~~~~~~~~~~~~~~

The following program deletes a server (VM) by using the Compute API v2.

1. Import the following modules:

.. code:: python

    import time
    from credentials import get_nova_credentials_v2
    from novaclient.client import Client

2. Get Nova credentials. See :ref:`Get OpenStack credentials (API v2)
<get-openstack-credentials>`.

3. Instantiate the ``nova_client`` client object by using the
``credentials`` dictionary object:

.. code:: python

    nova_client = Client(**credentials)

4. Determine whether the ``vm1`` server exists:

   a. List servers: ``servers_list``.

   b. Iterate over ``servers_list`` and compare name with ``vm1``.

   c. If true, set the variable name ``server_exists`` to ``True``
   and break from the for loop:

.. code:: python

    servers_list = nova_client.servers.list()
    server_del = "vm1"
    server_exists = False

    for s in servers_list:
        if s.name == server_del:
            print("This server %s exists" % server_del)
            server_exists = True
            break


5. If the server exists, run the ``delete`` method of the
``nova_client.servers`` object:

.. code:: python

    nova_client.servers.delete(s)

Delete server code example
--------------------------

.. code:: python

    #!/usr/bin/env python
    from credentials import get_nova_credentials_v2
    from novaclient.client import Client

    credentials = get_nova_credentials_v2()
    nova_client = Client(**credentials)

    servers_list = nova_client.servers.list()
    server_del = "vm1"
    server_exists = False

    for s in servers_list:
        if s.name == server_del:
            print("This server %s exists" % server_del)
            server_exists = True
            break
    if not server_exists:
        print("server %s does not exist" % server_del)
    else:
        print("deleting server..........")
        nova_client.servers.delete(s)
        print("server %s deleted" % server_del)

Update server (API v2)
~~~~~~~~~~~~~~~~~~~~~~

The following program updates the name of a server (VM) by using the
Compute API v2.

1. Import the following modules:

.. code:: python

    from credentials import get_nova_credentials_v2
    from novaclient.client import Client
    from utils import print_server

``print_server`` is a method defined in ``utils.py`` and prints the
server details as shown in the code listing below:

.. code:: python

    def print_server(server):
        print("-"*35)
        print("server id: %s" % server.id)
        print("server name: %s" % server.name)
        print("server image: %s" % server.image)
        print("server flavor: %s" % server.flavor)
        print("server key name: %s" % server.key_name)
        print("user_id: %s" % server.user_id)
        print("-"*35)

2. Get OpenStack Credentials. See :ref:`Get OpenStack credentials
(API v2) <get-openstack-credentials>`.


3. Instantiate the ``nova_client`` client object by using the
``credentials`` dictionary object:

.. code:: python

    nova_client = Client(**credentials)


4. Get the server instance using ``server_id`` and print the details by
calling ``print_server`` method:

.. code:: python

    server_id = '99889c8d-113f-4a7e-970c-77f1916bfe14'
    server = nova_client.servers.get(server_id)
    n = server.name
    print_server(server)


5. Call ``server.update`` on the server object with the new value for
``name`` variable:

.. code:: python

    server.update(name = n + '1')

6. Get the updated instance of the server:

.. code:: python

    server_updated = nova_client.servers.get(server_id)

7. Call ``print_server`` again to check the update server details:

.. code:: python

    print_server(server_updated)

Update server code listing example
----------------------------------

.. code:: python

    #!/usr/bin/env python

    from credentials import get_nova_credentials_v2
    from novaclient.client import Client
    from utils import print_server

    credentials = get_nova_credentials_v2()
    nova_client = Client(**credentials)

    # Change the server_id specific to your environment

    server_id = '99889c8d-113f-4a7e-970c-77f1916bfe14'
    server = nova_client.servers.get(server_id)
    n = server.name
    print_server(server)

    server.update(name=n +'1')
    server_updated = nova_client.servers.get(server_id)
    print_server(server_updated)

List flavors (API v2)
~~~~~~~~~~~~~~~~~~~~~

The following program lists flavors and their details by using the
Compute API v2.

1. Import the following modules:

.. code:: python

    from credentials import get_nova_credentials_v2
    from novaclient.client import Client
    from utils import print_flavors

The ``print_flavors`` method is defined in ``utils.py`` and prints the
flavor details:

.. code:: python

    def print_flavors(flavor_list):
        for flavor in flavor_list:
           print("-"*35)
           print("flavor id : %s" % flavor.id)
           print("flavor name : %s" % flavor.name)
        print("-"*35)

2. Get OpenStack credentials. :ref:`Get OpenStack credentials
(API v2) <get-openstack-credentials>`.


3. Instantiate the ``nova_client`` client object by using the
``credentials`` dictionary object:

.. code:: python

    nova_client = Client(**credentials)

4. List flavors by calling ``list()`` on ``nova_client.flavors`` object:

.. code:: python

    flavors_list =  nova_client.flavors.list()

5. Print the flavor details, id and name by calling ``print_flavors``:

.. code:: python

    print_flavors(flavors_list)

List flavors code listing example
---------------------------------

.. code:: python

    #!/usr/bin/env python

    from credentials import get_nova_credentials_v2
    from novaclient.client import Client
    from utils import print_flavors

    credentials = get_nova_credentials_v2()
    nova_client = Client(**credentials)

    flavors_list = nova_client.flavors.list()
    print_flavors(flavors_list)

List floating IPs (API v2)
~~~~~~~~~~~~~~~~~~~~~~~~~~

The following program lists the floating IPs and their details by using
the Compute API v2.

1. Import the following modules:

.. code:: python

    from credentials import get_nova_credentials_v2
    from novaclient.client import Client
    from utils import print_values_ip

The ``print_values_ip`` method is defined in ``utils.py`` and prints the
floating\_ip object details:

.. code:: python

    def print_values_ip(ip_list):
        ip_dict_lisl = []
        for ip in ip_list:
            print("-"*35)
            print("fixed_ip : %s" % ip.fixed_ip)
            print("id : %s" % ip.id)
            print("instance_id : %s" % ip.instance_id)
            print("ip : %s" % ip.ip)
            print("pool : %s" % ip.pool)

2. Get OpenStack credentials. See :ref:`Get OpenStack credentials
(API v2) <get-openstack-credentials>`.


3. Instantiate the ``nova_client`` client object by using the
``credentials`` dictionary object:

.. code:: python

    nova_client = Client(**credentials)


4. List floating IPs by calling ``list()`` on ``nova_client.floating_ips``
object:

.. code:: python

    ip_list = nova_client.floating_ips.list()

5. Print the floating IP object details by calling ``print_values_ip``:

.. code:: python

    print_values_ip(ip_list)

List floating IPs code listing example
--------------------------------------

.. code:: python

    #!/usr/bin/env python

    from credentials import get_nova_credentials_v2
    from novaclient.client import Client
    from utils import print_values_ip

    credentials = get_nova_credentials_v2()
    nova_client = Client(**credentials)
    ip_list = nova_client.floating_ips.list()
    print_values_ip(ip_list)

List hosts (API v2)
~~~~~~~~~~~~~~~~~~~

The following program lists the hosts by using the Compute API v2.

1. Import the following modules:

.. code:: python

    from credentials import get_nova_credentials_v2
    from novaclient.client import Client
    from utils import print_hosts

The ``print_hosts`` method is defined in ``utils.py`` and prints the
host object details:

.. code:: python

    def print_hosts(host_list):
        for host in host_list:
           print("-"*35)
           print("host_name : %s" % host.host_name)
           print("service : %s" % host.service)
           print("zone : %s" % host.zone)
        print("-"*35)

2. Get OpenStack credentials. See :ref:`Get OpenStack credentials (API v2)
<get-openstack-credentials>`.

3. Instantiate the ``nova_client`` client object by using the
``credentials`` dictionary object:

.. code:: python

    nova_client = Client(**credentials)

4. List hosts by calling ``list()`` on ``nova_client.hosts`` object:

.. code:: python

    host_list = nova_client.hosts.list()

5. Print the host object details by calling ``print_hosts(host_list)``:

.. code:: python

    print_hosts(host_list)

List hosts code listing example
-------------------------------

.. code:: python

    #!/usr/bin/env python

    from credentials import get_nova_credentials_v2
    from novaclient.client import Client
    from utils import print_hosts

    credentials = get_nova_credentials_v2()
    nova_client = Client(**credentials)
    host_list = nova_client.hosts.list()

    print_hosts(host_list)
