.. _api-docs:

===========================
OpenStack API documentation
===========================

Source files for developer.openstack.org
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The `developer.openstack.org`_ web site is intended for application developers
using the OpenStack APIs to build upon. It contains links to multiple SDKs for
specific programming languages. The API references and API Guides are
stored on `docs.openstack.org`_.

For existing APIs, the reference information comes from RST and YAML source
files. The RST and YAML files get stored in your project repository in an
``api-ref`` directory. The nova project has an example you can follow,
including tox jobs for running ``tox -e api-ref`` within the ``api-ref``
directory to generate the documents.

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
providing a REST API service in OpenStack strive to follow. This
document tells you what and how much to write. If you follow the suggested
outline, your API guide will be accurate and complete.

If your project does not have any documentation, you can find a suggested
outline in the `API documentation guidelines`_. The Compute project has
examples to follow:

* `OpenStack nova api-guide <https://opendev.org/openstack/nova/src/branch/master/api-guide>`_
* `OpenStack nova api-ref <https://opendev.org/openstack/nova/src/branch/master/api-ref>`_

For service names, you must adhere to the official name for the service as
indicated in the governance repository in the ``reference/projects.yaml``
file. These names are used in the URL for the documentation by stating the
target directory for the content in the ``api-ref-jobs:`` indicator. If
your service does not have a name indicated in the governance repo,
please ask your PTL or a Technical Committee member how to proceed.

Versions and releases for API reference information
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

All API reference jobs publish from master as soon as a change lands in the
respective project repository. This publishing practice means that you must
write inline information when an API has a change release-to-release. Inline
text descriptions are the only way to convey the corresponding release
information to the documentation consumer.

There are different types of versions related to OpenStack services that
provide an API. For example, a version of a service is separate from the
version of an API provided by that service. Also, `microversions`_
are small, documented changes to an individual API method, and are only
applicable to some OpenStack APIs, as indicated with (microversions) on
the `API Quick Start page`_.

Example representations of versions for the OpenStack Compute service:

* Header version: `OpenStack-API-Version: compute 2.1`
* Service version (Release name): 15.0 (Newton)
* URI version:  `https://servers.api.openstack.org/v2.1/`
* MIME type version: `application/vnd.openstack.compute.v2.1+json`
* Microversion: `2.6`

Each project that follows the `cycle-with-milestones release model`_ has stable
branches that contain a point-in-time set of API reference content. If needed,
refer to that source repository's content for release comparisons for API
reference information.

.. _how-to-document-api:

How to document your OpenStack API service
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use these instructions if you have no documentation currently, or want to
update it to match OpenStack standards.

The basic steps are:

#. Create an ``api-ref/source`` directory in your project repository.

#. Create a ``conf.py`` for the project, similar to the `nova example`_. In it,
   include the html theme, openstackdocstheme, use the os-api-ref Sphinx
   extension, and also point the bug reporting link to your project's repo::

    extensions = [
        'os_api_ref',
        'openstackdocstheme'
    ]

    # The prefix and repo name like
    repository_name = 'openstack/glance'
    # Set Launchpad bug tag, default is empty
    bug_tag = ''
    # The launchpad project name like
    bug_project = 'glance'

    html_theme = 'openstackdocs'
    html_theme_options = {
        "sidebar_mode": "toc",
    }

#. Update the ``test-requirements.txt`` file for the project with a line for
   the ``os-api-ref`` Sphinx extension::

       os-api-ref>=1.0.0 # Apache-2.0

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
      # the API Ref to docs.openstack.org.
      whitelist_externals = rm
      commands =
        rm -rf api-ref/build
        sphinx-build -W -b html -d api-ref/build/doctrees api-ref/source api-ref/build/html

#. Test the ``tox.ini`` changes by running this tox command:

   .. code-block:: console

      $ tox -e api-ref

#. Add the ``api-ref-jobs`` template to your project, patch the
   `zuul.d/projects.yaml <https://opendev.org/openstack/project-config/src/branch/master/zuul.d/projects.yaml>`__
   file stored in ``openstack/project-config`` repository.

After the source files and build jobs exist, the docs are built to
`docs.openstack.org`_.

If your document is completely new, you need to add links to it from the API
landing page and the OpenStack Governance reference document,
``projects.yaml``.

To add a link to the project's API docs to the API landing page, patch the
``index.rst`` file stored in the `openstack/api-site repository`_.

To ensure the openstack/governance repository has the correct link to your API
documentation, patch the ``reference/projects.yaml`` file in the
`openstack/governance repository`_.



.. _`developer.openstack.org`: https://developer.openstack.org
.. _`docs.openstack.org`: https://docs.openstack.org
.. _`wadl2rst`: https://github.com/annegentle/wadl2rst
.. _`Compute API Guide`: https://docs.openstack.org/api-guide/compute
.. _`example patch`: https://review.opendev.org/#/c/233446/
.. _`API documentation guidelines`: https://specs.openstack.org/openstack/api-wg/guidelines/api-docs.html
.. _`microversions`: https://docs.openstack.org/api-guide/compute/microversions.html
.. _`API Quick Start page`: https://docs.openstack.org/api-quick-start/
.. _`cycle-with-milestones release model`: https://releases.openstack.org/reference/release_models.html#cycle-with-milestones
.. _`nova example`: https://github.com/openstack/nova/blob/master/api-ref/source/conf.py
.. _`openstack/api-site repository`: https://opendev.org/openstack/api-site/src/branch/master/api-quick-start/source/index.rst
.. _`openstack/governance repository`: https://opendev.org/openstack/governance/src/branch/master/reference/projects.yaml

