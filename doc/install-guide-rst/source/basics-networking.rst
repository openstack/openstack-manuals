Networking
~~~~~~~~~~

.. only:: ubuntu

   After installing the operating system on each node for the architecture
   that you choose to deploy, you must configure the network interfaces. We
   recommend that you disable any automated network management tools and
   manually edit the appropriate configuration files for your distribution.
   For more information on how to configure networking on your
   distribution, see the `documentation <https://help.ubuntu.com/lts/serverguide/network-configuration.html>`__ .

.. only:: debian

   After installing the operating system on each node for the architecture
   that you choose to deploy, you must configure the network interfaces. We
   recommend that you disable any automated network management tools and
   manually edit the appropriate configuration files for your distribution.
   For more information on how to configure networking on your
   distribution, see the `documentation <https://wiki.debian.org/NetworkConfiguration>`__ .

.. only:: rdo

   After installing the operating system on each node for the architecture
   that you choose to deploy, you must configure the network interfaces. We
   recommend that you disable any automated network management tools and
   manually edit the appropriate configuration files for your distribution.
   For more information on how to configure networking on your
   distribution, see the `documentation <https://access.redhat.com/site/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Deployment_Guide/s1-networkscripts-interfaces.html>`__ .

.. only:: obs

   After installing the operating system on each node for the architecture
   that you choose to deploy, you must configure the network interfaces. We
   recommend that you disable any automated network management tools and
   manually edit the appropriate configuration files for your distribution.
   For more information on how to configure networking on your
   distribution, see the `SLES 12 <https://www.suse.com/documentation/sles-12/book_sle_admin/data/sec_basicnet_manconf.html>`__ or `openSUSE <http://activedoc.opensuse.org/book/opensuse-reference/chapter-13-basic-networking>`__ documentation.

All nodes require Internet access for administrative purposes such as
package installation, security updates, :term:`DNS`, and
:term:`Network Time Protocol (NTP)`. In most cases,
nodes should obtain Internet access through the management network
interface. To highlight the importance of network separation, the
example architectures use `private address
space <https://tools.ietf.org/html/rfc1918>`__ for the management
network and assume that network infrastructure provides Internet access
via :term:`Network Address Translation (NAT)`. To illustrate the flexibility
of :term:`IaaS`, the example architectures use public IP address space
for the external network and assume that network infrastructure provides
direct Internet access to instances in your OpenStack environment.
In environments with only one block of public IP address space,
both the management and external networks must ultimately obtain Internet
access using it. For simplicity, the diagrams in this guide only show
Internet access for OpenStack services.

.. only:: obs

   **To disable Network Manager**

   * Use the YaST network module:

     .. code-block:: console

        # yast2 network

     For more information, see the
     `SLES <https://www.suse.com/documentation/sles-12/book_sle_admin/data/sec_nm_activate.html>`__
     or the `openSUSE <http://activedoc.opensuse.org/book/opensuse-reference/chapter-13-basic-networking#sec.basicnet.yast.netcard.global>`__ documentation.

.. note::

   .. only:: rdo or obs

      Your distribution enables a restrictive :term:`firewall` by
      default. During the installation process, certain steps will
      fail unless you alter or disable the firewall. For more
      information about securing your environment, refer to the
      `OpenStack Security Guide <http://docs.openstack.org/sec/>`__.

   .. only:: ubuntu or debian

      Your distribution does not enable a restrictive :term:`firewall`
      by default. For more information about securing your environment,
      refer to the
      `OpenStack Security Guide <http://docs.openstack.org/sec/>`__.

.. include:: basics-networking-neutron.rst
.. include:: basics-networking-nova.rst

.. toctree::
   :hidden:

   basics-networking-neutron.rst
   basics-networking-nova.rst
