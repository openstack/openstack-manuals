.. _new_projects:

============
New projects
============

If you are maintaining a new project that has recently been accepted into the
OpenStack 'big tent' then you will require some documentation for your
project.

Developer documentation for your project should live in your project's git
repository, and be published to `docs.openstack.org/developer/yourproject`.
If you need to create that index page, send a patch to the openstack-manuals
team. You will also need to add the ``openstack-server-publish`` job to the
appropriate repositories so that the index page is re-published with every
commit.

Any configuration options or command line tools should be documented using
the automated ``openstack-doc-tools``. For more information about these
automated tools, see the :ref:`doc-tools` chapter.

To create an Installation Tutorial in accordance with the OpenStack
Foundation Project Navigator, follow the instructions at
``project-install-guide``.
