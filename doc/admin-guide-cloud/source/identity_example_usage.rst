=============
Example usage
=============

The ``keystone`` client is set up to expect commands in the general
form of ``keystone command argument``, followed by flag-like keyword
arguments to provide additional (often optional) information. For
example, the :command:`user-list` and :command:`tenant-create`
commands can be invoked as follows:

.. code-block:: bash

   # Using token auth env variables
   export OS_SERVICE_ENDPOINT=http://127.0.0.1:5000/v2.0/
   export OS_SERVICE_TOKEN=secrete_token
   keystone user-list
   keystone tenant-create --name demo

   # Using token auth flags
   keystone --os-token secrete --os-endpoint http://127.0.0.1:5000/v2.0/ user-list
   keystone --os-token secrete --os-endpoint http://127.0.0.1:5000/v2.0/ tenant-create --name=demo

   # Using user + password + project_name env variables
   export OS_USERNAME=admin
   export OS_PASSWORD=secrete
   export OS_PROJECT_NAME=admin
   openstack user list
   openstack project create demo

   # Using user + password + project-name flags
   openstack --os-username admin --os-password secrete --os-project-name admin user list
   openstack --os-username admin --os-password secrete --os-project-name admin project create demo
