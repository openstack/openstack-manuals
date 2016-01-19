.. _section_manage-the-cloud:

================
Manage the cloud
================

.. toctree::

   compute-euca2ools.rst
   common/nova_show_usage_statistics_for_hosts_instances.rst

System administrators can use :command:`nova` client and :command:`euca2ools`
commands to manage their clouds.

``nova`` client and ``euca2ools`` can be used by all users, though
specific commands might be restricted by Role Based Access Control in
the Identity service.

**Managing the cloud with nova client**

#. The python-novaclient package provides a ``nova`` shell that enables
   Compute API interactions from the command line. Install the client, and
   provide your user name and password (which can be set as environment
   variables for convenience), for the ability to administer the cloud from
   the command line.

   To install python-novaclient, download the tarball from
   `http://pypi.python.org/pypi/python-novaclient/#downloads <http://pypi.python.org/pypi/python-novaclient/#downloads>`__ and then
   install it in your favorite Python environment:

   ..  code:: console

       $ curl -O http://pypi.python.org/packages/source/p/python-novaclient/python-novaclient-2.6.3.tar.gz
       $ tar -zxvf python-novaclient-2.6.3.tar.gz
       $ cd python-novaclient-2.6.3

   As root, run:

   ..  code:: console

       # python setup.py install

#. Confirm the installation was successful:

   ..  code:: console

       $ nova help
       usage: nova [--version] [--debug] [--os-cache] [--timings]
                   [--timeout SECONDS] [--os-username AUTH_USER_NAME]
                   [--os-password AUTH_PASSWORD]
                   [--os-tenant-name AUTH_TENANT_NAME]
                   [--os-tenant-id AUTH_TENANT_ID] [--os-auth-url AUTH_URL]
                   [--os-region-name REGION_NAME] [--os-auth-system AUTH_SYSTEM]
                   [--service-type SERVICE_TYPE] [--service-name SERVICE_NAME]
                   [--volume-service-name VOLUME_SERVICE_NAME]
                   [--endpoint-type ENDPOINT_TYPE]
                   [--os-compute-api-version COMPUTE_API_VERSION]
                   [--os-cacert CA_CERTIFICATE] [--insecure]
                   [--bypass-url BYPASS_URL]
                   SUBCOMMAND ...

   Running :command:`nova help` returns a list of ``nova`` commands and
   parameters. To get help for a subcommand, run:

   ..  code:: console

       $ nova help SUBCOMMAND

   For a complete list of ``nova`` commands and parameters, see the
   `OpenStack Command-Line Reference
   <http://docs.openstack.org/cli-reference/nova.html>`__.

#. Set the required parameters as environment variables to make running
   commands easier. For example, you can add :option:`--os-username` as a
   ``nova`` option, or set it as an environment variable. To set the user
   name, password, and tenant as environment variables, use:

   ..  code:: console

       $ export OS_USERNAME=joecool
       $ export OS_PASSWORD=coolword
       $ export OS_TENANT_NAME=coolu

#. The Identity service will give you an authentication endpoint,
   which Compute recognizes as ``OS_AUTH_URL``:

   .. code:: console

      $ export OS_AUTH_URL=http://hostname:5000/v2.0
      $ export NOVA_VERSION=1.1
