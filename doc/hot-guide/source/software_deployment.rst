.. _hot_software_deployment:

Software configuration
######################

There are a variety of options to configure the software which runs on the
servers in your stack. These can be broadly divided into the following:

* Custom image building

* User-data boot scripts and cloud-init

* Software deployment resources

This section will describe each of these options and provide examples for
using them together in your stacks.

Image building
**************

The first opportunity to influence what software is configured on your servers
is by booting them with a custom-built image. There are a number of reasons
you might want to do this, including:

* **Boot speed** - since the required software is already on the image there
  is no need to download and install anything at boot time.

* **Boot reliability** - software downloads can fail for a number of reasons
  including transient network failures and inconsistent software repositories.

* **Test verification** - custom built images can be verified in test
  environments before being promoted to production.

* **Configuration dependencies** - post-boot configuration may depend on
  agents already being installed and enabled

A number of tools are available for building custom images, including:

* diskimage-builder_ image building tools for OpenStack

* imagefactory_ builds images for a variety of operating system/cloud
  combinations

Examples in this guide which require custom images will use diskimage-builder_.

User-data boot scripts and cloud-init
*************************************

When booting a server it is possible to specify the contents of the user-data
to be passed to that server. This user-data is made available either from
configured config-drive or from the `Metadata service`_.

How this user-data is consumed depends on the image being booted, but the most
commonly used tool for default cloud images is Cloud-init_.

Whether the image is using Cloud-init_ or not, it should be possible to
specify a shell script in the user_data property and have it be executed by
the server during boot:

.. code-block:: yaml

    resources:

      the_server:
        type: OS::Nova::Server
        properties:
          # flavor, image etc
          user_data: |
            #!/bin/bash
            echo "Running boot script"
            # ...

..

    **Tip**: debugging these scripts it is often useful to view the boot
    log using ``nova console-log <server-id>`` to view the progress of boot
    script execution.

Often there is a need to set variable values based on parameters or resources
in the stack. This can be done with the ``str_replace`` intrinsic function:

.. code-block:: yaml

    parameters:
      foo:
        default: bar

    resources:

      the_server:
        type: OS::Nova::Server
        properties:
          # flavor, image etc
          user_data:
            str_replace:
              template: |
                #!/bin/bash
                echo "Running boot script with $FOO"
                # ...
              params:
                $FOO: {get_param: foo}

..

    **Warning**: If a stack-update is performed and there are any changes
    at all to the content of user_data then the server will be replaced
    (deleted and recreated) so that the modified boot configuration can be
    run on a new server.

When these scripts grow it can become difficult to maintain them inside the
template, so the ``get_file`` intrinsic function can be used to maintain the
script in a separate file:

.. code-block:: yaml

    parameters:
      foo:
        default: bar

    resources:

      the_server:
        type: OS::Nova::Server
        properties:
          # flavor, image etc
          user_data:
            str_replace:
              template: {get_file: the_server_boot.sh}
              params:
                $FOO: {get_param: foo}

..

    **Tip**: ``str_replace`` can replace any strings, not just strings
    starting with ``$``. However doing this for the above example is useful
    because the script file can be executed for testing by passing in
    environment variables.

Choosing the user_data_format
=============================

The :hotref:`OS::Nova::Server` user_data_format property determines how the
user_data should be formatted for the server. For the default value
``HEAT_CFNTOOLS``, the user_data is bundled as part of the heat-cfntools
cloud-init boot configuration data. While ``HEAT_CFNTOOLS`` is the default
for ``user_data_format``, it is considered legacy and ``RAW`` or
``SOFTWARE_CONFIG`` will generally be more appropriate.

For ``RAW`` the user_data is passed to Nova unmodified. For a Cloud-init_
enabled image, the following are both valid ``RAW`` user-data:


.. code-block:: yaml

    resources:

      server_with_boot_script:
        type: OS::Nova::Server
        properties:
          # flavor, image etc
          user_data_format: RAW
          user_data: |
            #!/bin/bash
            echo "Running boot script"
            # ...

      server_with_cloud_config:
        type: OS::Nova::Server
        properties:
          # flavor, image etc
          user_data_format: RAW
          user_data: |
            #cloud-config
            final_message: "The system is finally up, after $UPTIME seconds"

For ``SOFTWARE_CONFIG`` user_data is bundled as part of the software config
data, and metadata is derived from any associated
`Software deployment resources`_.

Signals and wait conditions
===========================

Often it is necessary to pause further creation of stack resources until the
boot configuration script has notified that it has reached a certain state.
This is usually either to notify that a service is now active, or to pass out
some generated data which is needed by another resource. The resources
:hotref:`OS::Heat::WaitCondition` and :hotref:`OS::Heat::SwiftSignal` both perform
this function using different techniques and tradeoffs.

:hotref:`OS::Heat::WaitCondition` is implemented as a call to the
`Orchestration API`_ resource signal. The token is created using credentials
for a user account which is scoped only to the wait condition handle
resource. This user is created when the handle is created, and is associated
to a project which belongs to the stack, in an identity domain which is
dedicated to the orchestration service.

Sending the signal is a simple HTTP request, as with this example using curl_:

.. code-block:: sh

    curl -i -X POST -H 'X-Auth-Token: <token>' \
         -H 'Content-Type: application/json' -H 'Accept: application/json' \
         '<wait condition URL>' --data-binary '<json containing signal data>'

The JSON containing the signal data is expected to be of the following format:

.. code-block:: json

    {
      "status": "SUCCESS",
      "reason": "The reason which will appear in the 'heat event-list' output",
      "data": "Data to be used elsewhere in the template via get_attr",
      "id": "Optional unique ID of signal"
    }

All of these values are optional, and if not specified will be set to the
following defaults:

.. code-block:: json

    {
      "status": "SUCCESS",
      "reason": "Signal <id> received",
      "data": null,
      "id": "<sequential number starting from 1 for each signal received>"
    }

If ``status`` is set to ``FAILURE`` then the resource (and the stack) will go
into a ``FAILED`` state using the ``reason`` as failure reason.

The following template example uses the convenience attribute ``curl_cli``
which builds a curl command with a valid token:

.. code-block:: yaml

    resources:
      wait_condition:
        type: OS::Heat::WaitCondition
        properties:
          handle: {get_resource: wait_handle}
          # Note, count of 5 vs 6 is due to duplicate signal ID 5 sent below
          count: 5
          timeout: 300

      wait_handle:
        type: OS::Heat::WaitConditionHandle

      the_server:
        type: OS::Nova::Server
        properties:
          # flavor, image etc
          user_data_format: RAW
          user_data:
            str_replace:
              template: |
                #!/bin/sh
                # Below are some examples of the various ways signals
                # can be sent to the Handle resource

                # Simple success signal
                wc_notify --data-binary '{"status": "SUCCESS"}'

                # Or you optionally can specify any of the additional fields
                wc_notify --data-binary '{"status": "SUCCESS", "reason": "signal2"}'
                wc_notify --data-binary '{"status": "SUCCESS", "reason": "signal3", "data": "data3"}'
                wc_notify --data-binary '{"status": "SUCCESS", "reason": "signal4", "data": "data4"}'

                # If you require control of the ID, you can pass it.
                # The ID should be unique, unless you intend for duplicate
                # signals to overrite each other.  The following two calls
                # do the exact same thing, and will be treated as one signal
                # (You can prove this by changing count above to 7)
                wc_notify --data-binary '{"status": "SUCCESS", "id": "5"}'
                wc_notify --data-binary '{"status": "SUCCESS", "id": "5"}'

                # Example of sending a failure signal, optionally
                # reason, id, and data can be specified as above
                # wc_notify --data-binary '{"status": "FAILURE"}'
              params:
                wc_notify: { get_attr: [wait_handle, curl_cli] }

    outputs:
      wc_data:
        value: { get_attr: [wait_condition, data] }
        # this would return the following json
        # {"1": null, "2": null, "3": "data3", "4": "data4", "5": null}

      wc_data_4:
        value: { get_attr: [wait_condition, data, '4'] }
        # this would return "data4"

..

:hotref:`OS::Heat::SwiftSignal` is implemented by creating an Object Storage
API temporary URL which is populated with signal data with an HTTP PUT. The
orchestration service will poll this object until the signal data is available.
Object versioning is used to store multiple signals.

Sending the signal is a simple HTTP request, as with this example using curl_:

.. code-block:: sh

    curl -i -X PUT '<object URL>' --data-binary '<json containing signal data>'

The above template example only needs to have the ``type`` changed to the
swift signal resources:

.. code-block:: yaml

    resources:
      signal:
        type: OS::Heat::SwiftSignal
        properties:
          handle: {get_resource: wait_handle}
          timeout: 300

      signal_handle:
        type: OS::Heat::SwiftSignalHandle
      # ...

The decision to use :hotref:`OS::Heat::WaitCondition` or
:hotref:`OS::Heat::SwiftSignal` will depend on a few factors:

* :hotref:`OS::Heat::SwiftSignal` depends on the availability of an Object
  Storage API
* :hotref:`OS::Heat::WaitCondition` depends on whether the orchestration
  service has been configured with a dedicated stack domain (which may depend
  on the availability of an Identity V3 API).
* The preference to protect signal URLs with token authentication or a
  secret webhook URL.


Software config resources
=========================

Boot configuration scripts can also be managed as their own resources. This
allows configuration to be defined once and run on multiple server resources.
These software-config resources are stored and retrieved via dedicated calls
to the `Orchestration API`_. It is not possible to modify the contents of an
existing software-config resource, so a stack-update which changes any
existing software-config resource will result in API calls to create a new
config and delete the old one.

The resource :hotref:`OS::Heat::SoftwareConfig` is used for storing configs
represented by text scripts, for example:

.. code-block:: yaml

    resources:
      boot_script:
        type: OS::Heat::SoftwareConfig
        properties:
          group: ungrouped
          config: |
            #!/bin/bash
            echo "Running boot script"
            # ...

      server_with_boot_script:
        type: OS::Nova::Server
        properties:
          # flavor, image etc
          user_data_format: RAW
          user_data: {get_resource: boot_script}

The resource :hotref:`OS::Heat::CloudConfig` allows Cloud-init_ cloud-config to
be represented as template YAML rather than a block string. This allows
intrinsic functions to be included when building the cloud-config. This also
ensures that the cloud-config is valid YAML, although no further checks for
valid cloud-config are done.

.. code-block:: yaml

    parameters:
      file_content:
        type: string
        description: The contents of the file /tmp/file

    resources:
      boot_config:
        type: OS::Heat::CloudConfig
        properties:
          cloud_config:
            write_files:
            - path: /tmp/file
              content: {get_param: file_content}

      server_with_cloud_config:
        type: OS::Nova::Server
        properties:
          # flavor, image etc
          user_data_format: RAW
          user_data: {get_resource: boot_config}

..

The resource :hotref:`OS::Heat::MultipartMime` allows multiple
:hotref:`OS::Heat::SoftwareConfig` and :hotref:`OS::Heat::CloudConfig`
resources to be combined into a single Cloud-init_ multi-part message:

.. code-block:: yaml

    parameters:
      file_content:
        type: string
        description: The contents of the file /tmp/file

      other_config:
        type: string
        description: The ID of a software-config resource created elsewhere

    resources:
      boot_config:
        type: OS::Heat::CloudConfig
        properties:
          cloud_config:
            write_files:
            - path: /tmp/file
              content: {get_param: file_content}

      boot_script:
        type: OS::Heat::SoftwareConfig
        properties:
          group: ungrouped
          config: |
            #!/bin/bash
            echo "Running boot script"
            # ...

      server_init:
        type: OS::Heat::MultipartMime
        properties:
          parts:
          - config: {get_resource: boot_config}
          - config: {get_resource: boot_script}
          - config: {get_resource: other_config}

      server:
        type: OS::Nova::Server
        properties:
          # flavor, image etc
          user_data_format: RAW
          user_data: {get_resource: server_init}

..

Software deployment resources
*****************************

There are many situations where it is not desirable to replace the server
whenever there is a configuration change. The
:hotref:`OS::Heat::SoftwareDeployment` resource allows any number of software
configurations to be added or removed from a server throughout its life-cycle.


Building custom image for software deployments
==============================================

:hotref:`OS::Heat::SoftwareConfig` resources are used to store software
configuration, and a :hotref:`OS::Heat::SoftwareDeployment` resource is used
to associate a config resource with one server. The ``group`` attribute on
:hotref:`OS::Heat::SoftwareConfig` specifies what tool will consume the
config content.

:hotref:`OS::Heat::SoftwareConfig` has the ability to define a schema of
``inputs`` and which the configuration script supports. Inputs are mapped to
whatever concept the configuration tool has for assigning
variables/parameters.

Likewise, ``outputs`` are mapped to the tool's capability to export structured
data after configuration execution. For tools which do not support this,
outputs can always be written to a known file path for the hook to read.

The :hotref:`OS::Heat::SoftwareDeployment` resource allows values to be
assigned to the config inputs, and the resource remains in an ``IN_PROGRESS``
state until the server signals to heat what (if any) output values were
generated by the config script.

Custom image script
===================

Each of the following examples requires that the servers be booted with a
custom image. The following script uses diskimage-builder to create an image
required in later examples:

.. code-block:: sh

    # Clone the required repositories. Some of these are also available
    # via pypi or as distro packages.
    git clone https://git.openstack.org/openstack/diskimage-builder.git
    git clone https://git.openstack.org/openstack/tripleo-image-elements.git
    git clone https://git.openstack.org/openstack/heat-templates.git

    # Required by diskimage-builder to discover element collections
    export ELEMENTS_PATH=tripleo-image-elements/elements:heat-templates/hot/software-config/elements

    # The base operating system element(s) provided by the diskimage-builder
    # elements collection. Other values which may work include:
    # centos7, debian, opensuse, rhel, rhel7, or ubuntu
    export BASE_ELEMENTS="fedora selinux-permissive"
    # Install and configure the os-collect-config agent to poll the heat service
    # for configuration changes to execute
    export AGENT_ELEMENTS="os-collect-config os-refresh-config os-apply-config"


    # heat-config installs an os-refresh-config script which will invoke the
    # appropriate hook to perform configuration. The element heat-config-script
    # installs a hook to perform configuration with shell scripts
    export DEPLOYMENT_BASE_ELEMENTS="heat-config heat-config-script"

    # Install a hook for any other chosen configuration tool(s).
    # Elements which install hooks include:
    # heat-config-cfn-init, heat-config-puppet, or heat-config-salt
    export DEPLOYMENT_TOOL=""

    # The name of the qcow2 image to create, and the name of the image
    # uploaded to the OpenStack image registry.
    export IMAGE_NAME=fedora-software-config

    # Create the image
    diskimage-builder/bin/disk-image-create vm $BASE_ELEMENTS $AGENT_ELEMENTS \
         $DEPLOYMENT_BASE_ELEMENTS $DEPLOYMENT_TOOL -o $IMAGE_NAME.qcow2

    # Upload the image, assuming valid credentials are already sourced
    glance image-create --disk-format qcow2 --container-format bare \
        --name $IMAGE_NAME < $IMAGE_NAME.qcow2

..

Configuring with scripts
========================

The `Custom image script`_ already includes the ``heat-config-script`` element
so the built image will already have the ability to configure using shell
scripts.

Config inputs are mapped to shell environment variables. The script can
communicate outputs to heat by writing to the file
``$heat_outputs_path.<output name>``. See the following example for a script
which expects inputs ``foo``, ``bar`` and generates an output ``result``.

.. code-block:: yaml

    resources:
      config:
        type: OS::Heat::SoftwareConfig
        properties:
          group: script
          inputs:
          - name: foo
          - name: bar
          outputs:
          - name: result
          config: |
            #!/bin/sh -x
            echo "Writing to /tmp/$bar"
            echo $foo > /tmp/$bar
            echo -n "The file /tmp/$bar contains `cat /tmp/$bar` for server $deploy_server_id during $deploy_action" > $heat_outputs_path.result
            echo "Written to /tmp/$bar"
            echo "Output to stderr" 1>&2

      deployment:
        type: OS::Heat::SoftwareDeployment
        properties:
          config:
            get_resource: config
          server:
            get_resource: server
          input_values:
            foo: fooooo
            bar: baaaaa

      server:
        type: OS::Nova::Server
        properties:
          # flavor, image etc
          user_data_format: SOFTWARE_CONFIG

    outputs:
      result:
        value:
          get_attr: [deployment, result]
      stdout:
        value:
          get_attr: [deployment, deploy_stdout]
      stderr:
        value:
          get_attr: [deployment, deploy_stderr]
      status_code:
        value:
          get_attr: [deployment, deploy_status_code]

..


    **Tip**: A config resource can be associated with multiple deployment
    resources, and each deployment can specify the same or different values
    for the ``server`` and ``input_values`` properties.

As can be seen in the ``outputs`` section of the above template, the
``result`` config output value is available as an attribute on the
``deployment`` resource. Likewise the captured stdout, stderr and status_code
are also available as attributes.

Configuring with os-apply-config
================================

The agent toolchain of ``os-collect-config``, ``os-refresh-config`` and
``os-apply-config`` can actually be used on their own to inject heat stack
configuration data into a server running a custom image.

The custom image needs to have the following to use this approach:

* All software dependencies installed

* os-refresh-config_ scripts to be executed on configuration changes

* os-apply-config_ templates to transform the heat-provided config data into
  service configuration files

The projects tripleo-image-elements_ and tripleo-heat-templates_ demonstrate
this approach.

Configuring with cfn-init
=========================

Likely the only reason to use the ``cfn-init`` hook is to migrate templates
which contain `AWS::CloudFormation::Init`_ metadata without needing a
complete rewrite of the config metadata. It is included here as it introduces
a number of new concepts.

To use the ``cfn-init`` tool the ``heat-config-cfn-init`` element is required
to be on the built image, so `Custom image script`_ needs to be modified with
the following:

.. code-block:: sh

    export DEPLOYMENT_TOOL="heat-config-cfn-init"
..

Configuration data which used to be included in the
``AWS::CloudFormation::Init`` section of resource metadata is instead moved
to the ``config`` property of the config resource, as in the following
example:

.. code-block:: yaml

    resources:

      config:
        type: OS::Heat::StructuredConfig
        properties:
          group: cfn-init
          inputs:
          - name: bar
          config:
            config:
              files:
                /tmp/foo:
                  content:
                    get_input: bar
                  mode: '000644'

      deployment:
        type: OS::Heat::StructuredDeployment
        properties:
          name: 10_deployment
          signal_transport: NO_SIGNAL
          config:
            get_resource: config
          server:
            get_resource: server
          input_values:
            bar: baaaaa

      other_deployment:
        type: OS::Heat::StructuredDeployment
        properties:
          name: 20_other_deployment
          signal_transport: NO_SIGNAL
          config:
            get_resource: config
          server:
            get_resource: server
          input_values:
            bar: barmy

      server:
        type: OS::Nova::Server
        properties:
          image: {get_param: image}
          flavor: {get_param: flavor}
          key_name: {get_param: key_name}
          user_data_format: SOFTWARE_CONFIG

..

There are a number of things to note about this template example:

* :hotref:`OS::Heat::StructuredConfig` is like
  :hotref:`OS::Heat::SoftwareConfig` except that the ``config`` property
  contains structured YAML instead of text script. This is useful for a
  number of other configuration tools including ansible, salt and
  os-apply-config.

* ``cfn-init`` has no concept of inputs, so ``{get_input: bar}`` acts as a
  placeholder which gets replaced with the
  :hotref:`OS::Heat::StructuredDeployment` ``input_values`` value when the
  deployment resource is created.

* ``cfn-init`` has no concept of outputs, so specifying
  ``signal_transport: NO_SIGNAL`` will mean that the deployment resource will
  immediately go into the ``CREATED`` state instead of waiting for a
  completed signal from the server.

* The template has 2 deployment resources deploying the same config with
  different ``input_values``. The order these are deployed in on the server
  is determined by sorting the values of the ``name`` property for each
  resource (10_deployment, 20_other_deployment)

Configuring with puppet
=======================

The puppet_ hook makes it possible to write configuration as puppet manifests
which are deployed and run in a masterless environment.

To specify configuration as puppet manifests the ``heat-config-puppet``
element is required to be on the built image, so `Custom image script`_ needs
to be modified with the following:


.. code-block:: sh

    export DEPLOYMENT_TOOL="heat-config-puppet"
..


.. code-block:: yaml

    resources:

      config:
        type: OS::Heat::SoftwareConfig
        properties:
          group: puppet
          inputs:
          - name: foo
          - name: bar
          outputs:
          - name: result
          config:
            get_file: example-puppet-manifest.pp

      deployment:
        type: OS::Heat::SoftwareDeployment
        properties:
          config:
            get_resource: config
          server:
            get_resource: server
          input_values:
            foo: fooooo
            bar: baaaaa

      server:
        type: OS::Nova::Server
        properties:
          image: {get_param: image}
          flavor: {get_param: flavor}
          key_name: {get_param: key_name}
          user_data_format: SOFTWARE_CONFIG

    outputs:
      result:
        value:
          get_attr: [deployment, result]
      stdout:
        value:
    get_attr: [deployment, deploy_stdout]

..

This demonstrates the use of the ``get_file`` function, which will attach the
contents of the file ``example-puppet-manifest.pp``, containing:

.. code-block:: puppet

    file { 'barfile':
        ensure  => file,
        mode    => '0644',
        path    => '/tmp/$::bar',
        content => '$::foo',
    }

    file { 'output_result':
        ensure  => file,
        path    => '$::heat_outputs_path.result',
        mode    => '0644',
        content => 'The file /tmp/$::bar contains $::foo',
    }
..


.. _`AWS::CloudFormation::Init`: http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-init.html
.. _diskimage-builder: https://github.com/openstack/diskimage-builder
.. _imagefactory: http://imgfac.org/
.. _`Metadata service`: http://docs.openstack.org/admin-guide-cloud/content/section_metadata-service.html
.. _Cloud-init: http://cloudinit.readthedocs.org/en/latest/
.. _curl: http://curl.haxx.se/
.. _`Orchestration API`: http://developer.openstack.org/api-ref-orchestration-v1.html
.. _os-refresh-config: https://github.com/openstack/os-refresh-config
.. _os-apply-config: https://github.com/openstack/os-apply-config
.. _tripleo-heat-templates: https://github.com/openstack/tripleo-heat-templates
.. _tripleo-image-elements: https://github.com/openstack/tripleo-image-elements
.. _puppet: http://puppetlabs.com/
