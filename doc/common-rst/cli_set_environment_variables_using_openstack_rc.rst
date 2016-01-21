=====================================================
Set environment variables using the OpenStack RC file
=====================================================

To set the required environment variables for the OpenStack command-line
clients, you must create an environment file called an OpenStack rc
file, or ``openrc.sh`` file. If your OpenStack installation provides
it, you can download the file from the OpenStack dashboard as an
administrative user or any other user. This project-specific environment
file contains the credentials that all OpenStack services use.

When you source the file, environment variables are set for your current
shell. The variables enable the OpenStack client commands to communicate
with the OpenStack services that run in the cloud.

.. note::

   Defining environment variables using an environment file is not a
   common practice on Microsoft Windows. Environment variables are
   usually defined in the :menuselection:`Advanced > System Properties`
   dialog box.

Download and source the OpenStack RC file
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Log in to the OpenStack dashboard, choose the project for which you want
   to download the OpenStack RC file, on the :guilabel:`Project` tab, open
   the :guilabel:`Compute` tab and click :guilabel:`Access & Security`.

#. On the :guilabel:`API Access` tab, click :guilabel:`Download OpenStack
   RC File` and save the file. The filename will be of the form
   ``PROJECT-openrc.sh`` where ``PROJECT`` is the name of the project for
   which you downloaded the file.

#. Copy the ``PROJECT-openrc.sh`` file to the computer from which you
   want to run OpenStack commands.

   For example, copy the file to the computer from which you want to upload
   an image with a ``glance`` client command.

#. On any shell from which you want to run OpenStack commands, source the
   ``PROJECT-openrc.sh`` file for the respective project.

   In the following example, the ``demo-openrc.sh`` file is sourced for
   the demo project:

   .. code-block:: console

      $ source demo-openrc.sh

#. When you are prompted for an OpenStack password, enter the password for
   the user who downloaded the ``PROJECT-openrc.sh`` file.

Create and source the OpenStack RC file
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Alternatively, you can create the ``PROJECT-openrc.sh`` file from
scratch, if you cannot download the file from the dashboard.

#. In a text editor, create a file named ``PROJECT-openrc.sh`` and add
   the following authentication information:

   .. code-block:: shell

      export OS_USERNAME=username
      export OS_PASSWORD=password
      export OS_TENANT_NAME=projectName
      export OS_AUTH_URL=https://identityHost:portNumber/v2.0
      # The following lines can be omitted
      export OS_TENANT_ID=tenantIDString
      export OS_REGION_NAME=regionName
      export OS_CACERT=/path/to/cacertFile

#. On any shell from which you want to run OpenStack commands, source the
   ``PROJECT-openrc.sh`` file for the respective project. In this
   example, you source the ``admin-openrc.sh`` file for the admin
   project:

   .. code-block:: console

      $ source admin-openrc.sh

.. note::

   You are not prompted for the password with this method. The password
   lives in clear text format in the ``PROJECT-openrc.sh`` file.
   Restrict the permissions on this file to avoid security problems.
   You can also remove the ``OS_PASSWORD`` variable from the file, and
   use the `--password` parameter with OpenStack client commands
   instead.

.. note::

   You must set the ``OS_CACERT`` environment variable when using the
   https protocol in the ``OS_AUTH_URL`` environment setting because
   the verification process for the TLS (HTTPS) server certificate uses
   the one indicated in the environment. This certificate will be used
   when verifying the TLS (HTTPS) server certificate.

Override environment variable values
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When you run OpenStack client commands, you can override some
environment variable settings by using the options that are listed at
the end of the ``help`` output of the various client commands. For
example, you can override the ``OS_PASSWORD`` setting in the
``PROJECT-openrc.sh`` file by specifying a password on a
:command:`openstack` command, as follows:

.. code-block:: console

   $ openstack --os-password PASSWORD service list

Where ``PASSWORD`` is your password.

A user specifies their username and password credentials to interact
with OpenStack, using any client command. These credentials can be
specified using various mechanisms, namely, the environment variable
or command-line argument. It is not safe to specify the password using
either of these methods.

For example, when you specify your password using the command-line
client with the `--os-password` argument, anyone with access to your
computer can view it in plain text with the ``ps`` field.

To avoid storing the password in plain text, you can prompt for the
OpenStack password interactively.
