==================
Software licensing
==================

The many different forms of license agreements for software are often written
with the use of dedicated hardware in mind.  This model is relevant for the
cloud platform itself, including the hypervisor operating system, supporting
software for items such as database, RPC, backup, and so on.  Consideration
must be made when offering Compute service instances and applications to end
users of the cloud, since the license terms for that software may need some
adjustment to be able to operate economically in the cloud.

Multi-site OpenStack deployments present additional licensing
considerations over and above regular OpenStack clouds, particularly
where site licenses are in use to provide cost efficient access to
software licenses. The licensing for host operating systems, guest
operating systems, OpenStack distributions (if applicable),
software-defined infrastructure including network controllers and
storage systems, and even individual applications need to be evaluated.

Topics to consider include:

* The definition of what constitutes a site in the relevant licenses,
  as the term does not necessarily denote a geographic or otherwise
  physically isolated location.

* Differentiations between "hot" (active) and "cold" (inactive) sites,
  where significant savings may be made in situations where one site is
  a cold standby for disaster recovery purposes only.

* Certain locations might require local vendors to provide support and
  services for each site which may vary with the licensing agreement in
  place.
