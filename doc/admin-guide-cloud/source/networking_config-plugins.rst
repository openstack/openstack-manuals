======================
Plug-in configurations
======================

For configurations options, see `Networking configuration
options <http://docs.openstack.org/kilo/config-reference
/content/section_networking-options-reference.html>`__
in Configuration Reference. These sections explain how to configure
specific plug-ins.

Configure Big Switch (Floodlight REST Proxy) plug-in
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Edit the :file:`/etc/neutron/neutron.conf` file and add this line:

   .. code:: ini

      core_plugin = bigswitch

#. In the :file:`/etc/neutron/neutron.conf` file, set the ``service_plugins``
   option:

   ::

      service_plugins = neutron.plugins.bigswitch.l3_router_plugin.L3RestProxy

#. Edit the :file:`/etc/neutron/plugins/bigswitch/restproxy.ini` file for the
   plug-in and specify a comma-separated list of controller\_ip:port pairs:

   .. code:: ini

      server = CONTROLLER_IP:PORT

   For database configuration, see `Install Networking
   Services <http://docs.openstack.org/kilo/install-guide/install
   /apt/content/neutron-controller-node.html>`__
   in the Installation Guide in the `OpenStack Documentation
   index <http://docs.openstack.org>`__. (The link defaults to the Ubuntu
   version.)

#. Restart neutron-server to apply the settings:

   .. code:: console

       # service neutron-server restart

Configure Brocade plug-in
~~~~~~~~~~~~~~~~~~~~~~~~~

#. Install the Brocade-modified Python netconf client (ncclient) library,
   which is available at https://github.com/brocade/ncclient:

   .. code:: console

       $ git clone https://github.com/brocade/ncclient

#. As root, run this command:

   .. code:: console

       # cd ncclient;python setup.py install

#. Edit the :file:`/etc/neutron/neutron.conf` file and set the following
   option:

   .. code:: ini

       core_plugin = brocade

#. Edit the :file:`/etc/neutron/plugins/brocade/brocade.ini` file for the
   Brocade plug-in and specify the admin user name, password, and IP
   address of the Brocade switch:

   .. code:: ini

       [SWITCH]
       username = ADMIN
       password = PASSWORD
       address  = SWITCH_MGMT_IP_ADDRESS
       ostype   = NOS

   For database configuration, see `Install Networking
   Services <http://docs.openstack.org/kilo/install-guide/install/apt
   /content/neutron-controller-node.html>`__
   in any of the Installation Guides in the `OpenStack Documentation
   index <http://docs.openstack.org>`__. (The link defaults to the Ubuntu
   version.)

#. Restart the neutron-server service to apply the settings:

   .. code:: console

       # service neutron-server restart

Configure NSX-mh plug-in
~~~~~~~~~~~~~~~~~~~~~~~~

The instructions in this section refer to the VMware NSX-mh platform,
formerly known as Nicira NVP.

#. Install the NSX plug-in:

   .. code:: console

       # apt-get install neutron-plugin-vmware

#. Edit the :file:`/etc/neutron/neutron.conf` file and set this line:

   .. code:: ini

       core_plugin = vmware

   Example :file:`neutron.conf`: file for NSX-mh integration:

   .. code:: ini

       core_plugin = vmware
       rabbit_host = 192.168.203.10
       allow_overlapping_ips = True

#. To configure the NSX-mh controller cluster for OpenStack Networking,
   locate the ``[default]`` section in the
   :file:`/etc/neutron/plugins/vmware/nsx.ini` file and add the following
   entries:

   -  To establish and configure the connection with the controller cluster
      you must set some parameters, including NSX-mh API endpoints, access
      credentials, and optionally specify settings for HTTP timeouts,
      redirects and retries in case of connection failures:

      .. code:: ini

          nsx_user = ADMIN_USER_NAME
          nsx_password = NSX_USER_PASSWORD
          http_timeout = HTTP_REQUEST_TIMEOUT # (seconds) default 75 seconds
          retries = HTTP_REQUEST_RETRIES # default 2
          redirects = HTTP_REQUEST_MAX_REDIRECTS # default 2
          nsx_controllers = API_ENDPOINT_LIST # comma-separated list

      To ensure correct operations, the ``nsx_user`` user must have
      administrator credentials on the NSX-mh platform.

      A controller API endpoint consists of the IP address and port for the
      controller; if you omit the port, port 443 is used. If multiple API
      endpoints are specified, it is up to the user to ensure that all
      these endpoints belong to the same controller cluster. The OpenStack
      Networking VMware NSX-mh plug-in does not perform this check, and
      results might be unpredictable.

      When you specify multiple API endpoints, the plug-in takes care of
      load balancing requests on the various API endpoints.

   -  The UUID of the NSX-mh transport zone that should be used by default
      when a tenant creates a network. You can get this value from the
      Transport Zones page for the NSX-mh manager:

      Alternatively the transport zone identifier can be retrieved by query
      the NSX-mh API: ``/ws.v1/transport-zone``

      .. code:: ini

          default_tz_uuid = TRANSPORT_ZONE_UUID

   -  .. code:: ini

         default_l3_gw_service_uuid = GATEWAY_SERVICE_UUID

      .. Warning::

         Ubuntu packaging currently does not update the neutron init
         script to point to the NSX-mh configuration file. Instead, you
         must manually update :file:`/etc/default/neutron-server` to add this
         line:

         .. code:: ini

            NEUTRON_PLUGIN_CONFIG = /etc/neutron/plugins/vmware/nsx.ini

      For database configuration, see `Install Networking
      Services <http://docs.openstack.org/kilo/install-guide/install/
      apt/content/neutron-controller-node.html>`__
      in the Installation Guide.

#. Restart neutron-server to apply settings:

   .. code:: console

      # service neutron-server restart

   .. Warning::

     The neutron NSX-mh plug-in does not implement initial
     re-synchronization of Neutron resources. Therefore resources that
     might already exist in the database when Neutron is switched to the
     NSX-mh plug-in will not be created on the NSX-mh backend upon
     restart.

Example :file:`nsx.ini` file:

.. code:: ini

      [DEFAULT]
      default_tz_uuid = d3afb164-b263-4aaa-a3e4-48e0e09bb33c
      default_l3_gw_service_uuid=5c8622cc-240a-40a1-9693-e6a5fca4e3cf
      nsx_user=admin
      nsx_password=changeme
      nsx_controllers=10.127.0.100,10.127.0.200:8888

   .. Note::

     To debug :file:`nsx.ini` configuration issues, run this command from the
     host that runs neutron-server:

   ..code:: console

        # neutron-check-nsx-config PATH_TO_NSX.INI

   This command tests whether neutron-server can log into all of the
   NSX-mh controllers and the SQL server, and whether all UUID values
   are correct.

Configure PLUMgrid plug-in
~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Edit the :file:`/etc/neutron/neutron.conf` file and set this line:

   .. code:: ini

       core_plugin = plumgrid

#. Edit the [PLUMgridDirector] section in the
   :file:`/etc/neutron/plugins/plumgrid/plumgrid.ini` file and specify the IP
   address, port, admin user name, and password of the PLUMgrid Director:

   .. code:: ini

      [PLUMgridDirector]
      director_server = "PLUMgrid-director-ip-address"
      director_server_port = "PLUMgrid-director-port"
      username = "PLUMgrid-director-admin-username"
      password = "PLUMgrid-director-admin-password"

   For database configuration, see `Install Networking
   Services <http://docs.openstack.org/kilo/install-guide/install/
   apt/content/neutron-controller-node.html>`__
   in the Installation Guide.

#. Restart the neutron-server service to apply the settings:

   .. code:: console

      # service neutron-server restart
