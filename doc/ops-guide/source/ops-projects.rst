=================
Managing Projects
=================

Users must be associated with at least one project, though they may
belong to many. Therefore, you should add at least one project before
adding users.

Adding Projects
~~~~~~~~~~~~~~~

To create a project through the OpenStack dashboard:

#. Log in as an administrative user.

#. Select the :guilabel:`Identity` tab in the left navigation bar.

#. Under Identity tab, click :guilabel:`Projects`.

#. Click the :guilabel:`Create Project` button.

You are prompted for a project name and an optional, but recommended,
description. Select the check box at the bottom of the form to enable
this project. By default, it is enabled, as shown below:

.. figure:: figures/create_project.png
   :alt: Create Project form

It is also possible to add project members and adjust the project
quotas. We'll discuss those actions later, but in practice, it can be
quite convenient to deal with all these operations at one time.

To add a project through the command line, you must use the OpenStack
command line client.

.. code-block:: console

   # openstack project create demo --domain default

This command creates a project named ``demo``. Optionally, you can add a
description string by appending :option:`--description PROJECT_DESCRIPTION`,
which can be very useful. You can also
create a project in a disabled state by appending :option:`--disable` to the
command. By default, projects are created in an enabled state.


Assign a lost IPv4 address back to a project
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Using administrator credentials, confirm the lost IP address is still available:

   .. code-block:: console

      # nova list --all-tenants | grep 'IP-ADDRESS'

#. Inform the user to create a port:

   .. code-block:: console

      $ neutron port-create NETWORK_ID --name PORT_NAME

#. Update the new port with the IPv4 address:

   .. code-block:: console

      # neutron subnet-list
      # neutron port-update PORT_NAME --request-format=json --fixed-ips \
      type=dict list=true subnet_id=NETWORK_ID_IPv4_SUBNET_ID \
      ip_address=IP_ADDRESS  subnet_id=NETWORK_ID_IPv6_SUBNET_ID
      # neutron port-show PORT-NAME
