=================================
OpenStack High Availability Guide
=================================

Abstract
~~~~~~~~

This guide describes how to install and configure OpenStack for high
availability. It supplements the Installation Tutorials and Guides
and assumes that you are familiar with the material in those guides.

.. important::

   This guide was last updated as of the Ocata release, documenting
   the OpenStack Ocata, Newton, and Mitaka releases. It may
   not apply to EOL releases Kilo and Liberty.

   We advise that you read this at your own discretion when planning
   on your OpenStack cloud.

   This guide is intended as advice only.

   The OpenStack HA team is based on voluntary contributions from
   the OpenStack community. You can contact the HA community
   directly in the #openstack-ha channel on Freenode IRC, or by
   sending mail to the openstack-dev or openstack-doc mailing list
   with the [HA] prefix in the subject header.

   The OpenStack HA community holds `weekly IRC meetings
   <https://wiki.openstack.org/wiki/Meetings/HATeamMeeting>`_ to discuss
   a range of topics relating to HA in OpenStack. Everyone interested is
   encouraged to attend. The `logs of all previous meetings
   <http://eavesdrop.openstack.org/meetings/ha/>`_ are available to read.

Contents
~~~~~~~~

.. toctree::
   :maxdepth: 2

   common/conventions.rst
   intro-ha.rst
   environment.rst
   shared-services.rst
   controller-ha.rst
   networking-ha.rst
   storage-ha.rst
   compute-node-ha.rst
   appendix.rst
