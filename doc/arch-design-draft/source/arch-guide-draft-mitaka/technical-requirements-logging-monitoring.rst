======================
Logging and monitoring
======================

OpenStack clouds require appropriate monitoring platforms to catch and
manage errors.

.. note::

   We recommend leveraging existing monitoring systems to see if they
   are able to effectively monitor an OpenStack environment.

Specific meters that are critically important to capture include:

* Image disk utilization

* Response time to the Compute API

Logging and monitoring does not significantly differ for a multi-site OpenStack
cloud. The tools described in the `Logging and monitoring chapter
<http://docs.openstack.org/ops-guide/ops-logging-monitoring.html>`__ of
the Operations Guide remain applicable. Logging and monitoring can be provided
on a per-site basis, and in a common centralized location.

When attempting to deploy logging and monitoring facilities to a centralized
location, care must be taken with the load placed on the inter-site networking
links.
