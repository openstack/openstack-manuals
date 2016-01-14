.. _build_locally:

Building output locally
~~~~~~~~~~~~~~~~~~~~~~~

The openstack-manuals project uses a `tox.ini`_ file with specific sections
that run jobs using the `Tox`_ tool, a virtualenv-based automation of test
activities.

Tox prerequisites and installation
----------------------------------

**Install the prerequisites for Tox:**

* On Ubuntu or Debian:

  .. code-block:: console

     # apt-get install gcc gettext python-dev libxml2-dev libxslt1-dev \
       zlib1g-dev

  You may need to use :command:`pip install` for some packages.

* On RHEL or CentOS including Fedora:

  .. code-block:: console

     # yum install gcc python-devel libxml2-devel libxslt-devel

* On openSUSE or SUSE Linux Enterprise:

  .. code-block:: console

     # zypper install gcc python-devel libxml2-devel libxslt-devel

**Install python-tox:**

.. code-block:: console

   # pip install tox

Build workflow
--------------

Once Tox is installed and configured, execute :command:`tox -e <jobname>` to
run a particular job:

* To build all docs (DocBook and RST), open your local openstack-manuals
  project and run:

  .. code-block:: console

     tox -e checkbuild

* To build RST docs, run:

  .. code-block:: console

     tox -e docs

* To build a specific guide, add the guide folder name to the
  :command:`tox -e build` command. For example:

  .. code-block:: console

     tox -e build -- contributor-guide


  .. note:: This command does not work for the install-guide, as it
      contains conditional content. To build specific parts of the
      Installation guide, use the commands below:

      .. code-block:: console

         tox -e install-guide-obs
         tox -e install-guide-ubuntu
         tox -e install-guide-debian
         tox -e install-guide-rdo

This runs the :command:`sphinx-build` command. When the build is finished,
it will be displayed in the ``openstack-manuals/publish-docs`` directory.
You can open the ``.html`` file in a browser to view the resulting output.

If you do not want to use Tox, install the below prerequisites locally:

.. code-block:: console

   # pip install sphinx
   # pip install openstackdocstheme

To get the ``.html`` output locally, switch to the directory containing a
``conf.py`` and run:

.. code-block:: console

   sphinx-build /path/to/source/ path/to/build/

The RST source is built into HTML using Sphinx, so that it is displayed on
the *docs.openstack.org/<guide-name>*, for example,
http://docs.openstack.org/user-guide-admin.

The DocBook source is built into HTML (webhelp) and PDF using XSLT transforms
included to the DocBook project.

You can find tips how to troubleshoot the build at:
`Documentation/Troubleshooting`_.

**Build DocBook locally without a Python environment**

`Maven`_ plug-in must be installed to build the documentation. Run one of the
below commands to install Maven:

* On Ubuntu or Debian:

  .. code-block:: console

     apt-get install maven

* On Fedora:

  .. code-block:: console

     yum install maven

* On openSUSE:

  .. code-block:: console

     zypper install maven

To build a specific DocBook guide, look for a ``pom.xml`` file within a
subdirectory, switch to that directory, then run the :command:`mvn` command
using Maven plug-in in that directory. For example:

.. code-block:: console

   cd openstack-manuals/doc/glossary
   mvn clean generate-sources

Find the generated documentation in the
``openstack-manuals/doc/<guide-name>/target`` directory of the guide that you
build. For example:

* PDF: ``openstack-manuals/doc/glossary/target/docbkx/webhelp/
  glossary/glossary.pdf``
* HTML: ``openstack-manuals/doc/glossary/target/docbkx/webhelp/
  glossary/content/index.html``.

Using Tox to check builds
-------------------------

As a part of the review process, Jenkins runs gating scripts to check that
the patch is fine. Locally, you can use the Tox tool to ensure that a patch
works. To check all books, run the following command from the base directory
of repository:

.. code-block:: console

    tox

The following individual checks are also availableː

* :command:`tox -e checkniceness` - to run the niceness tests (for example,
  to see extra whitespaces)
* :command:`tox -e checksyntax` - to run syntax checks
* :command:`tox -e checkdeletions` - to check that no deleted files are
  referenced
* :command:`tox -e checklinks` - to check whether all the links work
* :command:`tox -e checklang` - to check all the translated manuals
* :command:`tox -e docs` - to build only RST-sourced manuals
* :command:`tox -e checkbuild` - to build all the manuals. This will also
  generate a directory ``publish-docs`` that contains the built files for
  inspection.

.. note::

   * The scripts are not written for Windows, but we encourage
     cross-platform work on our scripts.
   * If Tox stops working, try :command:`tox --recreate` to rebuild the
     environment.

.. _`Nova developer site`: http://docs.openstack.org/developer/nova/
.. _`Glance developer site`: http://docs.openstack.org/developer/glance/
.. _`Documentation/Troubleshooting`: https://wiki.openstack.org/wiki/Documentation/Troubleshooting
.. _`tox.ini`: http://git.openstack.org/cgit/openstack/openstack-manuals/tree/tox.ini
.. _`Tox`: https://tox.readthedocs.org/en/latest/
.. _`Maven`: http://maven.apache.org/
