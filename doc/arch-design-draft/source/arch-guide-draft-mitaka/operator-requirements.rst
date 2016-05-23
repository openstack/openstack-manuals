=====================
Operator requirements
=====================

.. toctree::
   :maxdepth: 2

   operator-requirements-sla.rst
   operator-requirements-support-maintenance.rst
   operator-requirements-ops-access.rst
   operator-requirements-quota-management.rst
   operator-requirements-policy-management.rst
   operator-requirements-external-idp.rst
   operator-requirements-upgrades.rst
   operator-requirements-bleeding-edge.rst
   operator-requirements-skills-training.rst

Several operational factors affect the design choices for a general
purpose cloud. Operations staff receive tasks regarding the maintenance
of cloud environments, including:

Maintenance tasks
    Operating system patching, hardware/firmware upgrades, and datacenter
    related changes, as well as minor and release upgrades to OpenStack
    components are all ongoing operational tasks. In particular, the six
    monthly release cycle of the OpenStack projects needs to be considered as
    part of the cost of ongoing maintenance. The solution should take into
    account storage and network maintenance and the impact on underlying
    workloads.

Reliability and availability
    Reliability and availability depend on the many supporting components'
    availability and on the level of precautions taken by the service provider.
    This includes network, storage systems, datacenter, and operating systems.

In order to run efficiently, automate as many of the operational processes as
possible. Automation includes the configuration of provisioning, monitoring and
alerting systems. Part of the automation process includes the capability to
determine when human intervention is required and who should act. The
objective is to increase the ratio of operational staff to running systems as
much as possible in order to reduce maintenance costs. In a massively scaled
environment, it is very difficult for staff to give each system individual
care.

Configuration management tools such as Ansible, Puppet, and Chef enable
operations staff to categorize systems into groups based on their roles and
thus create configurations and system states that the provisioning system
enforces. Systems that fall out of the defined state due to errors or failures
are quickly removed from the pool of active nodes and replaced.

At large scale, the resource cost of diagnosing failed individual systems is
far greater than the cost of replacement. It is more economical to replace the
failed system with a new system, provisioning and configuring it automatically
and adding it to the pool of active nodes. By automating tasks that are
labor-intensive, repetitive, and critical to operations, cloud operations
teams can work more efficiently because fewer resources are required for these
common tasks. Administrators are then free to tackle tasks that are not easy
to automate and that have longer-term impact on the business, for example,
capacity planning.
