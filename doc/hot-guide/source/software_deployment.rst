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

Examples in this guide which require custom images will use
diskimage-builder_.

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

The ``OS::Nova::Server`` user_data_format property determines how the
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
data, and metadata is derived from any associated software deployment
resources.

Signals and wait conditions
===========================

Often it is necessary to pause further creation of stack resources until the
boot configuration script has notified that it has reached a certain state.
This is usually either to notify that a service is now active, or to pass out
some generated data which is needed by another resource. The resources
``OS::Heat::WaitCondition`` and ``OS::Heat::SwiftSignal`` both perform this
function using different techniques and tradeoffs.

``OS::Heat::WaitCondition`` is implemented as a call to the
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

``OS::Heat::SwiftSignal`` is implemented by creating an Object Storage API
temporary URL which is populated with signal data with an HTTP PUT. The
orchestration service will poll this object until the signal data is
available. Object versioning is used to store multiple signals.

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

The decision to use ``OS::Heat::WaitCondition`` or ``OS::Heat::SwiftSignal``
will depend on a few factors:

* ``OS::Heat::SwiftSignal`` depends on the availability of an Object Storage
  API
* ``OS::Heat::WaitCondition`` depends on whether the orchestration service
  has been configured with a dedicated stack domain (which may depend on the
  availability of an Identity V3 API).
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

The resource ``OS::Heat::SoftwareConfig`` is used for storing configs
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

The resource ``OS::Heat::CloudConfig`` allows Cloud-init_ cloud-config to be
represented as template YAML rather than a block string. This allows
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

The resource ``OS::Heat::MultipartMime`` allows multiple
``OS::Heat::SoftwareConfig`` and ``OS::Heat::CloudConfig`` resources to be
combined into a single Cloud-init_ multi-part message:

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

.. _diskimage-builder: https://github.com/openstack/diskimage-builder
.. _imagefactory: http://imgfac.org/
.. _`Metadata service`: http://docs.openstack.org/admin-guide-cloud/content/section_metadata-service.html
.. _Cloud-init: http://cloudinit.readthedocs.org/en/latest/
.. _curl: http://curl.haxx.se/
.. _`Orchestration API`: http://developer.openstack.org/api-ref-orchestration-v1.html