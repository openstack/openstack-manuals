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
Heat Orchestration Template (HOT) Specification
===============================================

HOT is a new template format meant to replace the Heat CloudFormation-compatible
format (CFN) as the native format supported by the Heat over time.
This specification explains in detail all elements of the HOT template format.
An example driven guide to writing HOT templates can be found
at :ref:`hot_guide`.

------
Status
------

HOT is considered reliable, supported, and standardized as of our
Icehouse (April 2014) release.  The Heat core team may make improvements
to the standard, which very likely would be backward compatible.  The template
format is also versioned.  In our Juno release, Heat will support multiple
different versions of the HOT specification if there is a need driven by the
introduction of new features.


------------------
Template Structure
------------------

HOT templates are defined in YAML and follow the structure outlined below.

::

  heat_template_version: 2013-05-23

  description:
    # a description of the template

  parameter_groups:
    # a declaration of input parameter groups and order

  parameters:
    # declaration of input parameters

  resources:
    # declaration of template resources

  outputs:
    # declaration of output parameters

heat_template_version
    This key with value *2013-05-23* (or a later date) indicates that the YAML
    document is a HOT template of the specified version.

description
    This *optional* key allows for giving a description of the template, or the
    workload that can be deployed using the template.

parameter_groups
    This section allows for specifying how the input parameters should be
    grouped and the order to provide the parameters in. This section is
    *optional* and can be omitted when necessary.

parameters
    This section allows for specifying input parameters that have to be provided
    when instantiating the template. The section is *optional* and can be
    omitted when no input is required.

resources
    This section contains the declaration of the single resources of the
    template. This section with at least one resource should be defined in any
    HOT template, or the template would not really do anything when being
    instantiated.

outputs
    This section allows for specifying output parameters available to users once
    the template has been instantiated. This section is *optional* and can be
    omitted when no output values are required.


.. _hot_spec_parameter_groups:

------------------------
Parameter Groups Section
------------------------

The *parameter_groups* section allows for specifying how the input parameters
should be grouped and the order to provide the parameters in. These groups are
typically used to describe expected behavior for downstream user interfaces.

These groups are specified in a list with each group containing a list of
associated parameters. The lists are used to denote the expected order of the
parameters. Each parameter should be associated to a specific group only once
using the parameter name to bind it to a defined parameter in the parameters
section.

::

  parameter_groups:
  - label: <human-readable label of parameter group>
    description: <description of the parameter group>
    parameters:
    - <param name>
    - <param name>

label
    A human-readable label that defines the associated group of parameters.

description
    This attribute allows for giving a human-readable description of the
    parameter group.

parameters
    A list of parameters associated with this parameter group.

param name
    The name of the parameter that is defined in the associated parameters
    section.


.. _hot_spec_parameters:

------------------
Parameters Section
------------------

The *parameters* section allows for specifying input parameters that have to be
provided when instantiating the template. Such parameters are typically used to
customize each deployment (e.g. by setting custom user names or passwords) or
for binding to environment-specifics like certain images.

Each parameter is specified in a separated nested block with the name of the
parameters defined in the first line and additional attributes such as type or
default value defined as nested elements.

::

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
    The name of the parameter is defined at the top of each parameter block.

type
    This attribute specifies the type of parameter. Currently supported types
    are *string*, *number*, *comma_delimited_list*, *json*, or *boolean*.

label
    This *optional* attribute allows for giving a human readable name of the
    parameter.

description
    This *optional* attribute allows for giving a human readable description of
    the parameter.

default
    This *optional* attribute allows for defining a default value for the
    parameters which will be used in case the parameter is not specified by the
    user during deployment.

hidden
    This *optional* attribute allows for specifying whether the parameters
    should be hidden when showing information about a stack created from the
    template at runtime (e.g. for hiding passwords that were specified as
    parameters). If not specified, the default value 'false' will be used.

constraints
    This *optional* block allows for specifying additional constraints on the
    parameter, such as minimum or maximum values for numeric parameters.

The following example shows a minimalistic definition of two parameters. Note
that the description and label are actually optional, but is good practice to
provide a useful description and label for each parameter.

::

  parameters:
    user_name:
      type: string
      label: User Name
      description: User name to be configured for the application
    port_number:
      type: number
      label: Port Number
      description: Port number to be configured for the web server


.. _hot_spec_parameters_constraints:

Parameter Constraints
---------------------

The *constraints* block of a parameter definition allows for defining additional
validation constraints that apply to the value of the parameter. At
instantiation time of the template, user provided parameter values are validated
against those constraints to make sure the provided values match expectations of
the template author.
Constraints are defined in the form of a bulleted list according to the
following syntax:

::

  constraints:
    - <constraint type>: <constraint definition>
      description: <constraint description>

constraint type
    The constraint type specifies the kind of constraint defined in the current
    bulleted list item. The set of currently supported constraints is given
    below.

constraint definition
    This value defines the actual constraint, depending on the constraint type.
    The concrete syntax for each constraint type is given below.

description
    This *optional* attribute allows for specifying a concrete description of
    the current constraint. This text will be presented to the user, for
    example, when the provided input value for a parameter violates the
    constraint. If omitted, a default validation message will be presented to
    the user.

The following example show the definition of a string parameter with two
constraints. Note that while the descriptions for each constraint are optional,
it is good practice to provide concrete descriptions so useful messages can be
presented to the user at deployment time.

::

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

The following sections list the supported types of parameter constraints, along
with the concrete syntax for each type.

length
~~~~~~
The *length* constraint applies to parameters of type *string* and allows for
defining a lower and upper limit for the length of the string value. The syntax
for the length constraint is:

::

  length: { min: <lower limit>, max: <upper limit> }

It is possible to define a length constraint with only a lower limit or an
upper limit. However, at least one of *min* or *max* must be specified.

range
~~~~~
The *range* constraint applies to parameters of type *number* and allows for
defining a lower and upper limit for the numeric value of the parameter. The
syntax of the range constraint is:

::

  range: { min: <lower limit>, max: <upper limit> }

It is possible to define a range constraint with only a lower limit or an
upper limit. However, at least one of *min* or *max* must be specified.
The minimum or maximum boundaries are included in the range. For example, the
following range constraint would allow for all numeric values between 0 and 10.

::

  range: { min: 0, max: 10 }


allowed_values
~~~~~~~~~~~~~~
The *allowed_values* constraint applies to parameters of type string or number
and allows for specifying a set of possible values for a parameter. At
deployment time, the user provided value for the respective parameter must
match one of the elements of the specified list. The syntax of the
allowed_values constraint is:

::

  allowed_values: [ <value>, <value>, ... ]

Alternatively, the YAML bulleted list notation can be used:

::

  allowed_values:
    - <value>
    - <value>
    - ...

For example:

::

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
The *allowed_pattern* constraint applies to parameters of type string and allows
for specifying a regular expression against which a user provided parameter
value must evaluate at deployment.
The syntax of the allowed_pattern constraint is:

::

  allowed_pattern: <regular expression>

For example:

::

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
The *custom_constraint* constraint adds an extra step of validation, generally
to check that the specified resource exists in the backend. Custom constraints
get implemented by plug-ins and can provide any kind of advanced constraint
validation logic.

The syntax of the custom_constraint constraint is:

::

  custom_constraint: <name>

The *name* specifies the concrete type of custom constraint. It corresponds to
the name under which the respective validation plugin has been registered with
the Heat engine.

For example:

::

  parameters:
    key_name
      type: string
      description: SSH key pair
      constraints:
        - custom_constraint: nova.keypair

.. _hot_spec_pseudo_parameters

Pseudo Parameters
-----------------

In addition to parameters defined by a template author, Heat also creates two
parameters for every stack that allow referential access to the stack's name
and identifier. These parameters are named ``OS::stack_name`` for the stack
name and ``OS::stack_id`` for the stack identifier. These values are accessible
via the `get_param`_ intrinsic function just like user-defined parameters.

.. _hot_spec_resources:

-----------------
Resources Section
-----------------

In the *resources* section, the templates for actual resources that will make up
a stack deployed from the HOT template (e.g. compute instances, networks,
storage volumes) are defined.
Each resource is defined as a separate block in the resources section according
to the syntax below.

::

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
    A resource block is headed by the resource ID, which must be unique within
    the resource section of a template.
type
    This attribute specifies the type of resource, such as OS::Nova::Server.
properties
    This *optional* section contains a list of resource specific properties.
    The property value can be provided in place, or can be provided via a
    function (see :ref:`hot_spec_intrinsic_functions`).
metadata
    This *optional* section contains resource type specific metadata.
depends_on
    This *optional* attribute allows for specifying dependencies of the current
    resource on one or more other resources. Please refer to section
    :ref:`hot_spec_resources_dependencies` for details.
update_policy:
   This *optional* attribute allows for specifying an update policy for the
   resource in the form of a nested dictionary (name-value pairs). Whether
   update policies are supported and what the exact semantics are depends on
   the type of the current resource.
deletion_policy:
   This *optional* attribute allows for specifying a deletion policy for the
   resource (one of the values Delete, Retain or Snapshot). Which type of
   deletion policy is supported depends on the type of the current resource.


Depending on the type of resource, the resource block might include more
resource specific data. Basically all resource types that can be used in
CFN templates can also be used in HOT templates, adapted to the YAML structure
as outlined above.
Below is an example of a simple compute resource definition with some fixed
property values.

::

  resources:
    my_instance:
      type: OS::Nova::Server
      properties:
        flavor: m1.small
        image: F18-x86_64-cfntools


.. _hot_spec_resources_dependencies:

Resource Dependencies
---------------------

By means of the *depends_on* attribute within a resource section it is possible
to define a dependency between a resource and one or more other resources. If
a resource depends on just one other resource, the ID of the other resource is
specified as value of the *depends_on* attribute as shown in the following
example.

::

  resources:
    server1:
      type: OS::Nova::Server
      depends_on: server2

    server2:
      type: OS::Nova::Server

If a resource depends on more than one other resource, the value of the
*depends_on* attribute is specified as a list of resource IDs as shown in the
following example:

::

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
Outputs Section
---------------

In the *outputs* section, any output parameters that should be available to the
user can be defined. Typically, this would be, for example, parameters such as
IP addresses of deployed instances, or URLs of web applications deployed as part
of a stack.

Each output parameter is defined as a separate block within the outputs section
according to the following syntax:

::

  outputs:
    <parameter name>:
      description: <description>
      value: <parameter value>

parameter name
    An output parameter block is headed by the output parameter name, which must
    be unique within the outputs section of a template.
description
    This element gives a short description of the output parameter.
parameter value
    This element specifies the value of the output parameter. Typically, this
    will be resolved by means of a function, e.g. by getting an attribute value
    of one of the stack's resources (see also
    :ref:`hot_spec_intrinsic_functions`).

The example below shows, how the IP address of a compute resource can be defined
as an output parameter.

::

  outputs:
    instance_ip:
      description: IP address of the deployed compute instance
      value: { get_attr: [my_instance, first_address] }


.. _hot_spec_intrinsic_functions:

-------------------
Intrinsic Functions
-------------------
HOT provides a set of intrinsic functions that can be used inside HOT templates
to perform specific tasks, such as getting the value of a resource attribute at
runtime. A definition of all intrinsic functions available in HOT is given
below.


get_attr
--------
The *get_attr* function allows referencing an attribute of a resource. At
runtime, it will be resolved to the value of an attribute of a resource instance
created from the respective resource definition of the template.
The syntax of the get_attr function is as follows:

::

  get_attr:
    - <resource ID>
    - <attribute name>
    - <key/index 1> (optional)
    - <key/index 2> (optional)
    - ...

resource ID
    This parameter specifies the resource for which the attributes shall be
    resolved. This resource must be defined within the *resources* section of
    the template (see also :ref:`hot_spec_resources`).
attribute name
    The attribute name is required as it specifies the attribute
    to be resolved. If the attribute returns a complex data structure
    such as a list or a map, then subsequent keys or indexes can be specified
    which navigate the data structure to return the desired value.

Some examples of how to use the get_attr function are shown below:

::

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

::

   {"public": ["2001:0db8:0000:0000:0000:ff00:0042:8329", "1.2.3.4"],
    "private": ["10.0.0.1"]}

then the value of the get_attr function would resolve to "10.0.0.1".


get_file
------------
The *get_file* function allows string content to be substituted into the
template. It is generally used as a file inclusion mechanism for files
containing non-heat scripts or configuration files.
The syntax of the get_file function is as follows:

::

  get_file: <content key>

The *content key* will be used to look up the files dictionary that is
provided in the REST API call. The *heat* client command from
python-heatclient is *get_file* aware and will populate the *files* with
the actual content of fetched paths and URLs. The *heat* client command
supports relative paths and will transform these to absolute URLs which
will be used as the *content key* in the files dictionary.

Note: The argument to *get_file* should be a static path or URL and not
rely on intrinsic functions like *get_param*. In general, the *heat* client
does not process intrinsic functions (they are only processed by the heat
server).

The example below demonstrates *get_file* usage with both relative and
absolute URLs.

::

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

If this template was launched from a local file this would result in
a *files* dictionary containing entries with keys
*file:///path/to/my_instance_user_data.sh* and
*http://example.com/my_other_instance_user_data.sh*.


get_param
---------
The *get_param* function allows for referencing an input parameter of a template
from anywhere within a template. At runtime, it will be resolved to the value
provided for this input parameter. The syntax of the get_param function is as
follows:

::

  get_param:
    - <parameter name>
    - <key/index 1> (optional)
    - <key/index 2> (optional)
    - ...

parameter name
    The parameter name is required as it specifies the parameter
    to be resolved. If the parameter returns a complex data structure
    such as a list or a map, then subsequent keys or indexes can be specified
    which navigate the data structure to return the desired value.

A sample use of this function in context of a resource definition
is shown below.

::

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


In this example, if the instance_type/server_data parameters contained
the following data:

::

   {"instance_type": "m1.tiny",
   {"server_data": {"metadata": {"foo": "bar"},
                    "keys": ["a_key","other_key"]}}}

then the value of the property 'flavor' would resolve to "m1.tiny", 'metadata'
would resolve to {"foo": "bar"} and 'key_name' would resolve to "a_key".

get_resource
------------
The *get_resource* function allows for referencing another resource within the
same template. At runtime, it will be resolved to reference ID of the resource,
which is resource type specific. For example, a reference to a floating IP
resource will return the respective IP address at runtime.
The syntax of the get_resource function is as follows:

::

  get_resource: <resource ID>

The *resource ID* of the referenced resources as used in the current template is
given as single parameter to the get_resource function.


list_join
--------
The *list_join* function joins a list of strings with the given delimiter.
The syntax of the list_join function is as follows:

::

  list_join:
  - <delimiter>
  - <list to join>

A sample use of this function with a simple list is shown below.

::

  list_join: [', ', ['one', 'two', 'and three']]

This would resolve to "one, two, and three".


resource_facade
---------------
The *resource_facade* function allows a provider template to retrieve data
about its resource facade in the parent template. (A provider template is used to provide a custom definition of a resource - the facade - in the form of a Heat template. The resource's properties are passed to the provider template as its parameters, but other resource data can be included using this function.)
The syntax of the *resource_facade* function is as follows::

  resource_facade: <data type>

The *data type* can be `metadata`, `deletion_policy` or `update_policy`.


str_replace
-----------
The *str_replace* function allows for dynamically constructing strings by
providing a template string with placeholders and a list of mappings to assign
values to those placeholders at runtime. The placeholders are replaced with
mapping values wherever a mapping key exactly matches a placeholder.
The syntax of the str_replace function is as follows:

::

  str_replace:
    template: <template string>
    params: <parameter mappings>

template
    The *template* argument defines the template string that contains
    placeholders which will be substituted at runtime.
params
    The *params* argument provides parameter mappings in the form of a
    dictionary, which will be used for placeholder substitution in the template
    string at runtime. Within parameter mappings one can make use of other
    functions (e.g. get_attr to use resource attribute values) for template
    substitution.

The example below shows a simple use of the str_replace function in the outputs
section of a template to build a URL for logging into a deployed application.

::

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

The str_replace function can also be used for constructing bigger chunks of text
like scripts for initializing compute instances as shown in the example below:

::

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

In the example above, one can imagine that MySQL is being configured on a
compute instance and the root password is going to be set based on a user
provided parameter. The script for doing this is provided as userdata to the
compute instance, leveraging the str_replace function.
