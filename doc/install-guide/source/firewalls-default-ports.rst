===========================
Firewalls and default ports
===========================

On some deployments, such as ones where restrictive firewalls are in
place, you might need to manually configure a firewall to permit
OpenStack service traffic.

To manually configure a firewall, you must permit traffic through the
ports that each OpenStack service uses. This table lists the default
ports that each OpenStack service uses:

.. list-table:: Default ports that OpenStack components use
   :header-rows: 1

   * - OpenStack service
     - Default ports
   * - Application Catalog (``murano``)
     - 8082
   * - Backup Service (``Freezer``)
     - 9090
   * - Big Data Processing Framework (``sahara``)
     - 8386
   * - Block Storage (``cinder``)
     - 8776
   * - Clustering (``senlin``)
     - 8777
   * - Compute (``nova``) endpoints
     - 8774
   * - Compute ports for access to virtual machine consoles
     - 5900-5999
   * - Compute VNC proxy for browsers (openstack-nova-novncproxy)
     - 6080
   * - Compute VNC proxy for traditional VNC clients (openstack-nova-xvpvncproxy)
     - 6081
   * - Container Infrastructure Management (``Magnum``)
     - 9511
   * - Container Service (``Zun``)
     - 9517
   * - Data processing service (``sahara``) endpoint
     - 8386
   * - Database service (``Trove``)
     - 8779
   * - DNS service (``Designate``)
     - 9001
   * - High Availability Service (``Masakari``)
     - 15868
   * - Identity service (``keystone``) endpoint
     - 5000
   * - Image service (``glance``) API
     - 9292
   * - Key Manager service (``Barbican``)
     - 9311
   * - Loadbalancer service (``Octavia``)
     - 9876
   * - Networking (``neutron``)
     - 9696
   * - NFV Orchestration service (``tacker``)
     - 9890
   * - Object Storage (``swift``)
     - 6000, 6001, 6002
   * - Orchestration (``heat``) endpoint
     - 8004
   * - Orchestration AWS CloudFormation-compatible API (``openstack-heat-api-cfn``)
     - 8000
   * - Orchestration AWS CloudWatch-compatible API (``openstack-heat-api-cloudwatch``)
     - 8778
   * - Placement API (``placement``)
     - 8003
   * - Proxy port for HTML5 console used by Compute service
     - 6082
   * - Rating service (``Cloudkitty``)
     - 8889
   * - Registration service (``Adjutant``)
     - 5050
   * - Resource Reservation service (``Blazar``)
     - 1234
   * - Root Cause Analysis service (``Vitrage``)
     - 8999
   * - Shared File Systems service (``Manila``)
     - 8786
   * - Telemetry alarming service (``Aodh``)
     - 8042
   * - Telemetry event service (``Panko``)
     - 8977
   * - Workflow service (``Mistral``)
     - 8989

To function properly, some OpenStack components depend on other,
non-OpenStack services. For example, the OpenStack dashboard uses HTTP
for non-secure communication. In this case, you must configure the
firewall to allow traffic to and from HTTP.

This table lists the ports that other OpenStack components use:

.. list-table:: Default ports that secondary services related to OpenStack components use
   :header-rows: 1

   * - Service
     - Default port
     - Used by
   * - HTTP
     - 80
     - OpenStack dashboard (``Horizon``) when it is not configured to use secure access.
   * - HTTP alternate
     - 8080
     - OpenStack Object Storage (``swift``) service.
   * - HTTPS
     - 443
     - Any OpenStack service that is enabled for SSL, especially secure-access dashboard.
   * - rsync
     - 873
     - OpenStack Object Storage. Required.
   * - iSCSI target
     - 3260
     - OpenStack Block Storage. Required when using LVM with iSCSI target (tgt, LIO, iSER)
   * - NVMe-oF target
     - 4420
     - OpenStack Block Storage. Required when using LVM with NVMe-oF target (nvmet).
   * - MySQL database service
     - 3306
     - Most OpenStack components.
   * - Message Broker (AMQP traffic)
     - 5672
     - OpenStack Block Storage, Networking, Orchestration, and Compute.

On some deployments, the default port used by a service may fall within
the defined local port range of a host. To check a host's local port
range:

.. code-block:: console

    $ sysctl net.ipv4.ip_local_port_range

If a service's default port falls within this range, run the following
program to check if the port has already been assigned to another
application:

.. code-block:: console

    $ lsof -i :PORT

Configure the service to use a different port if the default port is
already being used by another application.
