Firewall-as-a-Service (FWaaS) overview
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Firewall-as-a-Service (FWaaS) plug-in adds perimeter firewall management to
the OpenStack Networking service. FWaaS uses iptables to apply firewall policy
to all neutron routers within a project. FWaaS supports one firewall policy and
logical firewall instance per project.

Whereas security groups operate at the instance-level, FWaaS operates at
the perimeter to filter traffic at the neutron router.

The example diagram illustrates the flow of ingress and egress traffic
for the VM2 instance:

.. figure:: figures/fwaas.png

FWaaS version selection
------------------------

Consult this feature matrix to compare features for FWaaS v1 and v2.

| Feature                            | v1  | v2  |
| ---------------------------------- | --- | --- |
| Supports L3 firewalling (routers)  | YES | YES |
| Supports L2 firewalling (VM ports) | NO  | NO  |
| CLI support                        | YES | NO  |
| Horizon support                    | YES | NO  |

