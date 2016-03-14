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
team. You will also need to add the `openstack-server-publish` job to the
appropriate repositories so that the index page is re-published with every
commit.

Any configuration options or command line tools should be documented using
the automated `openstack-doc-tools`. For more information about these
automated tools, see the :ref:`doc-tools` chapter.

To create your Installation documentation in accordance with the OpenStack
Foundation Project Navigator, begin by drafting and polishing it in your
developer documentation repository. This is considered 'official' Installation
documentation for the purposes of the Navigator. Once you have a good amount
of quality content, open a conversation with the openstack-manuals team about
inclusion in the top level documentation directory. The docs team will then be
able to work with you to determine your specific documentation needs, and the
best way to include your project in openstack-manuals.
