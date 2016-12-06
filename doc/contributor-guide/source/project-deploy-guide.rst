=================
Deployment guides
=================

As of the the Newton release, a new method of publishing deployment guides has
been implemented. This allows each deployment projects to create their own
deployment guide, based on a standard template, in their own repository.
These guides are then centrally published to
`Deployment Guides <http://docs.openstack.org/project-deploy-guide/newton/>`_.

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
   <http://git.openstack.org/cgit/openstack/requirements/tree/global-requirements.txt>`_:

   .. code-block:: none

      openstackdocstheme>=1.5.0  # Apache-2.0

#. Commit the changes to your project repository for review.

To create or update the master index file, create or update the
``www/project-deploy-guide/RELEASE/index.html`` file at the
``openstack-manuals`` repository.

For draft (unreleased) version, replace ``RELEASE`` with ``draft``.
