===================
OpenStack dashboard
===================

.. only:: admin_only

   As a cloud administrative user, the OpenStack dashboard lets you
   create and manage projects, users, images, and flavors. You can
   also set quotas and create and manage services. For information
   about using the dashboard to perform end user tasks, see the
   `OpenStack End User Guide <http://docs.openstack.org/user-guide/>`__.

.. only:: user_only

   As a cloud end user, you can use the OpenStack dashboard to provision
   your own resources within the limits set by administrators. You can
   modify the examples provided in this section to create other types and
   sizes of server instances.


.. We need separate toc trees for End User Guide and Admin User Guide
   to not run into a bug where the next/previous pages do not work due
   to this guide including some files conditionally.

.. only:: admin_guide

   .. toctree::
      :maxdepth: 2

      common/log_in_dashboard.rst

      adminuser/dashboard_manage_images.rst
      adminuser/dashboard_admin_manage_roles.rst
      adminuser/dashboard_manage_instances.rst
      adminuser/dashboard_manage_flavors.rst
      adminuser/dashboard_manage_volumes.rst
      adminuser/dashboard_set_quotas
      adminuser/dashboard_manage_resources.rst
      adminuser/dashboard_manage_host_aggregates.rst
      adminuser/dashboard_admin_manage_stacks.rst

.. only:: user_guide

   .. toctree::
      :maxdepth: 2

      common/log_in_dashboard.rst
      enduser/dashboard_manage_images.rst
      enduser/configure_access_and_security_for_instances.rst
      enduser/dashboard_launch_instances.rst
      enduser/dashboard_create_networks.rst
      enduser/dashboard_manage_containers.rst
      enduser/dashboard_manage_volumes.rst
      enduser/dashboard_stacks.rst
      enduser/dashboard_databases.rst

