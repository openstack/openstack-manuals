=================
Configure the VIP
=================

You must select and assign a virtual IP address (VIP) that can freely float
between cluster nodes.

This configuration creates ``vip``, a virtual IP address for use by the
API node (``10.0.0.11``).

For ``crmsh``:

.. code-block:: console

   # crm configure primitive vip ocf:heartbeat:IPaddr2 \
     params ip="10.0.0.11" cidr_netmask="24" op monitor interval="30s"

For ``pcs``:

.. code-block:: console

   # pcs resource create vip ocf:heartbeat:IPaddr2 \
     ip="10.0.0.11" cidr_netmask="24" op monitor interval="30s"
