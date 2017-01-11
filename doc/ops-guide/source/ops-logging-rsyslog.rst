=======
rsyslog
=======

A number of operating systems use rsyslog as the default logging service.
Since it is natively able to send logs to a remote location, you do not
have to install anything extra to enable this feature, just modify the
configuration file. In doing this, consider running your logging over a
management network or using an encrypted VPN to avoid interception.

rsyslog client configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To begin, configure all OpenStack components to log to the syslog log
file in addition to their standard log file location. Also, configure each
component to log to a different syslog facility. This makes it easier to
split the logs into individual components on the central server:

``nova.conf``:

.. code-block:: ini

   use_syslog=True
   syslog_log_facility=LOG_LOCAL0

``glance-api.conf`` and ``glance-registry.conf``:

.. code-block:: ini

   use_syslog=True
   syslog_log_facility=LOG_LOCAL1

``cinder.conf``:

.. code-block:: ini

   use_syslog=True
   syslog_log_facility=LOG_LOCAL2

``keystone.conf``:

.. code-block:: ini

   use_syslog=True
   syslog_log_facility=LOG_LOCAL3

By default, Object Storage logs to syslog.

Next, create ``/etc/rsyslog.d/client.conf`` with the following line:

.. code-block:: none

   *.* @192.168.1.10

This instructs rsyslog to send all logs to the IP listed. In this
example, the IP points to the cloud controller.

rsyslog server configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Designate a server as the central logging server. The best practice is
to choose a server that is solely dedicated to this purpose. Create a
file called ``/etc/rsyslog.d/server.conf`` with the following contents:

.. code-block:: none

   # Enable UDP
   $ModLoad imudp
   # Listen on 192.168.1.10 only
   $UDPServerAddress 192.168.1.10
   # Port 514
   $UDPServerRun 514

   # Create logging templates for nova
   $template NovaFile,"/var/log/rsyslog/%HOSTNAME%/nova.log"
   $template NovaAll,"/var/log/rsyslog/nova.log"

   # Log everything else to syslog.log
   $template DynFile,"/var/log/rsyslog/%HOSTNAME%/syslog.log"
   *.* ?DynFile

   # Log various openstack components to their own individual file
   local0.* ?NovaFile
   local0.* ?NovaAll
   & ~

This example configuration handles the nova service only. It first
configures rsyslog to act as a server that runs on port 514. Next, it
creates a series of logging templates. Logging templates control where
received logs are stored. Using the last example, a nova log from
c01.example.com goes to the following locations:

-  ``/var/log/rsyslog/c01.example.com/nova.log``

-  ``/var/log/rsyslog/nova.log``

This is useful, as logs from c02.example.com go to:

-  ``/var/log/rsyslog/c02.example.com/nova.log``

-  ``/var/log/rsyslog/nova.log``

This configuration will result in a separate log file for each compute
node as well as an aggregated log file that contains nova logs from all
nodes.
