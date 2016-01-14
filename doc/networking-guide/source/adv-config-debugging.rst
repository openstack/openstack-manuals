=========
Debugging
=========

The OpenStack Networking service offers many degrees of freedom because
of the pluggable back end that supports a variety of open source and
vendor (proprietary) plug-ins. The open source plug-ins generally implement
native Linux facilities such as Open vSwitch (OVS) and Linux bridge. This
section provides methods to troubleshoot and mitigate network issues for
environments using the open source ML2 plug-in with the OVS or Linux bridge
agent.

Neutron-debug command line tools
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Network troubleshooting can unfortunately be a very difficult and
confusing procedure. A network issue can cause a problem at several
points in the cloud. Using a logical troubleshooting procedure can
help mitigate the confusion and quickly isolate the network issue.

Some of the following sections reference these popular tools to understand
both network configuration and traffic patterns:

#. iproute2
#. tcpdump
#. iptables

Neutron-debug command line tools
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Subsection ...

Network configuration in the database
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Subsection ...

Debugging DHCP Issues
~~~~~~~~~~~~~~~~~~~~~

Subsection ...

Debugging DNS Issues
~~~~~~~~~~~~~~~~~~~~

Subsection ...

Network namespaces configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Subsection ...

Summary
~~~~~~~

Subsection ...
