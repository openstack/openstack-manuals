=======
Compute
=======

The OpenStack Compute service allows you to control an
Infrastructure-as-a-Service (IaaS) cloud computing platform. It gives
you control over instances and networks, and allows you to manage access
to the cloud through users and projects.

Compute does not include virtualization software. Instead, it defines
drivers that interact with underlying virtualization mechanisms that run
on your host operating system, and exposes functionality over a
web-based API.

.. toctree::
   :maxdepth: 2

   compute_arch.rst
   compute-images-instances.rst
   common/support-compute.rst
   compute-system-admin.rst
   compute_config-firewalls.rst
   compute-rootwrap.rst
   compute-configure-migrations.rst
   compute-configure-service-groups.rst
   compute-security.rst
   compute-recover-nodes.rst

.. TODO (bmoss)
   compute/section_compute-networking-nova.xml
   compute/section_compute-system-admin.xml
   ../common/section_support-compute.xml
   ../common/section_cli_nova_usage_statistics.xml
   ../common/section_cli_nova_volumes.xml
   ../common/section_cli_nova_customize_flavors.xml
   ../common/section_compute-configure-console.xml

