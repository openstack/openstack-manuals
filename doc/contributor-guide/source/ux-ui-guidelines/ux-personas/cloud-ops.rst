.. _cloud-ops:

======================
Rey - cloud operations
======================

Rey is involved in installing, operating, using, and updating the OpenStack
cloud services. Rey ensures that the cloud is up and running and must fix any
issues as soon as possible. Collaborating with unskilled IT personnel is very
challenging for Rey.

Key tasks
~~~~~~~~~

Rey performs the following tasks very frequently:

* Installation: Installs and configures OpenStack clouds often with the help
  of the Infrastructure Architect.

* Operation: Tracks day-to-day operation and administration of the cloud
  including backup, disaster recovery, and platform services.

* Usage tracking: Tracks the use that App Developers, Project Owners, and
  Domain operators make of the cloud and optimizes the services accordingly.

* Update: Performs updates and verification of the OpenStack cloud.

Key information
~~~~~~~~~~~~~~~

Rey spends some time every day searching for information on the OpenStack
website and has attended the OpenStack Summit once. Rey uses any useful tool
in operating the cloud. Rey's previous role as a Linux system administrator
influenced the decision to use OpenStack.

The organizational models
~~~~~~~~~~~~~~~~~~~~~~~~~

The tasks that the persona performs within a certain organizational model are
important for the usability of your OpenStack development. Within a small
company, Rey might be required to assume some of the responsibilities of
both the Infrastructure Architect and the Domain Operator. Within a larger
company, multiple individuals could perform subsets of Rey's tasks. For
example, one person could be in charge of installing and updating the cloud
instances, while another could be in charge of monitoring operations and
usage, and yet another person could be in charge of solving issues. In
Rey's organization, Rey is responsible for all of these tasks.

Your development
~~~~~~~~~~~~~~~~

When your development affects the behavior of the cloud instances, you should
consider Rey as your target audience. Will your development change how the
cloud is accessed, configured, monitored, or setup? Is your development
changing the GUI, for example, the horizon dashboard? Rey is unlikely to
use :abbr:`CLI (Command-Line Interface)` to administer and track the cloud
instances but is likely to use CLI to install and update them.

Before submitting your code, think of the use cases that Rey would follow.
For example: Is it easy to use? Will Ray get feedback when the task is
complete? Are the changes in configuration reversible? How is the tracked
information displayed? How long will the operation take?

Finally, consider that Rey is a highly skilled system administrator with a
deep knowledge of OpenStack but with little time for long, complex research.
Therefore, your solutions for Rey must be quick to implement but do not
need to shy away from complex OpenStack components, as long as they provide
all the information needed within the solution itself.
