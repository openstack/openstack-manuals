=======
Scripts
=======

openstack-doc-tools repository
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

autogenerate_config_docs
  Generate configuration references published on
  http://docs.openstack.org/mitaka/config-reference/.

build_environment directory (deprecated)
  A Vagrant environment for working with the guides.

cleanup directory
  Manually cleanup documentation files.

sitemap
  Generate the sitemap.xml file.

bin
  Contains scripts for building documents in the ``openstack-manuals``
  repository. Used inside the tox environments.

os_doc_tools directory
----------------------

openstack-doc-test
  Check niceness of the documentation. Tests links, whitespace, line-endings.
  See :ref:`openstack-doc-test`.

openstack-autohelp
  Helper script run from the git repo by ``autogenerate_config_docs``.

openstack-auto-commands
  Generate the command line reference published at
  http://docs.openstack.org/cli-reference/. A helper script to use this
  tool is available at ``bin/doc-tools-update-cli-reference``.

openstack-generate-docbook
  Check translated docbook documentation builds.

openstack-generate-pot
  Generate pot files from docbook files.

openstack-jsoncheck
  Check JSON files. Used for the API guides


openstack-manuals repository
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Several scripts currently reside in the `openstack-manuals
<https://github.com/openstack/openstack-manuals>`_ repository. It may be
beneficial to consolidate these into the ``openstack-doc-tools`` repository.

www-generator.py
  Generate static, template-based html files for http://docs.openstack.org/.

sync-projects.sh
  Synchronizes the **Glossary**, common files, entity files, and some
  translations across multiple repos, including ``api-site``, ``ha-guide``,
  ``security-doc``, and ``operations-guide``.

glossary2rst.py
  Convert existing docbook glossary to rst prior to the build of rst
  guides. Will be removed when all books are in RST format.

publishdocs.sh
  Publishdocs job uses this script to publish documentation to
  http://docs.openstack.org/.


Notes
~~~~~

- ``openstack-doc-tools`` must be released so it can be pinned in requirements
  files, enabling automation to work across repositories.

- There are many undocumented synchronizations (automated and manual) between
  the various documentation repositories. These should be documented.

- There are a several jobs that must be run regularly, for example updating
  the ``sitemap.xml`` file and the command line configuration reference. These
  should be documented.

- Some manual jobs should be automated. For example, the ``sitemap.xml`` file
  should be automatically updated by the Gerritbot.
