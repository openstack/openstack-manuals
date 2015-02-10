===========================================
Configure access and security for instances
===========================================

When working with images in the SDK, you will call ``novaclient``
methods.

.. _add-keypair:

Add a keypair
~~~~~~~~~~~~~

To generate a keypair, call the
`novaclient.v1\_1.keypairs.KeypairManager.create <http://docs.
openstack.org/developer/python-novaclient/api/novaclient.v1_1.keypairs
.html#novaclient.v1_1.keypairs.KeypairManager.create>`__ method:

.. code:: python

    import novaclient.v1_1.client as nvclient
    nova = nvclient.Client(...)
    keypair_name = "staging"
    keypair = nova.keypairs.create(name=keypair_name)
    print keypair.private_key

The Python script output looks something like this:

::

    -----BEGIN RSA PRIVATE KEY-----
    MIIEowIBAAKCAQEA8XkaMqInSPfy0hMfWO+OZRtIgrQAbQkNcaNHmv2GN2G6xZlb\nuBRux5Xk/6SZ
    ABaNPm1nRWm/ZDHnxCsFTcAl2LYOQXx3Cl2qKNY4r2di4G48GAkd\n7k5lDP2RgQatUM8npO0CD9PU
    ...
    mmrceYYK08/lQ7JKLmVkdzdQKt77+v1oBBuHiykLfI6h1m77NRDw9r8cV\nzczYeoALifpjTPMkKS8
    ECfDCuDn/vc9K1He8CRaJHf8AMLQLM3MN
    -----END RSA PRIVATE KEY-----

You typically write the private key to a file to use it later. The
file must be readable and writeable by only the file owner; otherwise,
the SSH client will refuse to read the private key file. The safest way
is to create the file with the appropriate permissions, as shown in the
following example:

.. code:: python

    import novaclient.v1_1.client as nvclient
    import os
    nova = nvclient.Client(...)
    keypair_name = "staging"
    private_key_filename = "/home/alice/id-staging"
    keypair = nova.keypairs.create(name=keypair_name)

    # Create a file for writing that can only be read and written by
    owner
    fp = os.open(private_key_filename, os.O_WRONLY | os.O_CREAT, 0o600)
    with os.fdopen(fp, 'w') as f:
        f.write(keypair.private_key)

.. _import-keypair:

Import a keypair
~~~~~~~~~~~~~~~~

If you have already generated a keypair with the public key located at
``~/.ssh/id_rsa.pub``, pass the contents of the file to the
`novaclient.v1\_1.keypairs.KeypairManager.create <http://docs.
openstack.org/developer/python-novaclient/api/novaclient.v1_1.keypairs
.html#novaclient.v1_1.keypairs.KeypairManager.create>`__ method to
import the public key to Compute:

.. code:: python

    import novaclient.v1_1.client as nvclient
    import os.path
    with open(os.path.expanduser('~/.ssh/id_rsa.pub')) as f:
        public_key = f.read()
    nova = nvclient.Client(...)
    nova.keypairs.create('mykey', public_key)

.. _list-keypair:

List keypairs
~~~~~~~~~~~~~

To list keypairs, call the
`novaclient.v1\_1.keypairs.KeypairManager.list <http://docs.openstack.
org/developer/python-novaclient/api/novaclient.v1_1.keypairs.html
#novaclient.v1_1.keypairs.KeypairManager.list>`__ method:

.. code:: python

    import novaclient.v1_1.client as nvclient
    nova = nvclient.Client(...)
    keypairs = nova.keypairs.list()

.. _create-manage-security-groups:

Create and manage security groups
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To list security groups for the current project, call the
`novaclient.v\_1.security\_groups.SecurityGroupManager.list
<http://docs.openstack.org/developer/python-novaclient/api/novaclient
.v1_1.security_groups.html#novaclient.v1_1.security_groups.
SecurityGroupManager.list>`__ method:

.. code:: python

    import novaclient.v1_1.client as nvclient
    nova = nvclient.Client(...)
    security_groups = nova.security_groups.list()

To create a security group with a specified name and description, call
the `novaclient.v\_1.security\_groups.SecurityGroupManager.create
<http://docs.openstack.org/developer/python-novaclient/api/novaclient.
v1_1.security_groups.html#novaclient.v1_1.security_groups.
SecurityGroupManager.create>`__ method:

.. code:: python

    import novaclient.v1_1.client as nvclient
    nova = nvclient.Client(...)
    nova.security_groups.create(name="web", description="Web servers")

To delete a security group, call the
`novaclient.v\_1.security\_groups.SecurityGroupManager.delete
<http://docs.openstack.org/developer/python-novaclient/api/novaclient.
v1_1.security_groups.html#novaclient.v1_1.security_groups.
SecurityGroupManager.delete>`__ method, passing either a
`novaclient.v1\_1.security\_groups.SecurityGroup
<http://docs.openstack.org/developer/python-novaclient/api/novaclient
.v1_1.security_groups.html#novaclient.v1_1.security_groups.
SecurityGroup>`__ object or group ID as an argument:

.. code:: python

    import novaclient.v1_1.client as nvclient
    nova = nvclient.Client(...)
    group = nova.security_groups.find(name="web")
    nova.security_groups.delete(group)
    # The following lines would also delete the group:
    # nova.security_groups.delete(group.id)
    # group.delete()

.. _create-manage-security-group-rules:

Create and manage security group rules
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Access the security group rules from the ``rules`` attribute of a
`novaclient.v1\_1.security\_groups.SecurityGroup <http://docs.
openstack.org/developer/python-novaclient/api/novaclient.v1_1.security
_groups.html#novaclient.v1_1.security_groups.SecurityGroup>`__ object:

.. code:: python

    import novaclient.v1_1.client as nvclient
    nova = nvclient.Client(...)
    group = nova.security_groups.find(name="web")
    print group.rules

To add a rule to a security group, call the
`novaclient.v1\_1.security\_group\_rules.SecurityGroupRuleManager.
create <http://docs.openstack.org/developer/python-novaclient/api/
novaclient.v1_1.security_group_rules.html#novaclient.v1_1.
security_group_rules.SecurityGroupRuleManager.create>`__ method:

.. code:: python

    import novaclient.v1_1.client as nvclient
    nova = nvclient.Client(...)
    group = nova.security_groups.find(name="web")
    # Add rules for ICMP, tcp/80 and tcp/443
    nova.security_group_rules.create(group.id, ip_protocol="icmp",
                                     from_port=-1, to_port=-1)
    nova.security_group_rules.create(group.id, ip_protocol="tcp",
                                     from_port=80, to_port=80)
    nova.security_group_rules.create(group.id, ip_protocol="tcp",
                                     from_port=443, to_port=443)
