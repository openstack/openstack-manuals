.. _environments:

============
Environments
============

The environment is used to affect the runtime behaviour of the
template. It provides a way to override the resource
implementations and provide a mechanism to place parameters
that the service needs.

To fully understand the runtime behavior you also have to consider
what plug-ins the cloud operator has installed.

------
Format
------

It is a yaml text file with two main sections "resource_registry" and
"parameters".

------------------
Command line usage
------------------
::

   heat stack-create my_stack -e my_env.yaml -P "some_parm=bla" -f my_tmpl.yaml

---------------------------------
Global and effective environments
---------------------------------

The environment used for a stack is the combination of (1) the
environment given by the user with the template for the stack and (2)
a global environment that is determined by the cloud operator.
Combination is asymmetric: an entry in the user environment takes
precedence over the global environment.  The OpenStack software
includes a default global environment, which supplies some resource
types that are included in the standard documentation.  The cloud
operator can add additional environment entries.

The cloud operator can add to the global environment
by putting environment files in a configurable directory wherever
the heat engine runs.  The configuration variable is named
"environment_dir" is found in the "[DEFAULT]" section
of "/etc/heat/heat.conf".  The default for that directory is
"/etc/heat/environment.d".  Its contents are combined in whatever
order the shell delivers them when the service starts up,
which is the time when these files are read.

If the "my_env.yaml" file from the example above had been put in the
"environment_dir" then the user's command line could be this:

::

   heat stack-create my_stack -P "some_parm=bla" -f my_tmpl.yaml

--------------
Usage examples
--------------

1) Pass parameters into Heat
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
::

  parameters:
    KeyName: heat_key
    InstanceType: m1.micro
    ImageId: F18-x86_64-cfntools


2) Deal with the mapping of Quantum to Neutron
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
::

  resource_registry:
    "OS::Quantum*": "OS::Neutron*"

So all existing resources which can be matched with "OS::Neutron*"
will be mapped to "OS::Quantum*" accordingly.

3) Override a resource type with a provider resource
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
::

  resource_registry:
    "AWS::EC2::Instance": file:///home/mine/my_instance.yaml

Please note that the template resource URL here must end with ".yaml"
or ".template", or it will not be treated as a custom template
resource. The supported URL types are "http, https and file".

4) Always map resource type X to Y
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
::

  resource_registry:
    "OS::Networking::FloatingIP": "OS::Nova::FloatingIP"


5) Use default resources except one for a particular resource in the template
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
::

  resource_registry:
    resources:
      my_db_server:
        "OS::DBInstance": file:///home/mine/all_my_cool_templates/db.yaml
