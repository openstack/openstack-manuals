.. _composition:

====================
Template composition
====================

When writing complex templates you are encouraged to break up your
template into separate smaller templates. These can then be brought
together using template resources. This is a mechanism to define a resource
using a template, thus composing one logical stack with multiple templates.

Template resources provide a feature similar to the
:hotref:`AWS::CloudFormation::Stack` resource, but also provide a way to:

* Define new resource types and build your own resource library.
* Override the default behaviour of existing resource types.

To achieve this:

* The Orchestration client gets the associated template files and passes them
  along in the ``files`` section of the ``POST stacks/`` API request.
* The environment in the Orchestration engine manages the mapping of resource
  type to template creation.
* The Orchestration engine translates template parameters into resource
  properties.

The following examples illustrate how you can use a custom template to define
new types of resources. These examples use a custom template stored in a
:file:`my_nova.yml` file:

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
        flavor: m1.small
        image: ubuntu-trusty-x86_64



Use the template filename as type
=================================

The following template defines the :file:`my_nova.yaml` file as value for the
``type`` property of a resource:

.. code-block:: yaml

  heat_template_version: 2013-05-23
  resources:
    my_server:
      type: my_nova.yaml
      properties:
        key_name: my_key

The ``key_name`` argument of the ``my_nova.yaml`` template gets its value from
the ``key_name`` property of the new template.

.. note::

  The above reference to ``my_nova.yaml`` assumes it is in the same directory.
  You can use any of the following forms:

  * Relative path (``my_nova.yaml``)
  * Absolute path (``file:///home/user/templates/my_nova.yaml``)
  * Http URL (``http://example.com/templates/my_nova.yaml``)
  * Https URL (``https://example.com/templates/my_nova.yaml``)

To create the stack run:

.. code-block:: console

  $ heat stack-create -f main.yaml stack1


Define a new resource type
==========================

You can associate a name to the ``my_nova.yaml`` template in an environment
file. If the name is already known by the Orchestration module then your new
resource will override the default one.

In the following example a new ``OS::Nova::Server`` resource overrides the
default resource of the same name.

An :file:`env.yaml` environment file holds the definition of the new resource:

.. code-block:: yaml

  resource_registry:
    "OS::Nova::Server": my_nova.yaml

.. note::

   See :ref:`environments` for more detail about environment files.

You can now use the new ``OS::Nova::Server`` in your new template:

.. code-block:: yaml

  resources:
    my_server:
      type: OS::Nova::Server
      properties:
        key_name: my_key

To create the stack run:

.. code-block:: console

  $ heat stack-create -f main.yaml -e env.yaml example-two

Making your template resource more "transparent"
================================================
If you wish to be able to return the ID of one of the inner resources
instead of the nested stack's identifier, you can add the special reserved
output "OS::stack_id" to your template resource.

.. code-block:: yaml

  resources:
    server:
      type: OS::Nova::Server

  outputs:
    OS::stack_id:
      value: {get_resource: server}

Now when you use "get_resource" from the outer template heat
will use the nova server id and not the template resource identifier.
