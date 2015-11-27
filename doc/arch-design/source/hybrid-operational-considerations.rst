==========================
Operational considerations
==========================

Hybrid cloud deployments present complex operational challenges.
Differences between provider clouds can cause incompatibilities
with workloads or Cloud Management Platforms (CMP).
Cloud providers may also offer different levels of integration
with competing cloud offerings.

Monitoring is critical to maintaining a hybrid cloud, and it is
important to determine if a CMP supports monitoring of all the
clouds involved, or if compatible APIs are available to be queried
for necessary information.

Agility
~~~~~~~

Hybrid clouds provide application availability across different
cloud environments and technologies.
This availability enables the deployment to survive disaster
in any single cloud environment.
Each cloud should provide the means to create instances quickly in
response to capacity issues or failure elsewhere in the hybrid cloud.

Application readiness
~~~~~~~~~~~~~~~~~~~~~

Enterprise workloads that depend on the underlying infrastructure
for availability are not designed to run on OpenStack.
If the application cannot tolerate infrastructure failures,
it is likely to require significant operator intervention to recover.
Applications for hybrid clouds must be fault tolerant, with an SLA
that is not tied to the underlying infrastructure.
Ideally, cloud applications should be able to recover when entire
racks and data centers experience an outage.

Upgrades
~~~~~~~~

If a deployment includes a public cloud, predicting upgrades may
not be possible. Carefully examine provider SLAs.

.. note::

   At massive scale, even when dealing with a cloud that offers
   an SLA with a high percentage of uptime, workloads must be able
   to recover quickly.

When upgrading private cloud deployments, minimize disruption by
making incremental changes and providing a facility to either rollback
or continue to roll forward when using a continuous delivery model.

You may need to coordinate CMP upgrades with hybrid cloud upgrades
if there are API changes.

Network Operation Center
~~~~~~~~~~~~~~~~~~~~~~~~

Consider infrastructure control when planning the Network Operation
Center (NOC) for a hybrid cloud environment.
If a significant portion of the cloud is on externally managed systems,
prepare for situations where it may not be possible to make changes.
Additionally, providers may differ on how infrastructure must be
managed and exposed.  This can lead to delays in root cause analysis
where each insists the blame lies with the other provider.

Ensure that the network structure connects all clouds to form
integrated system, keeping in mind the state of handoffs.
These handoffs must both be as reliable as possible and
include as little latency as possible to ensure the best
performance of the overall system.

Maintainability
~~~~~~~~~~~~~~~

Hybrid clouds rely on third party systems and processes.
As a result, it is not possible to guarantee proper maintenance
of the overall system. Instead, be prepared to abandon workloads
and recreate them in an improved state.
