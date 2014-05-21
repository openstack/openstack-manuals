Roadmap for Install Guides
--------------------------

This file is stored with the source to offer ideas for what to work on.
Put your name next to a task if you want to work on it and put a WIP
review up on review.openstack.org.

May 20, 2014

This guide has an overall blueprint with spec at:
https://wiki.openstack.org/wiki/Documentation/InstallationGuideImprovements

To do tasks:
- Remove openstack-config (crudini) commands; standardize manual install
- Unify chapter and section names (such as Overview)
- Add sample output of each command and highlight important parts
- Mention project as standard but tenant must be used for CLI params
- Refer to generic SQL database and update for MariaDB (RHEL), MySQL, and
PostgreSQL
- Provide sample configuration files for each node
- Compute and network nodes should reference server on controller node
- Update password list
- Add audience information; who is this book intended for

Ongoing tasks:
- Ensure it meets conventions and standards
- Continually update with latest release information relevant to install

Wishlist tasks:
- Replace all individual client commands (like keystone, nova) with openstack client commands
