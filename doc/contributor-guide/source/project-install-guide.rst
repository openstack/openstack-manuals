===============================
Project specific install guides
===============================

For the Newton release, a new method of publishing Installation Guides is
being implemented. This will allow each big tent project to create their
own Installation Guide, based on a standard 'cookie cutter' template, in
their own repository. These guides are then centrally published to the
docs.openstack.org page.

For updates on the progress of this project, see the ``Install Guide wiki
page <https://wiki.openstack.org/wiki/Documentation/InstallGuideWorkItems>``.
If you would like to help out, ``attend a meeting
<http://eavesdrop.openstack.org/#Documentation_Install_Team_Meeting>``.

Project specific installation guides can be set up as follows:

#. Use the ``installguide-cookiecutter
   <https://git.openstack.org/cgit/openstack/installguide-cookiecutter>``
   to create a skeleton for your project.

   This adds content to the ``install-guide`` directory in the
   top-level of the project repository.

#. Include a ``tox.ini`` environment for 'install-guide':

   .. code::

      [testenv:install-guide]
      # NOTE(jaegerandi): this target does not use constraints because
      # upstream infra does not yet support it. Once that's fixed, we can
      # drop the install_command.
      install_command = pip install -U --force-reinstall {opts} {packages}
      commands = sphinx-build -a -E -W -d install-guide/build/doctrees -b html install-guide/source install-guide/build/html

#. Add the python package ``openstackdocs-theme``  to the
   ``test-requirements.txt`` file.

#. Once the changes above are merged, add jobs for it in the
   ``openstack-infra/project-config`` repository. Define the jobs using
   the JJB ``install-guide-jobs`` job-template in file
   ``jenkins/jobs/projects.yaml`` like:

   .. code-block:: yaml

      ...
      - install-guide-jobs:
         service: orchestration

   Here ``service`` is the service name of the project, like
   orchestration for heat.

#. Add the ``install-guide-jobs`` template to ``zuul/layout.yaml`` to
   schedule the jobs.

TBD: How to create master index file for this.
