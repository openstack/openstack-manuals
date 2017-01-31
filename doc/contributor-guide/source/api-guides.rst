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

* https://git.openstack.org/cgit/openstack/nova/tree/api-guide
* https://git.openstack.org/cgit/openstack/nova/tree/api-ref

For service names, you must adhere to the official name for the service as
indicated in the governance repository in the ``reference/projects.yaml``
file. These names are used in the URL for the documentation by stating the
target directory for the content in the ``api-ref-jobs:`` indicator. If
your service does not have a name indicated in the governance repo,
please ask your PTL or a Technical Committee member how to proceed.

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

    import openstackdocstheme

    extensions = [
        'os_api_ref',
    ]


    html_theme = 'openstackdocs'
    html_theme_path = [openstackdocstheme.get_html_theme_path()]
    html_theme_options = {
        "sidebar_mode": "toc",
    }
    html_context = {'bug_project': 'nova', 'bug_tag': 'api-ref'}

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
      # the API Ref to developer.openstack.org.
      commands =
      rm -rf api-ref/build
      sphinx-build -W -b html -d api-ref/build/doctrees api-ref/source api-ref/build/html

#. Test the ``tox.ini`` changes by running this tox command:

   .. code-block:: console

      $ tox -e api-ref

#. Create a build job similar to the nova job for your project. Examples:
   https://review.openstack.org/#/c/305464/ and
   https://review.openstack.org/#/c/305485/.

After the source files and build jobs exist, the docs are built to
`developer.openstack.org`_.

If your document is completely new, you need to add links to it from the API
landing page and the OpenStack Governance reference document, projects.yaml.

To add a link to the project's API docs to the API landing page, patch the
``index.rst`` file stored in the `openstack/api-site repository`_.

To ensure the openstack/governance repository has the correct link to your API
documentation, patch the ``reference/projects.yaml`` file in the
`openstack/governance repository`.



.. _`developer.openstack.org`: https://developer.openstack.org
.. _`wadl2rst`: http://github.com/annegentle/wadl2rst
.. _`Compute API Guide`: https://developer.openstack.org/api-guide/compute
.. _`example patch`: https://review.openstack.org/#/c/233446/
.. _`API documentation guidelines`: https://specs.openstack.org/openstack/api-wg/guidelines/api-docs.html
.. _`nova example`: https://github.com/openstack/nova/blob/master/api-ref/source/conf.py
.. _`openstack/api-site repository`: https://git.openstack.org/cgit/openstack/api-site/tree/api-quick-start/source/index.rst
.. _`openstack/governance repository`: https://git.openstack.org/cgit/openstack/governance/tree/reference/projects.yaml
