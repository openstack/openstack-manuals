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

=======================================
Heat Orchestration Template (HOT) Guide
=======================================

HOT is a new template format meant to replace the Heat
CloudFormation-compatible format (CFN) as the native format supported
by the Heat over time.
This guide is targeted towards template authors and explains how to write
HOT templates based on examples. A detailed specification of HOT can be found
at :ref:`hot_spec`.

------
Status
------

HOT support is still under development and needs more work to provide
access to all functionality currently available via the CFN compatible
template interface. This guide will be updated periodically whenever
new features get implemented for HOT.

----------------------------------
Writing a hello world HOT template
----------------------------------

This section gives an introduction on how to write HOT templates, starting from
very basic steps and then going into more and more detail by means of examples.

A most basic template
---------------------
The most basic template you can think of may contain only a single resource
definition using only predefined properties (along with the mandatory Heat
template version tag). For example, the template below could be used to simply
deploy a single compute instance.

::

  heat_template_version: 2013-05-23

  description: Simple template to deploy a single compute instance

  resources:
    my_instance:
      type: OS::Nova::Server
      properties:
        key_name: my_key
        image: F18-x86_64-cfntools
        flavor: m1.small

Each HOT template has to include the *heat_template_version* key with
value '2013-05-23' (the current version of HOT). While the
*description* is optional, it is good practice to include some useful
text that describes what users can do with the template. In case you
want to provide a longer description that does not fit on a single
line, you can provide multi-line text in YAML, for example:

::

  description: >
    This is how you can provide a longer description
    of your template that goes over several lines.

The *resources* section is required and must contain at least one resource
definition. In the example above, a compute instance is defined with fixed
values for the 'key_name', 'image' and 'flavor' parameters.

Note that all those elements, i.e. a key-pair with the given name, the
image and the flavor have to exist in the OpenStack environment where
the template is used. Typically a template is made more easily
reusable, though, by defining a set of *input parameters* instead of
hard-coding such values.


Template input parameters
-------------------------
Input parameters defined in the *parameters* section of a HOT template
(see also :ref:`hot_spec_parameters`) allow users to customize a
template during deployment. For example, this allows for providing
custom key-pair names or image IDs to be used for a deployment.
From a template author's perspective, this helps to make a template
more easily reusable by avoiding hardcoded assumptions.

Sticking to the example used above, it makes sense to allow users to provide
their custom key-pairs, provide their own image, and to select a flavor for the
compute instance. This can be achieved by extending the initial template as
follows:

::

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
    instance_type:
      type: string
      label: Instance Type
      description: Type of instance (flavor) to be used

  resources:
    my_instance:
      type: OS::Nova::Server
      properties:
        key_name: { get_param: key_name }
        image: { get_param: image_id }
        flavor: { get_param: instance_type }

In the example above, three input parameters have been defined that have to be
provided by the user upon deployment. The fixed values for the respective
resource properties have been replaced by references to the corresponding
input parameters by means of the *get_param* function (see also
:ref:`hot_spec_intrinsic_functions`).

You can also define default values for input parameters which will be
used in case the user does not provide the respective parameter during
deployment. For example, the following definition for the
*instance_type* parameter would select the 'm1.small' flavor unless
specified otherwise by the user.

::

  parameters:
    instance_type:
      type: string
      label: Instance Type
      description: Type of instance (flavor) to be used
      default: m1.small

Another option that can be specified for a parameter is to hide its value when
users request information about a stack deployed from a template. This is
achieved by the *hidden* attribute and useful, for example when requesting
passwords as user input:

::

  parameters:
    database_password:
      type: string
      label: Database Password
      description: Password to be used for database
      hidden: true


Restricting user input
~~~~~~~~~~~~~~~~~~~~~~
In some cases you might want to restrict the values of input
parameters that users can supply. For example, you might know that the
software running in a compute instance needs a certain amount of
resources so you might want to restrict the *instance_type* parameter
introduced above. Parameters in HOT templates can be restricted by
adding a *constraints* section (see also
:ref:`hot_spec_parameters_constraints`).
For example, the following would allow only three values to be
provided as input for the *instance_type* parameter:

::

  parameters:
    instance_type:
      type: string
      label: Instance Type
      description: Type of instance (flavor) to be used
      constraints:
        - allow_values: [ m1.medium, m1.large, m1.xlarge ]
          description: Value must be one of m1.medium, m1.large or m1.xlarge.

The *constraints* section allows for defining a list of constraints that must
all be fulfilled by user input. For example, the following list of constraints
could be used to clearly specify format requirements on a password to be
provided by users:

::

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

Note that you can define multiple constraints of the same type. Especially in
the case of allowed patterns this not only allows for keeping regular
expressions simple and maintainable, but also for keeping error messages to be
presented to users precise.


Providing template outputs
--------------------------
In addition to template customization through input parameters, you will
typically want to provide outputs to users, which can be done in the
*outputs* section of a template (see also :ref:`hot_spec_outputs`).
For example, the IP address by which the instance defined in the example
above can be accessed should be provided to users. Otherwise, users would have
to look it up themselves. The definition for providing the IP address of the
compute instance as an output is shown in the following snippet:

::

  outputs:
    instance_ip:
      description: The IP address of the deployed instance
      value: { get_attr: [my_instance, first_address] }

Output values are typically resolved using intrinsic function such as
the *get_attr* function in the example above (see also
:ref:`hot_spec_intrinsic_functions`).
