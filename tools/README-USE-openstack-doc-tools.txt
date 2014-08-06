With the exception of the autogenerate-config-flagmappings and
www-generator directories, the tools directory has been moved to a
separate repository openstack-doc-tools:

https://github.com/openstack/openstack-doc-tools

Please do not make changes here, commit instead to openstack-doc-tools
unless you need those for gating jobs.

This directory will be removed once all the gating jobs are setup
correctly.

Exception: the directory autogenerate-config-flagmappings contains
data that will stay here.

Exception: the directory www-generator contains data that will stay here.
