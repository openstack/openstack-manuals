===================
Networking concepts
===================

Cloud fundementally changes the ways that networking is provided and consumed.
Understanding the following concepts and decisions is imperative when making
architectural decisions.

Network zones
~~~~~~~~~~~~~

The cloud networks are divided into a number of logical zones that support the
network traffic flow requirements. We recommend defining at the least four
distinct network zones.

Underlay
--------

The underlay zone is defined as the physical network switching infrastructure
that connects the storage, compute and control platforms. There are a large
number of potential underlay options available.

Overlay
-------

The overlay zone is defined as any L3 connectivity between the cloud components
and could take the form of SDN solutions such as the neutron overlay solution
or 3rd Party SDN solutions.

Edge
----

The edge zone is where network traffic transitions from the cloud overlay or
SDN networks into the traditional network environments.

External
--------

The external network is defined as the configuration and components that are
required to provide access to cloud resources and workloads, the external
network is defined as all the components outside of the cloud edge gateways.


Traffic Flow
~~~~~~~~~~~~

There are two primary types of traffic flow within a cloud infrastructure, the
choice of networking technologies is influenced by the expected loads.

East/West - The internal traffic flow between workload within the cloud as well
as the traffic flow between the compute nodes and storage nodes falls into the
East/West category. Generally this is the heaviest traffic flow and due to the
need to cater for storage access needs to cater for a minimum of hops and low
latency.

North/South - The flow of traffic between the workload and all external
networks, including clients and remote services. This traffic flow is highly
dependant on the workload within the cloud and the type of network services
being offered.
