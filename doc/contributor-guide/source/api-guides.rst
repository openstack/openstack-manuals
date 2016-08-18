.. _api-docs:

===========================
OpenStack API documentation
===========================

Source files for developer.openstack.org
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The `developer.openstack.org`_ web site is intended for application developers
using the OpenStack APIs to build upon. It contains links to multiple SDKs for
specific programming languages, API references, and API Guides.

For existing APIs, the reference information comes from RST and YAML source
files. To convert from WADL to RST, use a tool called `wadl2rst`_. Then store
the RST and YAML files in your project repository in an ``api-ref`` directory.
The nova project has an example you can follow, including tox jobs for running
``tox -e api`` within the ``wadl2rst`` directory to generate the documents.

Alternatively, a project can describe their API with Swagger or OpenAPI. To
learn more about the Swagger format and OpenAPI initiative, refer to
https://swagger.io. However, the HTML output builds for Swagger are not yet
created.

The RST conceptual and how-to files are stored in each project's
``doc/source/api-guide`` directory. These are built to locations based on the
service name, such as the `Compute API Guide`_.

You may embed annotations in your source code if you want to generate the
reference information. Here is an `example patch`_ from the nova project.
Because no project has complete annotations, there are no build jobs for this
scenario.

Standards for API reference in OpenStack
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The API working group has `API documentation guidelines`_ that all teams
providing a REST API service in OpenStack strive to follow.

For service names, you must adhere to the official name for the service as
indicated in the governance repository in the ``reference/projects.yaml``
file. These names are used in the URL for the documentation by stating the
target directory for the content in the ``api-ref-jobs:`` indicator. If
your service does not have a name indicated in the governance repo,
please ask your PTL or a Technical Committee member how to proceed.

.. _how-to-document-api:

How to document your OpenStack API service
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you have a WADL file, we recommend using the migration process to create
RST files for the content and YAML files for the parameters. See
:ref:`how-to-migrate-wadl`. If you have no documentation currently, or what to
update it to be consistent with other projects, read more here.

The basic steps are:

#. Create an ``api-ref/source`` directory in your project repository.

#. Create a ``conf.py`` for the project, similar to the `nova example`_.

#. Update the ``test-requirements.txt`` file for the project with a line for
   the ``os-api-ref`` Sphinx extension::

       os-api-ref>=0.1.0 # Apache-2.0

#. Create RST files for each operation.

#. In the RST file, use ``.. rest_method::`` for each operation.

   Example: ``.. rest_method:: GET /v2.1/{tenant_id}/flavors``

#. In the RST file, add requests and responses that point to a
   ``parameters.yaml`` file::

    .. rest_parameters:: parameters.yaml

       - tenant_id: tenant_id

   Here is an example entry in ``parameters.yaml``::

       admin_tenant_id:
         description: |
           The UUID of the administrative project.
         in: path
         required: true
         type: string

#. Create sample JSON requests and responses and store in a directory, and
   point to those in your RST files. As an example::

    .. literalinclude:: samples/os-evacuate/server-evacuate-resp.json
       :language: javascript

#. Update the project's ``tox.ini`` file to include a configuration for
   building the API reference locally with these lines:

   .. code-block:: console

      [testenv:api-ref]
      # This environment is called from CI scripts to test and publish
      # the API Ref to developer.openstack.org.
      # NOTE(sdague): this target does not use constraints because
      # upstream infra does not yet support it. Once that's fixed, we can
      # drop the install_command.
      #
      # we do not used -W here because we are doing some slightly tricky
      # things to build a single page document, and as such, we are ok
      # ignoring the duplicate stanzas warning.
      install_command = pip install -U --force-reinstall {opts} {packages}
      commands =
        rm -rf api-ref/build
        sphinx-build -W -b html -d api-ref/build/doctrees api-ref/source api-ref/build/html

#. Test the ``tox.ini`` changes by running this tox command:

   .. code-block:: console

      $ tox -e api-ref

#. Create a build job similar to the nova job for your project. Examples:
   https://review.openstack.org/#/c/305464/ and
   https://review.openstack.org/#/c/305485/.

.. _how-to-migrate-wadl:

How to migrate WADL files for your OpenStack API service
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If your project already has WADL files, they are migrated to Swagger files with
every commit to the api-site repository. However, some APIs cannot be described
with Swagger.

When your project needs to migrate to RST (.inc) and YAML as nova has done,
follow these steps.

#. Clone the api-site repository:

   .. code-block:: console

      $ git clone https://github.com/openstack/api-site

   The files are available in api-ref/source/<service>/<version>/.

#. Look at the RST files generated and make sure they contain all the
   operations you expect. The ``.inc`` files contain groupings of the
   operations.

   .. note::

      Note that the file extension is ``.inc`` to avoid
      build errors. When included files are ``.inc`` files, Sphinx does not
      issue warnings about generating the documents twice, or documents not
      being in a toc directive.

#. In addition to separate files for each operation's parameters, there is a
   ``parameters.yaml`` file for your service. Check the accuracy of these
   files.

   The YAML files can be referenced from the RST files, you can place pointers
   to parameters, such as:

   .. code-block:: none

      .. rest_parameters:: parameters.yaml

         - name: name
         - description: description
         - alias: alias
         - updated: updated

#. Copy the files to your project's repository.

#. Refer to :ref:`how-to-document-api` for details on how to build and publish
   the files.

Optional: Determine how many operations are currently documented
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can run a screen scraper program if you want to get a count of
your project's total number of operations. The Python script,
``apirefscrape.py``, is in a ``/scripts/`` directory in the wadl2rst
repository.

#. To run the counting tool, clone a copy of the wadl2rst repository:

   .. code-block:: console

      $ git clone https://github.com/annegentle/wadl2rst

#. Change directories to ``wadl2rst`` and then create a python virtualenv:

   .. code-block:: console

     $ cd wadl2rst
     $ virtualenv wadl2rst

#. Install Python requests and lxml:

   .. code-block:: console

     $ pip install requests
     $ pip install lxml

#. Run the script.

.. code-block:: console

   $ python scripts/apirefscrape.py
   URL:  api-ref-telemetry-v2.html
   ----------
   19
   19
   GET /v2/alarms
   POST /v2/alarms
   GET /v2/alarms/{alarm_id}
   PUT /v2/alarms/{alarm_id}
   DELETE /v2/alarms/{alarm_id}
   PUT /v2/alarms/{alarm_id}/state
   GET /v2/alarms/{alarm_id}/state
   GET /v2/alarms/{alarm_id}/history
   GET /v2/meters
   POST /v2/meters/{meter_name}
   GET /v2/meters/{meter_name}
   GET /v2/meters/{meter_name}/statistics
   GET /v2/samples
   GET /v2/samples/{sample_id}
   GET /v2/resources
   GET /v2/resources/{resource_id}
   GET /v2/capabilities
   GET /v2/events
   GET /v2/events/{message_id}

You see output of each service, a count of all operations, and a listing of
each operation.

If your project does not have any documentation, then you may write Swagger
plus RST to document your API calls, parameters, and reference information. You
can generate Swagger from annotations or create Swagger from scratch. You
should review, store, and build RST for conceptual or how-to information from
your project team’s repository. You can find a suggested outline in the
`API documentation guidelines`_. The Compute project has examples to follow:

* http://git.openstack.org/cgit/openstack/nova/tree/api-guide
* http://git.openstack.org/cgit/openstack/nova/tree/api-ref

You need the `extensions`_ for the API reference information. Those will be
centralized in milestone 2, but for now you need to copy the directory to use
those.

All projects should use this set of `API documentation guidelines`_ from the
OpenStack API working group any time their service has a REST API. This
document tells you what and how much to write. If you follow the suggested
outline, your API guide will be accurate and complete.

After the source files and build jobs exist, the docs are built to
`developer.openstack.org`_.

For the nova project, place your how-to and conceptual articles in the
``api-guide`` folder in the nova repository. Other projects can mimic these
patches that created an api-guide and build jobs for the Compute api-guide. You
should also set up reference information in your project repo.

You can embed annotations in your source code if you want to generate the
reference information. Here’s an `example patch`_ from the nova project.
Because we haven’t had a project do this yet completely, the build jobs still
need to be written.

.. _`developer.openstack.org`: http://developer.openstack.org
.. _`wadl2rst`: http://github.com/annegentle/wadl2rst
.. _`Compute API Guide`: http://developer.openstack.org/api-guide/compute
.. _`example patch`: https://review.openstack.org/#/c/233446/
.. _`API documentation guidelines`: http://specs.openstack.org/openstack/api-wg/guidelines/api-docs.html
.. _`nova example`: https://github.com/openstack/nova/blob/master/api-ref/source/conf.py
.. _`extensions`: http://git.openstack.org/cgit/openstack/nova/tree/api-ref/ext
