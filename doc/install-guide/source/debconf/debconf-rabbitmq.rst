:orphan:

===============================
RabbitMQ credentials parameters
===============================

For every package that must connect to a Messaging Server, the Debian
package enables you to configure the IP address for that server and the
user name and password that is used to connect. The following example
shows configuration with the ``ceilometer-common`` package:

.. image:: ../figures/debconf-screenshots/rabbitmq-host.png

|

.. image:: ../figures/debconf-screenshots/rabbitmq-user.png

|

.. image:: ../figures/debconf-screenshots/rabbitmq-password.png

|

These debconf screens appear in: ``ceilometer-common``, ``cinder-common``,
``glance-common``, ``heat-common``, ``neutron-common``, and ``nova-common``.

This will configure the below directives (example from ``nova.conf``):

.. code-block:: ini

   [DEFAULT]
   rabbit_host=localhost
   rabbit_userid=guest
   rabbit_password=guest

The other directives concerning RabbitMQ will stay untouched.
