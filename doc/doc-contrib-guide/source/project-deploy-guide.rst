=================
Deployment guides
=================

As of the Newton release, a new method of publishing deployment guides has
been implemented. This allows each deployment projects to create their own
deployment guide, based on a standard template, in their own repository.
These guides are then centrally published to
`Deployment Guides <https://docs.openstack.org/newton/deploy/newton/>`_.

.. note::

   This set up is designed for deployment projects to make their
   installation information public. This does not include further
   content for end users. For example, configuration content,
   troubleshooting, or administration procedures.

   If you would like to refer users to more content, use
   cross reference links to your developer documentation
   within the guide.

Setting up
~~~~~~~~~~

#. Install ``cookiecutter``:

   .. code-block:: console

      # pip install cookiecutter

#. Run the Install Guide cookiecutter to create a skeleton for your project:

   .. important::

      The Install Guide cookiecutter is also used for the deployment guides.
      However, the rest of these instructions are specific to the deployment
      guide creation.

   .. code-block:: console

      $ cookiecutter https://git.openstack.org/openstack/installguide-cookiecutter.git

   You will be prompted to answer questions to complete the installation.
   Content is then added to the ``deploy-guide`` directory in the
   top-level of the project repository.

#. Create a ``tox.ini`` environment for the ``deploy-guide`` in your project
   repository, using this content:

   .. code-block:: ini

      [testenv:deploy-guide]
      commands = sphinx-build -a -E -W -d deploy-guide/build/doctrees -b html deploy-guide/source deploy-guide/build/html


#. Add your deployment guide content, and test the build locally with ``tox``:

   .. code-block:: console

      $ tox -e deploy-guide

   The local build is in ``deploy-guide/build/html``.

#. Add the Python package ``openstackdocstheme``  to the
   ``test-requirements.txt`` file. Copy the exact requirement line from the
   `global file
   <https://git.openstack.org/cgit/openstack/requirements/tree/global-requirements.txt>`_:

   .. code-block:: none

      openstackdocstheme>=1.5.0  # Apache-2.0

#. Commit the changes to your project repository for review.

To create or update the master index file, create or update the
``www/project-deploy-guide/RELEASE/index.html`` file at the
``openstack-manuals`` repository.

For draft (unreleased) version, replace ``RELEASE`` with ``draft``.

After these changes merge, you can set up the jobs for building in the
OpenStack Infra ``project-config`` repository:

#. Clone the project-config repo:

   .. code-block:: console

      $ git clone https://git.openstack.org/openstack-infra/project-config

#. In ``jenkins/jobs/projects.yaml``, add ``deploy-guide-jobs`` within the
   entry for your project:

   .. code-block:: yaml

      - project:
        name: <project-name>

        jobs:
        ...
         - deploy-guide-jobs:
             service: <service-name>

   ``project-name`` and ``service-name`` are the project name, and the
   specific serivce name. One example is orchestration for heat.

   This defines the jobs using the JJB ``deploy-guide-jobs`` job-template.

#. In ``zuul/layout.yaml``, locate the entry for your project and add the
   ``deploy-guide-jobs`` template:

   .. code-block:: yaml

      - name: openstack/<project-name>
        template:
          - name: deploy-guide-jobs

   This schedules the Deploy Guide jobs.

#. Commit the changes to the infra repository for review.

Deployment guide and installation guide links
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you have links between your deployment guide or installation guide and your
normal documents, you need to take extra care that the links work. Any links to
your old installation guide will now point to nothing.

We recommend adding conditional branch names for documentation links within
your repo. Documents generated this way will always point to the live URLs,
not to HTML, generated for a gate job.

The link generation is done via the ``sphinx.ext.extlinks``
extension, allowing for defining custom link generation roles. This
achieves the desired behavior in terms of dynamic link construction, but
does alter the standard linking conventions.

Usage for the deploy guide is as follows:

.. code-block:: rst

   :deploy_guide:`Link title text <last-part-of-url.html>`

For an example, and more information, please review the following
OpenStack-Ansible patch: https://review.openstack.org/#/c/417976/
