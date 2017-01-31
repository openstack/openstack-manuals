=================================
Installation tutorials and guides
=================================

For the Newton release, a new method of publishing installation tutorials
and guides is being implemented. This will allow each big tent project to
create their own installation guide, based on a standard template,
in their own repository. These guides are then centrally published to
`docs.openstack.org <https://docs.openstack.org>`_.

For updates on the progress of this project, see the `Install Guide wiki
page <https://wiki.openstack.org/wiki/Documentation/InstallGuideWorkItems>`_.
If you would like to help out, `attend a meeting
<http://eavesdrop.openstack.org/#Documentation_Install_Team_Meeting>`_.

Set up project specific installation guides:

#. Install ``cookiecutter``:

   .. code-block:: console

      # pip install cookiecutter

#. Run the Install Guide cookiecutter to create a skeleton for your project:

   .. code-block:: console

      $ cookiecutter https://git.openstack.org/openstack/installguide-cookiecutter.git

   You will be prompted to answer questions to complete the installation.
   Content will be added to the ``install-guide`` directory in the
   top-level of the project repository.

#. Create a ``tox.ini`` environment for ``install-guide`` in your project
   repository, using this content:

   .. code-block:: ini

      [testenv:install-guide]
      commands = sphinx-build -a -E -W -d install-guide/build/doctrees -b html install-guide/source install-guide/build/html


#. Add your installation content, and test the build locally with ``tox``:

   .. code-block:: console

      $ tox -e install-guide

   The local build is in ``install-guide/build/html``.

#. Add the python package ``openstackdocstheme``  to the
   ``test-requirements.txt`` file. Copy the exact requirement line from the
   `global file
   <https://git.openstack.org/cgit/openstack/requirements/tree/global-requirements.txt>`_:

   .. code-block:: none

      openstackdocstheme>=1.5.0  # Apache-2.0

#. Commit the changes to your project repository for review.


After these changes have merged, you can set up the jobs for building.

#. Clone the ``project-config`` repo:

   .. code-block:: console

      $ git clone https://git.openstack.org/openstack-infra/project-config

#. In ``jenkins/jobs/projects.yaml``, add ``install-guide-jobs`` within the
   entry for your project:

   .. code-block:: yaml

      - project:
          name: heat
          tarball-site: tarballs.openstack.org
          doc-publisher-site: docs.openstack.org

          jobs:
          ...
           - install-guide-jobs:
               service: orchestration

   Here ``service`` is the service name of the project, like orchestration
   for heat.

   This defines the jobs using the JJB ``install-guide-jobs`` job-template.

#. In ``zuul/layout.yaml``, locate the entry for your project and add the
   ``install-guide-jobs`` template:

   .. code-block:: yaml

      - name: openstack/heat
        template:
          - name: install-guide-jobs

   This schedules the Install Guide jobs.

#. Commit the changes to the infra repository for review.

To create or update the master index file, create or update the
``www/project-install-guide/RELEASE/index.html`` file at the
``openstack-manuals`` repository.
For draft (unreleased) version, replace ``RELEASE`` with ``draft``.
