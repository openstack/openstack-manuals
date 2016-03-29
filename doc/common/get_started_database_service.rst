=========================
Database service overview
=========================

The Database service provides scalable and reliable cloud provisioning
functionality for both relational and non-relational database engines.
Users can quickly and easily use database features without the burden of
handling complex administrative tasks. Cloud users and database
administrators can provision and manage multiple database instances as
needed.

The Database service provides resource isolation at high performance
levels, and automates complex administrative tasks such as deployment,
configuration, patching, backups, restores, and monitoring.

**Process flow example**

This example is a high-level process flow for using Database services:

#. The OpenStack Administrator configures the basic infrastructure using
   the following steps:

   #. Install the Database service.
   #. Create an image for each type of database. For example, one for MySQL
      and one for MongoDB.
   #. Use the :command:`trove-manage` command to import images and offer them
      to tenants.

#. The OpenStack end user deploys the Database service using the following
   steps:

   #. Create a Database service instance using the :command:`trove create`
      command.
   #. Use the :command:`trove list` command to get the ID of the instance,
      followed by the :command:`trove show` command to get the IP address of
      it.
   #. Access the Database service instance using typical database access
      commands. For example, with MySQL:

      .. code-block:: console

         $ mysql -u myuser -p -h TROVE_IP_ADDRESS mydb

**Components**

The Database service includes the following components:

``python-troveclient`` command-line client
  A CLI that communicates with the ``trove-api`` component.

``trove-api`` component
  Provides an OpenStack-native RESTful API that supports JSON to
  provision and manage Trove instances.

``trove-conductor`` service
  Runs on the host, and receives messages from guest instances that
  want to update information on the host.

``trove-taskmanager`` service
  Instruments the complex system flows that support provisioning
  instances, managing the lifecycle of instances, and performing
  operations on instances.

``trove-guestagent`` service
  Runs within the guest instance. Manages and performs operations on
  the database itself.
