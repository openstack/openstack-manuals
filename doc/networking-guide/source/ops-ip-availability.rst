.. _ops-ip-availability:

=======================
IP availability metrics
=======================

Network IP Availability is an information-only API extension that allows
a user or process to determine the number of IP addresses that are consumed
across networks and the allocation pools of their subnets. This extension was
added to neutron in the Mitaka release.

This section illustrates how you can get the Network IP address availability
through the command-line interface.

Get Network IP address availability for all IPv4 networks:

.. code-block:: console

   $ neutron net-ip-availability-list

   +--------------------------------------+--------------+-----------+----------+
   | network_id                           | network_name | total_ips | used_ips |
   +--------------------------------------+--------------+-----------+----------+
   | 363a611a-b08b-4281-b64e-198d90cb94fd | private      |       253 |        3 |
   | c92d0605-caf2-4349-b1b8-8d5f9ac91df8 | public       |       253 |        1 |
   +--------------------------------------+--------------+-----------+----------+

Get Network IP address availability for all IPv6 networks:

.. code-block:: console

   $ neutron net-ip-availability-list --ip-version 6

   +--------------------------------------+--------------+----------------------+----------+
   | network_id                           | network_name | total_ips            | used_ips |
   +--------------------------------------+--------------+----------------------+----------+
   | 363a611a-b08b-4281-b64e-198d90cb94fd | private      | 18446744073709551614 |        3 |
   | c92d0605-caf2-4349-b1b8-8d5f9ac91df8 | public       | 18446744073709551614 |        1 |
   +--------------------------------------+--------------+----------------------+----------+

Get Network IP address availability statistics for a specific network:

.. code-block:: console

   $ neutron net-ip-availability-show NETWORKUUID

   +------------------------+----------------------------------------------------------------------------------+
   | Field                  | Value                                                                            |
   +------------------------+----------------------------------------------------------------------------------+
   | network_id             | 363a611a-b08b-4281-b64e-198d90cb94fd                                             |
   | network_name           | private                                                                          |
   | subnet_ip_availability | {"used_ips": 3, "subnet_id": "843ee06f-b81b-49b0-81e6-2ac38a37a57b"              |
   |                        | "subnet_name": "private-subnet", "ip_version": 4, "cidr": "10.0.0.0/24",         |
   |                        | "total_ips": 253}                                                                |
   |                        | {"used_ips": 3, "subnet_id": "ce5be0cf-fb4c-49e4-9446-7c10592962ff",             |
   |                        | "subnet_name": "ipv6-private-subnet", "ip_version": 6, "cidr":                   |
   |                        | "fd2d:7235:6ead::/64", "total_ips": 18446744073709551614}                        |
   | tenant_id              | 644747a9234943d4b4be1b3388ac86ae                                                 |
   | total_ips              | 18446744073709551867                                                             |
   | used_ips               | 6                                                                                |
   +------------------------+----------------------------------------------------------------------------------+
