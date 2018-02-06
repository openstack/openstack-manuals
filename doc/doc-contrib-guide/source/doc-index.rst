===================================
Landing pages on docs.openstack.org
===================================

The main index pages on docs.openstack.org are part of the
``openstack-manuals`` repository in the ``www`` folder. These are
generated with using a template generator as described in
:doc:`doc-tools/template-generator`.

Official OpenStack projects hosted on the ``docs.openstack.org`` site
should add their links to the main index pages as explained at
:doc:`doc-tools/template-generator`.

For projects with many subprojects, like deployment projects or
plug-in lists of networking or bare metal, the main project page
should be linked and the project should have links to their
subprojects or plug-ins that they maintain themselves.

Note that these projects can add additional entries to the global
redirect list in the file ``www/.htaccess``.
