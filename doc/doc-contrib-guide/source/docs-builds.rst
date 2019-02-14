.. _docs_builds:

======================
Building documentation
======================

Clone a repository first
~~~~~~~~~~~~~~~~~~~~~~~~

Before building documentation, you must first clone the repository where the
files reside.

For the instructions on how to clone a repository so that you can work
on it locally, refer to the `Starting Work on a New Project
<https://docs.openstack.org/infra/manual/developers.html#starting-work-on-a-new-project>`_
of the Infrastructure manual.

See :ref:`troubleshoot_setup` if you have difficulty with a repository
setup.

Refer to :doc:`Writing documentation <writing-docs>` for details on how to
create content and contribute to the documentation.

Building output locally
~~~~~~~~~~~~~~~~~~~~~~~

Although you can use Linux, MacOS, or Windows to build locally the Sphinx
documentation for OpenStack, Linux is the preferred build environment as it
offers the most complete support for documentation building.

OpenStack project and documentation repositories use a ``tox.ini`` file with
specific sections that run jobs using the `Tox
<https://tox.readthedocs.org/en/latest/>`_ tool, a virtualenv-based
automation of test activities.

.. _docs_dependencies:

Install dependencies for building documentation
-----------------------------------------------

OpenStack maintains a tool called ``bindep`` that maintains a list of
dependencies for Linux package managers. When you run the
:command:`tox -e bindep` command, read the error messages and install the
dependencies based on the error messages returned. Continue to run until
your local environment meets the requirements as listed in ``bindep.txt``
in the repository.

.. important::

   Ensure you run ``bindep`` in each individual project repository that you
   clone if you want to build the documentation.

   For more information on ``bindep`` and packages, see `Package Requirements
   <https://docs.openstack.org/infra/manual/drivers.html#package-requirements>`_.

* On Ubuntu or Debian:

  .. code-block:: console

     # apt-get install python-pip
     # pip install tox
     $ tox -e bindep
     # apt-get install <indicated missing package names>

* On RHEL or CentOS (replace :command:`yum` with :command:`dnf` on Fedora):

  .. code-block:: console

     # yum install python-pip
     # pip install tox
     $ tox -e bindep
     # yum install <indicated missing package names>

* On openSUSE or SUSE Linux Enterprise:

  .. code-block:: console

     # zypper in python-pip
     # pip install tox
     $ tox -e bindep
     # zypper in <indicated missing package names>

.. note::

   Running these commands will install all required packages for building both
   RST and PDF files. If you do not build PDF files, you do not need to
   install the `texlive <https://www.tug.org/texlive/>`__ packages and
   `Liberation font family <https://fedorahosted.org/liberation-fonts/>`__.

* On MacOS

  Open a Terminal window. Make sure you have Python installed. Many contributors
  use the `Homebrew tool instructions
  <http://docs.python-guide.org/en/latest/starting/install/osx/>`_.

  .. code-block:: console

     $ brew install python
     $ pip install tox

  .. note::

     You cannot run :command:`tox -e bindep` on Mac OS X as it uses a Linux tool
     to parse the information. `Issue logged here
     <https://storyboard.openstack.org/#!/story/2000888>`_.

* On Windows

  To the doc build scripts as-is on Windows, first install `Git for Windows`_.
  Make sure you have a working Python environment, and then use Git Bash to run
  all :command:`tox` commands within the repository directory:

  .. code-block:: console

     $ pip install tox

.. _Git for Windows: http://gitforwindows.org/

.. _docs_builds_manuals:

Build workflow for openstack-manuals
------------------------------------

Once Tox is installed and configured, execute :command:`tox -e <jobname>`
to run a particular job. For example, to build all guides in
openstack-manuals, run the following command:

.. code-block:: console

   $ tox -e docs

The individual Tox jobs you can run are explained in detail in the
`README file
<https://git.openstack.org/cgit/openstack/openstack-manuals/tree/README.rst>`_
in the repository.

As a part of the review process, the OpenStack CI system runs scripts
to check that the patch is fine. Locally, you can use the Tox tool to
ensure that a patch works. To check all guides, run the :command:`tox` command
from the base directory of repository.

.. _docs_builds_other_repositories:

Build workflow for other repositories with documentation
--------------------------------------------------------

Once Tox is installed and configured, execute the following command to run the
``docs`` job:

.. code-block:: console

   $ tox -e docs

When the build is finished, it outputs the built documentation to the
``doc/build`` directory. You can open the built ``.html`` files in a browser
to review them.

.. _docs_builds_locally:

Build an existing patch locally
-------------------------------

To build a patch locally:

#. In your clone of the appropriate repository, create a local branch that
   contains the particular patch.

   .. code-block:: console

      $ git review -d PATCH_ID

   Where the value of ``PATCH_ID`` is a Gerrit commit number.
   You can find this number on the patch link,
   ``https://review.openstack.org/#/c/PATCH_ID``.

#. Build the documentation affected by changes in the patch set. For more
   information, see :ref:`docs_builds_manuals` and
   :ref:`docs_builds_other_repositories`.

.. _build_jobs:

Build jobs
~~~~~~~~~~

The build jobs for documentation are stored in the
`Project config <https://git.openstack.org/cgit/openstack-infra/project-config>`_
repository. The build jobs build to the docs.openstack.org and
developer.openstack.org sites, copying built files via FTP.

The release-specific guides are built for the currently supported branches
(current and previous releases), development happens on the master branch.
The continuously released guides are only built on the master branch.

Like other projects, the documentation projects use a number of jobs
that do automatic testing of patches.

For openstack-manuals, the current jobs are:

* openstack-tox-linters
* build-tox-manual-checkbuild
* build-tox-manual-checklang

Checklang job
-------------

We only gate on manual/language combinations that are translated
sufficiently.

* If an import from Zanata fails, we do not approve the import.
* If any other patch fails, the failure might get ignored.
* In any case of failure, a bug gets reported against the `i18n project
  <https://bugs.launchpad.net/openstack-i18n>`_.

If you want to manually run this check in your clone of openstack-manuals, use
the checklang environment (:command:`tox -e checklang`).

.. _docs_builds_eol:

Building docs from end-of-life releases
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack projects can follow different `release models
<https://releases.openstack.org/reference/release_models.html>`_. The
openstack-manuals repo follows two of these models, independent and
cycle-with-milestones.

.. note::

   The docs repo and the api-site follow the independent release model.

To build documentation from a particular release locally, follow these steps.

#. In your clone of the appropriate repository, view the remote tags to see
   the tags for each release:

   .. code-block:: console

      $ git tag -l
      2012.1
      2012.2
      2013.1.rc1
      2013.1.rc2
      2013.2
      diablo-eol
      essex-eol
      folsom-eol
      grizzly-eol
      havana-eol
      icehouse-eol
      juno-eol
      kilo-eol
      liberty-eol

#. Look for the release name you want to build, such as Essex, and check out
   the corresponding tag:

   .. code-block:: console

      $ git checkout essex-eol

   Git checks out the files and when complete, shows you the reference point
   for your local files, such as, ``HEAD is now at e6b9f61... fix
   delay_auth_decision parameter``.

#. Read the :file:`README.rst` file available at that point in time for the
   prerequisites for building the documentation locally. For example, you may
   need to install Apache Maven in order to build old documents.
