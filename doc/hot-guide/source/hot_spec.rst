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

.. _hot_spec:

===============================================
Heat Orchestration Template (HOT) specification
===============================================

------------------
Template structure
------------------

HOT templates are defined in YAML and use the following structure:

.. code-block:: yaml

  heat_template_version: 2013-05-23

  description:
    # description of the template

  parameter_groups:
    # declaration of input parameter groups and order

  parameters:
    # declaration of input parameters

  resources:
    # declaration of template resources

  outputs:
    # declaration of output parameters

heat_template_version
    This key with value ``2013-05-23`` (or a later date) indicates that the
    YAML document is a HOT template of the specified version.

description
    This optional key gives a description of the template, or
    the workload that can be deployed using the template.

parameter_groups
    This section specifies how the input parameters should be
    grouped and the order to provide the parameters in.

    This section is optional.

parameters
    This section specifies input parameters that have to
    be provided when instantiating the template.

    This section is optional.

resources
    This section contains the declaration of the resources of the template.
    This section with at least one resource must be defined in any HOT
    template, or the template would not really do anything when being
    instantiated.

outputs
    This section specifies output parameters available to users once the
    template has been instantiated.

    This section is optional.


.. _hot_spec_parameter_groups:

------------------------
Parameter groups section
------------------------

The ``parameter_groups`` section specifies how the input parameters should be
grouped and the order to provide the parameters in. These groups are typically
used to describe expected behavior for downstream user interfaces.

These groups are specified in a list with each group containing a list of
associated parameters. The lists are used to denote the expected order of the
parameters. A parameter can only be included in one group. Use the name of the
parameter to add it to a group. The parameters details are defined in
the ``parameters`` section.

.. code-block:: yaml

  parameter_groups:
  - label: <human-readable label of parameter group>
    description: <description of the parameter group>
    parameters:
    - <param name>
    - <param name>

label
    A human-readable label that defines the associated group of parameters.

description
    A human-readable description of the parameter group.

parameters
    A list of parameters that belong with this parameter group.

param name
    The name of a parameter defined in the ``parameters`` section.


.. _hot_spec_parameters:

------------------
Parameters section
------------------

The ``parameters`` section defines input parameters that have to be
provided when instantiating the template. Such parameters are typically used to
customize each deployment, or for binding to environment specifics like certain
images.

Each parameter is specified in a separated nested block with the name of the
parameter defined in the first line and additional attributes such as a type or
a default value defined as nested elements:

.. code-block:: yaml

  parameters:
    <param name>:
      type: <string | number | json | comma_delimited_list | boolean>
      label: <human-readable name of the parameter>
      description: <description of the parameter>
      default: <default value for parameter>
      hidden: <true | false>
      constraints:
        <parameter constraints>

param name
    The name of the parameter.

type
    The type of the parameter. Supported types
    are ``string``, ``number``, ``comma_delimited_list``, ``json`` and
    ``boolean``.

    This attribute is required.

label
    A human readable name for the parameter.

    This attribute is optional.

description
    A human readable description for the parameter.

    This attribute is optional.

default
    A default value for the parameter. This value is used if the user doesn't
    specify his own value during deployment.

    This attribute is optional.

hidden
    Defines whether the parameters should be hidden when a user requests
    information about a stack created from the template. This attribute can be
    used to hide passwords specified as parameters.

    This attribute is optional and defaults to ``false``.

constraints
    A list of constraints to apply. The constraints are validated by the
    Orchestration engine when a user deploys a stack. The stack creation fails
    if the parameter value doesn't comply to the constraints.

    This attribute is optional.

The following example shows a minimalistic definition of two parameters:

.. code-block:: yaml

  parameters:
    user_name:
      type: string
      label: User Name
      description: User name to be configured for the application
    port_number:
      type: number
      label: Port Number
      description: Port number to be configured for the web server

.. note::

    The description and the label are optional, but defining these attributes
    is good practice to provide useful information about the role of the
    parameter to the user.

.. _hot_spec_parameters_constraints:

Parameter constraints
---------------------

The ``constraints`` block of a parameter definition defines
additional validation constraints that apply to the value of the
parameter. The parameter values provided by a user are validated against the
constraints at instantiation time. The constraints are defined as a list with
the following syntax:

.. code-block:: yaml

  constraints:
    - <constraint type>: <constraint definition>
      description: <constraint description>

constraint type
    Type of constraint to apply. The set of currently supported constraints is
    given below.

constraint definition
    The actual constraint, depending on the constraint type.  The
    concrete syntax for each constraint type is given below.

description
    A description of the constraint. The text
    is presented to the user when the value he defines violates the constraint.
    If omitted, a default validation message is presented to the user.

    This attribute is optional.

The following example shows the definition of a string parameter with two
constraints. Note that while the descriptions for each constraint are optional,
it is good practice to provide concrete descriptions to present useful messages
to the user at deployment time.

.. code-block:: yaml

  parameters:
    user_name:
      type: string
      label: User Name
      description: User name to be configured for the application
      constraints:
        - length: { min: 6, max: 8 }
          description: User name must be between 6 and 8 characters
        - allowed_pattern: "[A-Z]+[a-zA-Z0-9]*"
          description: User name must start with an uppercase character

.. note::
   While the descriptions for each constraint are optional, it is good practice
   to provide concrete descriptions so useful messages can be presented to the
   user at deployment time.

The following sections list the supported types of parameter constraints, along
with the syntax for each type.

length
~~~~~~

The ``length`` constraint applies to parameters of type ``string``. It defines
a lower and upper limit for the length of the string value.

The syntax of the ``length`` constraint is:

.. code-block:: yaml

  length: { min: <lower limit>, max: <upper limit> }

It is possible to define a length constraint with only a lower limit or an
upper limit. However, at least one of ``min`` or ``max`` must be specified.

range
~~~~~

The ``range`` constraint applies to parameters of type ``number``. It defines a
lower and upper limit for the numeric value of the parameter.

The syntax of the ``range`` constraint is:

.. code-block:: yaml

  range: { min: <lower limit>, max: <upper limit> }

It is possible to define a range constraint with only a lower limit or an
upper limit. However, at least one of ``min`` or ``max`` must be specified.

The minimum and maximum boundaries are included in the range. For example, the
following range constraint would allow for all numeric values between 0 and 10:

.. code-block:: yaml

  range: { min: 0, max: 10 }


allowed_values
~~~~~~~~~~~~~~

The ``allowed_values`` constraint applies to parameters of type ``string`` or
``number``. It specifies a set of possible values for a parameter. At
deployment time, the user-provided value for the respective parameter must
match one of the elements of the list.

The syntax of the ``allowed_values`` constraint is:

.. code-block:: yaml

  allowed_values: [ <value>, <value>, ... ]

Alternatively, the following YAML list notation can be used:

.. code-block:: yaml

  allowed_values:
    - <value>
    - <value>
    - ...

For example:

.. code-block:: yaml

  parameters:
    instance_type:
      type: string
      label: Instance Type
      description: Instance type for compute instances
      constraints:
        - allowed_values:
          - m1.small
          - m1.medium
          - m1.large

allowed_pattern
~~~~~~~~~~~~~~~

The ``allowed_pattern`` constraint applies to parameters of type ``string``.
It specifies a regular expression against which a user-provided parameter value
must evaluate at deployment.

The syntax of the ``allowed_pattern`` constraint is:

.. code-block:: yaml

  allowed_pattern: <regular expression>

For example:

.. code-block:: yaml

  parameters:
    user_name:
      type: string
      label: User Name
      description: User name to be configured for the application
      constraints:
        - allowed_pattern: "[A-Z]+[a-zA-Z0-9]*"
          description: User name must start with an uppercase character


custom_constraint
~~~~~~~~~~~~~~~~~

The ``custom_constraint`` constraint adds an extra step of validation,
generally to check that the specified resource exists in the backend. Custom
constraints get implemented by plug-ins and can provide any kind of advanced
constraint validation logic.

The syntax of the ``custom_constraint`` constraint is:

.. code-block:: yaml

  custom_constraint: <name>

The ``name`` attribute specifies the concrete type of custom constraint. It
corresponds to the name under which the respective validation plugin has been
registered in the Orchestration engine.

For example:

.. code-block:: yaml

  parameters:
    key_name
      type: string
      description: SSH key pair
      constraints:
        - custom_constraint: nova.keypair

.. _hot_spec_pseudo_parameters:

Pseudo Parameters
-----------------

In addition to parameters defined by a template author, the Orchestration
module also creates two parameters for every stack that allow referential
access to the stack's name and identifier. These parameters are named
``OS::stack_name`` for the stack name and ``OS::stack_id`` for the stack
identifier. These values are accessible via the ``get_param`` intrinsic
function, just like user-defined parameters.

.. _hot_spec_resources:

-----------------
Resources section
-----------------

The ``resources`` section defines actual resources that make up a stack
deployed from the HOT template (for instance compute instances, networks,
storage volumes).

Each resource is defined as a separate block in the ``resources`` section with
the following syntax:

.. code-block:: yaml

  resources:
    <resource ID>:
      type: <resource type>
      properties:
        <property name>: <property value>
      metadata:
        <resource specific metadata>
      depends_on: <resource ID or list of ID>
      update_policy: <update policy>
      deletion_policy: <deletion policy>

resource ID
    A resource ID which must be unique within the ``resources`` section of the
    template.

type
    The resource type, such as ``OS::Nova::Server`` or ``OS::Neutron::Port``.

    This attribute is required.

properties
    A list of resource-specific properties. The property value can be provided
    in place, or via a function (see :ref:`hot_spec_intrinsic_functions`).

    This section is optional.

metadata
    Resource-specific metadata.

    This section is optional.

depends_on
    Dependencies of the resource on one or more resources of the template.

    See :ref:`hot_spec_resources_dependencies` for details.

    This attribute is optional.

update_policy
    Update policy for the resource, in the form of a nested dictionary. Whether
    update policies are supported and what the exact semantics are depends on
    the type of the current resource.

    This attribute is optional.

deletion_policy
    Deletion policy for the resource. Which type of deletion policy is
    supported depends on the type of the current resource.

    This attribute is optional.

Depending on the type of resource, the resource block might include more
resource specific data.

All resource types that can be used in CFN templates can also be used in HOT
templates, adapted to the YAML structure as outlined above.

The following example demonstrates the definition of a simple compute resource
with some fixed property values:

.. code-block:: yaml

  resources:
    my_instance:
      type: OS::Nova::Server
      properties:
        flavor: m1.small
        image: F18-x86_64-cfntools


.. _hot_spec_resources_dependencies:

Resource dependencies
---------------------

The ``depends_on`` attribute of a resource defines a dependency between this
resource and one or more other resources.

If a resource depends on just one other resource, the ID of the other resource
is specified as string of the ``depends_on`` attribute, as shown in the
following example:

.. code-block:: yaml

  resources:
    server1:
      type: OS::Nova::Server
      depends_on: server2

    server2:
      type: OS::Nova::Server

If a resource depends on more than one other resources, the value of the
``depends_on`` attribute is specified as a list of resource IDs, as shown in
the following example:

.. code-block:: yaml

  resources:
    server1:
      type: OS::Nova::Server
      depends_on: [ server2, server3 ]

    server2:
      type: OS::Nova::Server

    server3:
      type: OS::Nova::Server


.. _hot_spec_outputs:

---------------
Outputs section
---------------

The ``outputs`` section defines output parameters that should be available to
the user once a stack has been created. This would be, for example, parameters
such as IP addresses of deployed instances, or URLs of web applications
deployed as part of a stack.

Each output parameter is defined as a separate block within the outputs section
according to the following syntax:

.. code-block:: yaml

  outputs:
    <parameter name>:
      description: <description>
      value: <parameter value>

parameter name
    The output parameter name, which must be unique within the ``outputs``
    section of a template.

description
    A short description of the output parameter.

    This attribute is optional.

parameter value
    The value of the output parameter. This value is usually resolved by means
    of a function. See :ref:`hot_spec_intrinsic_functions` for details about
    the functions.

    This attribute is required.

The example below shows how the IP address of a compute resource can
be defined as an output parameter:

.. code-block:: yaml

  outputs:
    instance_ip:
      description: IP address of the deployed compute instance
      value: { get_attr: [my_instance, first_address] }


.. _hot_spec_intrinsic_functions:

-------------------
Intrinsic functions
-------------------

HOT provides a set of intrinsic functions that can be used inside templates
to perform specific tasks, such as getting the value of a resource attribute at
runtime. The following section describes the role and syntax of the intrinsic
functions.

get_attr
--------

The ``get_attr`` function references an attribute of a
resource. The attribute value is resolved at runtime using the resource
instance created from the respective resource definition.

The syntax of the ``get_attr`` function is:

.. code-block:: yaml

  get_attr:
    - <resource ID>
    - <attribute name>
    - <key/index 1> (optional)
    - <key/index 2> (optional)
    - ...

resource ID
    The resource ID for which the attribute needs to be resolved.

    The resource ID must exist in the ``resources`` section of the template.

attribute name
    The attribute name to be resolved. If the attribute returns a complex data
    structure such as a list or a map, then subsequent keys or indexes can be
    specified. These additional parameters are used to navigate the data
    structure to return the desired value.

The following example demonstrates how to use the ``get_param`` function:

.. code-block:: yaml

  resources:
    my_instance:
      type: OS::Nova::Server
      # ...

  outputs:
    instance_ip:
      description: IP address of the deployed compute instance
      value: { get_attr: [my_instance, first_address] }
    instance_private_ip:
      description: Private IP address of the deployed compute instance
      value: { get_attr: [my_instance, networks, private, 0] }

In this example, if the networks attribute contained the following data:

.. code-block:: yaml

   {"public": ["2001:0db8:0000:0000:0000:ff00:0042:8329", "1.2.3.4"],
    "private": ["10.0.0.1"]}

then the value of ``the get_attr`` function would resolve to ``10.0.0.1``
(first item of the ``private`` entry in the ``networks`` map).


get_file
--------

The ``get_file`` function returns the content of a file into the template.
It is generally used as a file inclusion mechanism for files
containing scripts or configuration files.

The syntax of ``the get_file`` function is:

.. code-block:: yaml

  get_file: <content key>

The ``content key`` is used to look up the ``files`` dictionary that is
provided in the REST API call. The Orchestration client command
(:command:`heat`) is ``get_file`` aware and will populate the ``files``
dictionary with the actual content of fetched paths and URLs. The
Orchestration client command supports relative paths and will transform these
to the absolute URLs required by the Orchestration API.

.. note::
    The ``get_file`` argument must be a static path or URL and not rely on
    intrinsic functions like ``get_param``. the Orchestration client does not
    process intrinsic functions (they are only processed by the Orchestration
    engine).

The example below demonstrates the ``get_file`` function usage with both
relative and absolute URLs:

.. code-block:: yaml

  resources:
    my_instance:
      type: OS::Nova::Server
      properties:
        # general properties ...
        user_data:
          get_file: my_instance_user_data.sh

    my_other_instance:
      type: OS::Nova::Server
      properties:
        # general properties ...
        user_data:
          get_file: http://example.com/my_other_instance_user_data.sh

The ``files`` dictionary generated by the Orchestration client during
instantiation of the stack would contain the following keys:
* ``file:///path/to/my_instance_user_data.sh``
* ``http://example.com/my_other_instance_user_data.sh*``


get_param
---------

The ``get_param`` function references an input parameter of a template. It
resolves to the value provided for this input parameter at runtime.

The syntax of the ``get_param`` function is:

.. code-block:: yaml

  get_param:
    - <parameter name>
    - <key/index 1> (optional)
    - <key/index 2> (optional)
    - ...

parameter name
    The parameter name to be resolved. If the parameters returns a complex data
    structure such as a list or a map, then subsequent keys or indexes can be
    specified. These additional parameters are used to navigate the data
    structure to return the desired value.

The following example demonstrates the use of the ``get_param`` function:

.. code-block:: yaml

  parameters:
    instance_type:
      type: string
      label: Instance Type
      description: Instance type to be used.
    server_data:
      type: json

  resources:
    my_instance:
      type: OS::Nova::Server
      properties:
        flavor: { get_param: instance_type}
        metadata: { get_param: [ server_data, metadata ] }
        key_name: { get_param: [ server_data, keys, 0 ] }


In this example, if the ``instance_type`` and ``server_data`` parameters
contained the following data:

.. code-block:: yaml

   {"instance_type": "m1.tiny",
   {"server_data": {"metadata": {"foo": "bar"},
                    "keys": ["a_key","other_key"]}}}

then the value of the property ``flavor`` would resolve to ``m1.tiny``,
``metadata`` would resolve to ``{"foo": "bar"}`` and ``key_name`` would resolve
to ``a_key``.

get_resource
------------

The ``get_resource`` function references another resource within the
same template. At runtime, it is resolved to reference the ID of the referenced
resource, which is resource type specific. For example, a reference to a
floating IP resource returns the respective IP address at runtime.  The syntax
of the ``get_resource`` function is:

.. code-block:: yaml

  get_resource: <resource ID>

The resource ID of the referenced resource is given as single parameter to the
get_resource function.

For example:

.. code-block:: yaml

   resources:
     instance_port:
       type: OS::Neutron::Port
       properties: ...

     instance:
       type: OS::Nova::Server
       properties:
         ...
         networks:
           port: { get_resource: instance_port }


list_join
---------

The ``list_join`` function joins a list of strings with the given delimiter.

The syntax of the ``list_join`` function is:

.. code-block:: yaml

  list_join:
  - <delimiter>
  - <list to join>

For example:

.. code-block:: yaml

  list_join: [', ', ['one', 'two', 'and three']]

This resolve to the string ``one, two, and three``.


resource_facade
---------------

The ``resource_facade`` function retrieves data in a parent provider template.

A provider template provides a custom definition of a resource, called its
facade. For more information about custom templates, see :ref:`composition`.
The syntax of the ``resource_facade`` function is:

.. code-block:: yaml

  resource_facade: <data type>

``data type`` can be one of ``metadata``, ``deletion_policy`` or
``update_policy``.


str_replace
-----------

The ``str_replace`` function dynamically constructs strings by
providing a template string with placeholders and a list of mappings to assign
values to those placeholders at runtime. The placeholders are replaced with
mapping values wherever a mapping key exactly matches a placeholder.

The syntax of the ``str_replace`` function is:

.. code-block:: yaml

  str_replace:
    template: <template string>
    params: <parameter mappings>

template
    Defines the template string that contains placeholders which will be
    substituted at runtime.

params
    Provides parameter mappings in the form of dictionary. Each key refers to a
    placeholder used in the ``template`` attribute.

The following example shows a simple use of the ``str_replace`` function in the
outputs section of a template to build a URL for logging into a deployed
application:

.. code-block:: yaml

  resources:
    my_instance:
      type: OS::Nova::Server
      # general metadata and properties ...

  outputs:
    Login_URL:
      description: The URL to log into the deployed application
      value:
        str_replace:
          template: http://host/MyApplication
          params:
            host: { get_attr: [ my_instance, first_address ] }

The following examples show the use of the ``str_replace`` function to build an
instance initialization script:

.. code-block:: yaml

  parameters:
    DBRootPassword:
      type: string
      label: Database Password
      description: Root password for MySQL
      hidden: true

  resources:
    my_instance:
      type: OS::Nova::Server
      properties:
        # general properties ...
        user_data:
          str_replace:
            template: |
              #!/bin/bash
              echo "Hello world"
              echo "Setting MySQL root password"
              mysqladmin -u root password $db_rootpassword
              # do more things ...
            params:
              $db_rootpassword: { get_param: DBRootPassword }
