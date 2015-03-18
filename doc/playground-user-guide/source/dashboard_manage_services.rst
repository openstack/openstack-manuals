=========================
View services information
=========================

As an administrative user, you can view information for OpenStack services.

#. Log in to the OpenStack dashboard and choose the
   :guilabel:`admin` project from the drop-down list
   at the top of the page.

#. On the :guilabel:`Admin` tab, click the :guilabel:`System Info` category.

   View the following information on these tabs:

   * :guilabel:`Services`:
     Displays the internal name and the public OpenStack name
     for each service, the host on which the service runs,
     and whether or not the service is enabled.

   * :guilabel:`Compute Services`:
     Displays information specific to the Compute Service. Both host
     and zone are listed for each service, as well as its
     activation status.

   * :guilabel:`Network Agents`:
     Displays the network agents active within the cluster, such as L3 and
     DHCP agents, and the status of each agent.

   * :guilabel:`Default Quotas`:
     Displays the quotas that have been configured for the cluster.

   * :guilabel:`Availability Zones`: Displays the availability zones that have been configured
     for the cluster. It is only available when multiple availability zones have been defined.

   * :guilabel:`Host Aggregates`: Displays the host aggregates that have been
     defined for the cluster. It is only available when multiple host aggregates
     have been defined.
