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

How to migrate WADL files for your OpenStack API service
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If your project already has WADL files, they are migrated to Swagger files with
every commit to the api-site repository. However, some APIs cannot be described
with Swagger.

When your project needs to migrate to RST (.inc) and YAML as nova has done,
follow these steps.

#. Clone the api-site repository locally.

   .. code-block:: console

      $ git clone https://git.openstack.org/openstack/api-site

#. Clone the wadl2rst repository locally.

   .. code-block:: console

      $ git clone https://github.com/annegentle/wadl2rst

#. Create a Python virtual environment and use it.

   .. code-block:: console

      $ virtualenv wadl2rst
      $ source wadl2rst/bin/activate

#. Install the requirements and ``wadl2rst`` in the virtual
   environment.

   .. code-block:: console

      $ pip install -r requirements.txt
      $ pip install -e git+https://github.com/annegentle/wadl2rst@master#egg=wadl2rst

#. Create a ``.yaml`` configuration file with the following format.

   .. code-block:: yaml

      [wadl_path]:
          title: [book_title]
          output_file: [output_file]
          preamble: [preamble]

This format enables grouping of API operations for more manageable editing
later.

In the preamble, you can include a header and any introductory text for the
collected operations.

For example:

.. code-block:: yaml

   ../api-site/api-ref/src/wadls/identity-api/src/v2.0/wadl/identity.wadl:
     title: OpenStack Identity API v2.0
     output_file: dist/identity/identity.inc
     preamble: |
       ======
       Tokens
       ======

   Gets an authentication token that permits access to the
   OpenStack services REST API.

#. In the wadl2rst directory, run this command with your project's yaml file
   to run the migration.

   .. code-block:: console

      $ wadl2rst project.config.yaml

#. Look at the RST files generated and make sure they contain all the
   operations you expect. Note that the file extension is ``.inc`` to avoid
   build errors. When included files are ``.inc`` files, Sphinx does not issue
   warnings about generating the documents twice, or documents not being in
   a toc directive.

#. Next, get a copy of the ``parameters.yaml`` file for your service from the
   fairy-slipper project. You can get those from
   https://review.openstack.org/#/c/301958/.

   The YAML files can be referenced from the RST files, and the migration tool
   inserts pointers to parameters, such as:

   .. code-block:: none

      .. rest_parameters:: parameters.yaml

         - name: name
         - description: description
         - alias: alias
         - updated: updated

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
   GET /v2/alarms/​{alarm_id}​
   PUT /v2/alarms/​{alarm_id}​
   DELETE /v2/alarms/​{alarm_id}​
   PUT /v2/alarms/​{alarm_id}​/state
   GET /v2/alarms/​{alarm_id}​/state
   GET /v2/alarms/​{alarm_id}​/history
   GET /v2/meters
   POST /v2/meters/​{meter_name}​
   GET /v2/meters/​{meter_name}​
   GET /v2/meters/​{meter_name}​/statistics
   GET /v2/samples
   GET /v2/samples/​{sample_id}​
   GET /v2/resources
   GET /v2/resources/​{resource_id}​
   GET /v2/capabilities
   GET /v2/events
   GET /v2/events/​{message_id}

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
