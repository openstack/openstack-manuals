.. _new_projects:

============
New projects
============

If you are maintaining a new project that has recently been accepted into the
OpenStack 'big tent' then you will require some documentation for your
project.

Documentation for your project should live in your project's
git repository, and be published to `docs.openstack.org/yourproject`.
If you need to create that index page, you will also need to add the
``openstack-unified-publish-jobs`` to the appropriate repositories by
updating the settings in the ``project-config`` repository so that the
documentation is re-published with every commit.

Any configuration options or command line tools should be documented using
the automated ``openstack-doc-tools``. For more information about these
automated tools, see the :ref:`doc-tools` chapter.

To create an Installation Tutorial in accordance with the OpenStack
Foundation Project Navigator, follow the instructions at
:ref:`project-install-guide`.
