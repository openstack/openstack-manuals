.. _api-docs:

===========================
OpenStack API documentation
===========================

Source files for developer.openstack.org
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The `developer.openstack.org`_ web site is intended for application developers
using the OpenStack APIs to build upon. It contains links to multiple SDKs for
specific programming languages, an API reference, and API Guides.

For existing APIs, the reference information comes from RST and YAML source
files. To convert from WADL to RST, use a tool called `wadl2rst`_. Then store
the RST and YAML files in your project repository in an ``api-ref`` directory.
The nova project has an example you can follow, including tox jobs for running
``tox -e api`` to generate the documents.

Alternatively, a project can describe their API with Swagger or OpenAPI. To
learn more about the Swagger format and OpenAPI initiative, refer to
https://swagger.io.

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

How to document your OpenStack API service
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If your project already has WADL files, they are migrated to Swagger files with
every commit to the api-site repository. However, some APIs cannot be described
with Swagger.

If your project needs to migrate to RST and YAML as nova has done, follow these
steps.

#. Clone the api-site repository locally.::

    git clone git@github.com:openstack/api-site.git

#. Clone the wadl2rst repository locally.::

    git@github.com:annegentle/wadl2rst.git

#. Change directories to the ``wadl2rst`` directory.::

    cd wadl2rst

#. In the wadl2rst directory, create a configuration YAML file to indicate
which WADL file to migrate as well as the title and destination directory. The
first line provides a relative path to the WADL file. If you have multiple WADL
files, list them all in a single YAML file.::

    ../api-site/api-ref/src/wadls/compute-api/src/v2.1/wadl/os-instance-actions-v2.1.wadl:
    title: OpenStack Compute API v2.1
    output_directory: dist/collected
    ../api-site/api-ref/src/wadls/compute-api/src/v2.1/wadl/os-instance-usage-audit-log-v2.1.wadl:
    title: OpenStack Compute API v2.1
    output_directory: dist/collected

#. Save the file as a ``.yaml`` file, such as ``project.config.yaml``.

#. In the wadl2rst directory, run the script::

    wadl2rst project.config.yaml

#. Look at the RST files generated and make sure they contain all the
operations you expect.

Optional: You can run a screen scraper program if you want to get a count of
your project's total number of operations. The Python script,
``apirefscrape.py``, is in a ``/scripts/`` directory in the wadl2rst
repository. Run it like so.::

    python apirefscrape.py

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

You need the `extensions`_ for the API reference information.

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
.. _`extensions`: http://git.openstack.org/cgit/openstack/nova/tree/api-ref/ext
