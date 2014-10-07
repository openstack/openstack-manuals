..
      Licensed under the Apache License, Version 2.0 (the "License"); you may
      not use this file except in compliance with the License. You may obtain
      a copy of the License at

          http://www.apache.org/licenses/LICENSE-2.0

      Unless required by applicable law or agreed to in writing, software
      distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
      WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
      License for the specific language governing permissions and limitations
      under the License.

.. _hot_guide:

==================================
Writing a hello world HOT template
==================================

HOT is a new template format meant to replace the CloudFormation-compatible
format (CFN) as the native format supported by the Orchestration module over
time.
This guide is targeted towards template authors and explains how to write
HOT templates based on examples. A detailed specification of HOT can be found
at :ref:`hot_spec`.


This section gives an introduction on how to write HOT templates, starting from
very basic steps and then going into more and more detail by means of examples.

A most basic template
---------------------

The most basic template you can think of contains only a single resource
definition using only predefined properties. For example, the template below
could be used to deploy a single compute instance:

.. code-block:: yaml

  heat_template_version: 2013-05-23

  description: Simple template to deploy a single compute instance

  resources:
    my_instance:
      type: OS::Nova::Server
      properties:
        key_name: my_key
        image: ubuntu-trusty-x86_64
        flavor: m1.small

Each HOT template has to include the ``heat_template_version`` key with value
``2013-05-23``, the current HOT version. While the ``description`` key is
optional, it is good practice to include some useful text that describes what
users can do with the template. In case you want to provide a longer
description that does not fit on a single line, you can provide multi-line text
in YAML, for example:

.. code-block:: yaml

  description: >
    This is how you can provide a longer description
    of your template that goes over several lines.

The ``resources`` section is required and must contain at least one resource
definition. In the above example, a compute instance is defined with fixed
values for the ``key_name``, ``image`` and ``flavor`` properties.

.. note::

    All the defined elements (key pair, image, flavor) have to exist in the
    OpenStack environment where the template is used.



Input parameters
----------------

Input parameters defined in the ``parameters`` section of a template
allow users to customize a template during deployment. For example, this allows
for providing custom key pair names or image IDs to be used for a deployment.
From a template author's perspective, this helps to make a template more easily
reusable by avoiding hardcoded assumptions.

The following example extends the previous template to provide parameters for
the key pair, image and flavor properties of the resource:

.. code-block:: yaml

  heat_template_version: 2013-05-23

  description: Simple template to deploy a single compute instance

  parameters:
    key_name:
      type: string
      label: Key Name
      description: Name of key-pair to be used for compute instance
    image_id:
      type: string
      label: Image ID
      description: Image to be used for compute instance
    flavor:
      type: string
      label: Instance Type
      description: Type of instance (flavor) to be used

  resources:
    my_instance:
      type: OS::Nova::Server
      properties:
        key_name: { get_param: key_name }
        image: { get_param: image_id }
        flavor: { get_param: flavor }


Values for the three parameters must be defined by the template user during the
deployment of a stack. The ``get_param`` intrinsic function retrieves a
user-specified value for a given parameter and uses this value for the
associated resource property.

For more information about intrinsic functions, see
:ref:`hot_spec_intrinsic_functions`.

Providing default values
~~~~~~~~~~~~~~~~~~~~~~~~

You can provide default values for parameters. If a user doesn't define a value
for a parameter, the default value is used during the stack deployment. The
following example defines a default value ``m1.small`` for the
``flavor`` property:

.. code-block:: yaml

  parameters:
    flavor:
      type: string
      label: Instance Type
      description: Flavor to be used
      default: m1.small

.. note::

   If a template doesn't define a default value for a parameter, then the user
   must define the value, otherwise the stack creation will fail.

Hidding parameters values
~~~~~~~~~~~~~~~~~~~~~~~~~

The values that a user provides when deploying a stack are available in the
stack details and can be accessed by any user in the same tenant. To hide the
value of a parameter, use the ``hidden`` boolean attribute of the parameter:

.. code-block:: yaml

  parameters:
    database_password:
      type: string
      label: Database Password
      description: Password to be used for database
      hidden: true

Restricting user input
~~~~~~~~~~~~~~~~~~~~~~

You can restrict the values of an input parameter to make sure that the user
defines valid data for this parameter. The ``constraints`` property of an input
parameter defines a list of constraints to apply for the parameter.
The following example restricts the ``flavor`` parameter to a list of three
possible values:

.. code-block:: yaml

  parameters:
    flavor:
      type: string
      label: Instance Type
      description: Type of instance (flavor) to be used
      constraints:
        - allowed_values: [ m1.medium, m1.large, m1.xlarge ]
          description: Value must be one of m1.medium, m1.large or m1.xlarge.


The following example defines multiple contraints for a password definition:

.. code-block:: yaml

  parameters:
    database_password:
      type: string
      label: Database Password
      description: Password to be used for database
      hidden: true
      constraints:
        - length: { min: 6, max: 8 }
          description: Password length must be between 6 and 8 characters.
        - allowed_pattern: "[a-zA-Z0-9]+"
          description: Password must consist of characters and numbers only.
        - allowed_pattern: "[A-Z]+[a-zA-Z0-9]*"
          description: Password must start with an uppercase character.

The list of supported constraints is available in the
:ref:`hot_spec_parameters_constraints` section.

.. note::

    You can define multiple constraints of the same type. Especially in the
    case of allowed patterns this not only allows for keeping regular
    expressions simple and maintainable, but also for keeping error messages to
    be presented to users precise.


Template outputs
----------------

In addition to template customization through input parameters, you can
provide information about the resources created during the stack deployment to
the users in the ``outputs`` section of a template. In the following example
the output section provides the IP address of the ``my_instance`` resource:

.. code-block:: yaml

  outputs:
    instance_ip:
      description: The IP address of the deployed instance
      value: { get_attr: [my_instance, first_address] }

.. note::

   Output values are typically resolved using intrinsic function such as
   the ``get_attr``. See :ref:`hot_spec_intrinsic_functions` for more information
   about intrinsic functions..

See :ref:`hot_spec_outputs` for more information about the ``outputs`` section.
