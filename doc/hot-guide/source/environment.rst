.. _environments:

============
Environments
============

The environment affects the runtime behaviour of a template. It provides a way
to override the resource implementations and a mechanism to place parameters
that the service needs.

To fully understand the runtime behavior you have to consider what plug-ins are
installed on the cloud you're using.

Environment file format
-----------------------

The environment is a yaml text file that contains two main sections:

``parameters``
    A map of key/pair values.

``resource_registry``
    Definition of custom resources.

Use the :option:`-e` option of the :command:`heat stack-create` command to
create a stack using with the environment defined in such a file.

You can also provide environment parameters as a list of key/value pairs using
the :option:`-P` option of the :command:`heat stack-create` command.

In the following example the environment is read from the :file:`my_env.yaml`
file and an extra parameter is provided using the :option:`-P` option:

.. code-block:: console

   $ heat stack-create my_stack -e my_env.yaml -P "param1=val1;param2=val2" -f my_tmpl.yaml


Global and effective environments
---------------------------------

The environment used for a stack is the combination of the environment you
use with the template for the stack, and a global environment that is
determined by your cloud operator. An entry in the user environment takes
precedence over the global environment. OpenStack includes a default global
environment, but you cloud operator can add additional environment entries.

.. TODO:
   move this to a heat section in the admin-guide-cloud

   The cloud operator can add to the global environment
   by putting environment files in a configurable directory wherever
   the Orchestration engine runs. The configuration variable is named
   "environment_dir" is found in the "[DEFAULT]" section
   of "/etc/heat/heat.conf". The default for that directory is
   "/etc/heat/environment.d". Its contents are combined in whatever
   order the shell delivers them when the service starts up,
   which is the time when these files are read.

   If the "my_env.yaml" file from the example above had been put in the
   "environment_dir" then the user's command line could be this:

   ::

      heat stack-create my_stack -P "some_parm=bla" -f my_tmpl.yaml

Define values for a template arguments
--------------------------------------

You can define values for the template arguments in the ``parameters`` section
of an environment file:

.. code-block:: yaml

  parameters:
    KeyName: my_keypair
    InstanceType: m1.tiny
    ImageId: F18-x86_64-cfntools

Create and override resources
-----------------------------

You can create or override resources in the ``resource_registry`` section of an
environment file. The resource you provide in this manner must have an
identifier, and references either other resources IDs or the URL of an existing
template file.

The following example maps the new ``OS::Networking::FloatingIP``
resource to the existing :hotref:`OS::Nova::FloatingIP` resource:

.. code-block:: yaml

  resource_registry:
    "OS::Networking::FloatingIP": "OS::Nova::FloatingIP"

You can use wilcards to map multiple resources:

.. code-block:: yaml

  resource_registry:
    "OS::Network*": "OS::Neutron*"

To create or override a resource with a custom resource, create a template file
to define this resource, and provide the URL to the template file in the
environment file:

.. code-block:: yaml

  resource_registry:
    "AWS::EC2::Instance": file:///path/to/my_instance.yaml

The supported URL scheme are ``file``, ``http`` and ``https``.

.. note::

  The template file extension must be ``.yaml`` or ``.template``, or it will
  not be treated as a custom template resource.

You can limit the usage of a custom resource to a specific resource of the
template:

.. code-block:: yaml

  resource_registry:
    resources:
      my_db_server:
        "OS::DBInstance": file:///home/mine/all_my_cool_templates/db.yaml
