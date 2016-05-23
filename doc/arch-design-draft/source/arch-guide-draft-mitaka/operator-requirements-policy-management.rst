=================
Policy management
=================

OpenStack provides a default set of Role Based Access Control (RBAC)
policies, defined in a ``policy.json`` file, for each service. Operators
edit these files to customize the policies for their OpenStack
installation. If the application of consistent RBAC policies across
sites is a requirement, then it is necessary to ensure proper
synchronization of the ``policy.json`` files to all installations.

This must be done using system administration tools such as rsync as
functionality for synchronizing policies across regions is not currently
provided within OpenStack.
