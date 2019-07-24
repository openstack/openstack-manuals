================
Scripts overview
================

This section provides an overview of scripts used by the OpenStack
documentation project, writers and developers, grouped by components they are
part of.

openstackdocstheme
~~~~~~~~~~~~~~~~~~

openstackdocstheme is a theme and extension support for Sphinx documentation
that is published to docs.openstack.org. It
provides an external link helper to automatically build links that change when
branches are created for each release series.

For more information, see
`External Link Helper <https://docs.openstack.org/openstackdocstheme/latest/#external-link-helper>`_.

oslo.config
~~~~~~~~~~~

The oslo.config library provides two extensions, a configuration documentation
directive and a configuration generator hook.

For more information, see `Sphinx Integration for oslo.config
<https://docs.openstack.org/oslo.config/latest/reference/sphinxext.html>`_
and `Sphinx Oslo Sample Config Generation
<https://docs.openstack.org/oslo.config/latest/reference/sphinxconfiggen.html>`_.

oslo.policy
~~~~~~~~~~~

The oslo.policy library provides two extensions, a policy documentation
directive and a policy generator hook.

For more information, see `Sphinx Oslo Sample Policy Generation
<https://docs.openstack.org/oslo.policy/latest/user/sphinxpolicygen.html>`_.

cliff
~~~~~

The cliff framework provides a directive to document multiple commands.

For more information, see `Sphinx Integration for cliff
<https://docs.openstack.org/cliff/latest/user/sphinxext.html>`_.

stevedore
~~~~~~~~~

The stevedore library provides a single directive for listing plugins for an
entrypoint.

For more information, see `Sphinx Integration for stevedore
<https://docs.openstack.org/stevedore/latest/user/sphinxext.html>`_.

openstack-doc-tools repository
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sitemap
  Generates the ``sitemap.xml`` file.

bin
  Contains scripts for building documents in the ``openstack-manuals``
  repository. Used inside the tox environments.

os_doc_tools directory
----------------------

openstack-jsoncheck
  Checks JSON files. Used for the API guides.


openstack-manuals repository
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Several scripts currently reside in the `openstack-manuals
<https://github.com/openstack/openstack-manuals>`_ repository. It may be
beneficial to consolidate these into the ``openstack-doc-tools`` repository.

www-generator.py
  Generates static, template-based HTML files for
  https://docs.openstack.org/. See :doc:`template-generator` for details.

sync-projects.sh
  Synchronizes the **Glossary**, common files, and some translations
  across multiple repositories, including ``api-site`` and ``security-doc``.

publishdocs.sh
  Publishdocs job uses this script to publish documentation to
  https://docs.openstack.org/.

Notes
~~~~~

- ``openstack-doc-tools`` must be released so it can be pinned in requirements
  files, enabling automation to work across repositories.

- There are many undocumented synchronizations (automated and manual) between
  the various documentation repositories. These should be documented.

- There are a several jobs that must be run regularly, for example, updating
  the ``sitemap.xml`` file and the command line configuration reference. These
  should be documented.

- Some manual jobs should be automated. For example, the ``sitemap.xml`` file
  should be automatically updated by the Gerritbot.
