.. _composition:

====================
Template composition
====================

When writing complex templates you are encouraged to break up your
template into separate smaller templates. These can then be brought
together using template resources. This is a mechanism to define a resource
using a template, thus composing one logical stack with multiple templates.


How to use template resources for composition
---------------------------------------------

Template resources do a very similar job to
AWS::CloudFormation::Stack, but they are more powerful as they allow a
template to "stand in for" any resource type.

Template resources can be used to do the following:

 * Define new resource types (make your own resource library).
 * Override the default behaviour of existing resource types.

The way this is achieved is:

 * The heat client gets the associated template files and passes them
   along in the "files" section of the "POST stacks/".
 * The environment in Orchestration engine manages the mapping of resource type
   to template creation.
 * Translation of the template parameters into resource properties.

Let's go through some examples. In all examples assume the
same resource template. This is a simple wrapper around a nova server
(my_nova.yaml).

.. code-block:: yaml

  heat_template_version: 2013-05-23
  parameters:
    key_name:
      type: string
      description: Name of a KeyPair
  resources:
    server:
      type: OS::Nova::Server
      properties:
        key_name: {get_param: key_name}
        flavor: my.best
        image: the_one_i_always_use


Example 1
~~~~~~~~~

In this example you will not map a resource type name at all, but
directly specify the template URL as the resource type.

Your main template (main.yaml) would look like this.

.. code-block:: yaml

  heat_template_version: 2013-05-23
  resources:
    my_server:
      type: my_nova.yaml
      properties:
        key_name: my_key

Some notes about URLs:

The above reference to my_nova.yaml assumes it is in the same directory.
You could use any of the following forms:

 * Relative path (type: my_nova.yaml)
 * Absolute path (type: file:///home/user/templates/my_nova.yaml)
 * Http URL (type: http://example.com/templates/my_nova.yaml)
 * Https URL (type: https://example.com/templates/my_nova.yaml)

If you are providing a link to github.com make sure to get the "raw"
link. For instance this::

  https://raw.githubusercontent.com/openstack/heat-templates/master/hot/autoscaling.yaml

but not this::

  https://github.com/openstack/heat-templates/blob/master/hot/autoscaling.yaml

To create the stack, run::

  $ heat stack-create -f main.yaml example-one

Example 2
~~~~~~~~~

In this example you will use the environment (env.yaml) to override the
OS::Nova::Server with my_nova to get the defaults you want.

.. code-block:: yaml

  resource_registry:
    "OS::Nova::Server": my_nova.yaml

A more detailed discussion on this can be found here :ref:`environments`

Now you can use "OS::Nova::Server" in our top level template (main.yaml).

.. code-block:: yaml

  resources:
    my_server:
      type: OS::Nova::Server
      properties:
        key_name: my_key

To create the stack, run::

  $ heat stack-create -f main.yaml -e env.yaml example-two
