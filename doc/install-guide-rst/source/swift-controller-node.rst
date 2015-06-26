=========================================
Install and configure the controller node
=========================================

This section describes how to install and configure the proxy service that
handles requests for the account, container, and object services operating
on the storage nodes. For simplicity, this guide installs and configures
the proxy service on the controller node. However, you can run the proxy
service on any node with network connectivity to the storage nodes.
Additionally, you can install and configure the proxy service on multiple
nodes to increase performance and redundancy. For more information, see the
`Deployment Guide <http://docs.openstack.org/developer/swift/deployment_guide.html>`__.

To configure prerequisites
~~~~~~~~~~~~~~~~~~~~~~~~~~

The proxy service relies on an authentication and authorization mechanism such
as the Identity service. However, unlike other services, it also offers an
internal mechanism that allows it to operate without any other OpenStack
services. However, for simplicity, this guide references the Identity service
in :doc:`keystone`. Before you configure the Object Storage service, you must
create service credentials and an API endpoint.

.. note::

   The Object Storage service does not use a SQL database on the controller
   node. Instead, it uses distributed SQLite databases on each storage node.

#. Source the ``admin`` credentials to gain access to admin-only CLI commands:

   .. code-block:: console

      $ source admin-openrc.sh

#. To create the Identity service credentials, complete these steps:

   * Create the ``swift`` user:

     .. code-block:: console

        $ openstack user create --password-prompt swift
        User Password:
        Repeat User Password:
        +----------+----------------------------------+
        | Field    | Value                            |
        +----------+----------------------------------+
        | email    | None                             |
        | enabled  | True                             |
        | id       | d535e5cbd2b74ac7bfb97db9cced3ed6 |
        | name     | swift                            |
        | username | swift                            |
        +----------+----------------------------------+

   * Add the ``admin`` role to the ``swift`` user:

     .. code-block:: console

        $ openstack role add --project service --user swift admin
        +-------+----------------------------------+
        | Field | Value                            |
        +-------+----------------------------------+
        | id    | cd2cb9a39e874ea69e5d4b896eb16128 |
        | name  | admin                            |
        +-------+----------------------------------+

   * Create the ``swift`` service entity:

     .. code-block:: console

        $ openstack service create --name swift \
          --description "OpenStack Object Storage" object-store
        +-------------+----------------------------------+
        | Field       | Value                            |
        +-------------+----------------------------------+
        | description | OpenStack Object Storage         |
        | enabled     | True                             |
        | id          | 75ef509da2c340499d454ae96a2c5c34 |
        | name        | swift                            |
        | type        | object-store                     |
        +-------------+----------------------------------+

#. Create the Object Storage service API endpoint:

   .. code-block:: console

      $ openstack endpoint create \
        --publicurl 'http://controller:8080/v1/AUTH_%(tenant_id)s' \
        --internalurl 'http://controller:8080/v1/AUTH_%(tenant_id)s' \
        --adminurl http://controller:8080 \
        --region RegionOne \
        object-store
      +--------------+----------------------------------------------+
      | Field        | Value                                        |
      +--------------+----------------------------------------------+
      | adminurl     | http://controller:8080/                      |
      | id           | af534fb8b7ff40a6acf725437c586ebe             |
      | internalurl  | http://controller:8080/v1/AUTH_%(tenant_id)s |
      | publicurl    | http://controller:8080/v1/AUTH_%(tenant_id)s |
      | region       | RegionOne                                    |
      | service_id   | 75ef509da2c340499d454ae96a2c5c34             |
      | service_name | swift                                        |
      | service_type | object-store                                 |
      +--------------+----------------------------------------------+

To install and configure the controller node components
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. note::

   Default configuration files vary by distribution. You might need
   to add these sections and options rather than modifying existing
   sections and options. Also, an ellipsis (...) in the configuration
   snippets indicates potential default configuration options that you
   should retain.

#. Install the packages:

   .. note::

      Complete OpenStack environments already include some of these
      packages.

   .. only:: ubuntu or debian

      .. code-block:: console

         # apt-get install swift swift-proxy python-swiftclient python-keystoneclient \
           python-keystonemiddleware memcached

   .. only:: rdo

      .. code-block:: console

         # yum install openstack-swift-proxy python-swiftclient python-keystone-auth-token \
           python-keystonemiddleware memcached

   .. only:: obs

      .. code-block:: console

         # zypper install openstack-swift-proxy python-swiftclient python-keystoneclient \
           python-keystonemiddleware python-xml memcached

.. only:: ubuntu or debian

   2. Create the :file:`/etc/swift` directory.

   3. Obtain the proxy service configuration file from the Object Storage
      source repository:

      .. code-block:: console

         # curl -o /etc/swift/proxy-server.conf \
           https://git.openstack.org/cgit/openstack/swift/plain/etc/ \
           proxy-server.conf-sample?h=stable/kilo

.. only:: rdo

   2. Obtain the proxy service configuration file from the Object Storage
      source repository:

      .. code-block:: console

         # curl -o /etc/swift/proxy-server.conf \
           https://git.openstack.org/cgit/openstack/swift/plain/etc/ \
           proxy-server.conf-sample?h=stable/kilo

.. only:: obs

   2. .. include:: swift-controller-node-include.txt

.. only:: rdo

   3.  .. include:: swift-controller-node-include.txt

.. only:: ubuntu

   4.  .. include:: swift-controller-node-include.txt
