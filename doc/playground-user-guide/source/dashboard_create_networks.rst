==========================
Create and manage networks
==========================

The OpenStack Networking service provides a scalable system for managing
the network connectivity within an OpenStack cloud deployment. It can
easily and quickly react to changing network needs (for example,
creating and assigning new IP addresses).

Networking in OpenStack is complex. This section provides the basic
instructions for creating a network and a router. For detailed
information about managing networks, refer to the `OpenStack Cloud
Administrator
Guide <http://docs.openstack.org/admin-guide-cloud/content/ch_networking.html>`__.

Create a network
~~~~~~~~~~~~~~~~

#. Log in to the dashboard, choose a project, and click Networks.

#. Click Create Network.

#. In the Create Network dialog box, specify the following values.

   :guilabel:`Network` tab

   :guilabel:`Network Name`: Specify a name to identify the network.

   :guilabel:`Subnet` tab

   :guilabel:`Create Subnet`: Select this check box to create a subnet

   You do not have to specify a subnet when you create a network, but if
   you do not specify a subnet, any attached instance receives an Error status.

   :guilabel:`Subnet Name`: Specify a name for the subnet.

   :guilabel:`Network Address`: Specify the IP address for the subnet.

   :guilabel:`IP Version`: Select IPv4 or IPv6.

   :guilabel:`Gateway IP`: Specify an IP address for a specific gateway. This
   parameter is optional.

   :guilabel:`Disable Gateway`: Select this check box to disable a gateway IP
   address.

   :guilabel:`Subnet Detail` tab

   :guilabel:`Enable DHCP`: Select this check box to enable DHCP.

   :guilabel:`Allocation Pools` Specify IP address pools.

   :guilabel:`DNS Name Servers`: Specify a name for the DNS server.

   :guilabel:`Host Routes`: Specify the IP address of host routes.

#. Click :guilabel:`Create`.

   The dashboard shows the network on the :guilabel:`Networks` tab.

Create a router
~~~~~~~~~~~~~~~

#. Log in to the dashboard, choose a project, and click :guilabel:`Routers`.

#. Click :guilabel:`Create Router`.

#. In the :guilabel:`Create Router` dialog box, specify a name for the router
   and click :guilabel:`Create Router`.

   The new router is now displayed in the :guilabel:`Routers` tab.

#. Click the new router's :guilabel:`Set Gateway` button.

#. In the :guilabel:`External Network` field, specify the network to which the
   router will connect, and then click :guilabel:`Set Gateway`.

Connect a router
~~~~~~~~~~~~~~~~

#. To connect a private network to the newly created router, on the
   :guilabel:`Routers` tab, click the name of the router.

#. On the :guilabel:`Router Details` page, click :guilabel:`Add Interface`.

#. In the :guilabel:`Add Interface` dialog box, select a :guilabel:`Subnet`.

#. Optionally, in the :guilabel:`Add Interface` dialog box, set an
   :guilabel:`IP Address` for the router interface for the selected subnet.

   If you choose not to set the the :guilabel:`IP Address` value, then by
   default OpenStack Networking uses the first host IP address in the subnet.

   The :guilabel:`Router Name` and :guilabel:`Router ID` fields are
   automatically updated.

#. Click :guilabel:`Add Interface`.

You have successfully created the router. You can view the new topology
from the :guilabel:`Network Topology` tab.


