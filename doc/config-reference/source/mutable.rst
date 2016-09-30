==========================
Changing config at runtime
==========================

OpenStack Newton introduces the ability to reload (or 'mutate') certain
configuration options at runtime without a service restart. The following
projects support this:

* Compute (nova)

Check individual options to discover if they are mutable.


In practice
~~~~~~~~~~~

A common use case is to enable debug logging after a failure. Use the mutable
config option called 'debug' to do this (providing ``log_config_append``
has not been set). An admin user may perform the following steps:

#. Log onto the compute node.
#. Edit the config file (EG ``nova.conf``) and change 'debug' to ``True``.
#. Send a SIGHUP signal to the nova process (For example, ``pkill -HUP nova``).

A log message will be written out confirming that the option has been changed.
If you use a CMS like Ansible, Chef, or Puppet, we recommend scripting these
steps through your CMS.
