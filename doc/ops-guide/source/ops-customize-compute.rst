==================================================
Customizing the OpenStack Compute (nova) Scheduler
==================================================

Many OpenStack projects allow for customization of specific features
using a driver architecture. You can write a driver that conforms to a
particular interface and plug it in through configuration. For example,
you can easily plug in a new scheduler for Compute. The existing
schedulers for Compute are feature full and well documented at `Scheduling
<https://docs.openstack.org/newton/config-reference/compute/scheduler.html>`_.
However, depending on your user's use cases, the existing schedulers
might not meet your requirements. You might need to create a new scheduler.

To create a scheduler, you must inherit from the class
``nova.scheduler.driver.Scheduler``. Of the five methods that you can
override, you *must* override the two methods marked with an asterisk
(\*) below:

-  ``update_service_capabilities``

-  ``hosts_up``

-  ``group_hosts``

-  \* ``schedule_run_instance``

-  \* ``select_destinations``

To demonstrate customizing OpenStack, we'll create an example of a
Compute scheduler that randomly places an instance on a subset of hosts,
depending on the originating IP address of the request and the prefix of
the hostname. Such an example could be useful when you have a group of
users on a subnet and you want all of their instances to start within
some subset of your hosts.

.. warning::

   This example is for illustrative purposes only. It should not be
   used as a scheduler for Compute without further development and
   testing.

When you join the screen session that ``stack.sh`` starts with
``screen -r stack``, you are greeted with many screen windows:

.. code-block:: console

   0$ shell*  1$ key  2$ horizon  ...  9$ n-api  ...  14$ n-sch ...


``shell``
    A shell where you can get some work done

``key``
    The keystone service

``horizon``
    The horizon dashboard web application

``n-{name}``
    The nova services

``n-sch``
    The nova scheduler service

**To create the scheduler and plug it in through configuration**

#. The code for OpenStack lives in ``/opt/stack``, so go to the ``nova``
   directory and edit your scheduler module. Change to the directory where
   ``nova`` is installed:

   .. code-block:: console

      $ cd /opt/stack/nova

#. Create the ``ip_scheduler.py`` Python source code file:

   .. code-block:: console

      $ vim nova/scheduler/ip_scheduler.py

#. The code shown below is a driver that will
   schedule servers to hosts based on IP address as explained at the
   beginning of the section. Copy the code into ``ip_scheduler.py``. When
   you are done, save and close the file.

   .. code-block:: python

      # vim: tabstop=4 shiftwidth=4 softtabstop=4
      # Copyright (c) 2014 OpenStack Foundation
      # All Rights Reserved.
      #
      #    Licensed under the Apache License, Version 2.0 (the "License"); you may
      #    not use this file except in compliance with the License. You may obtain
      #    a copy of the License at
      #
      #         http://www.apache.org/licenses/LICENSE-2.0
      #
      #    Unless required by applicable law or agreed to in writing, software
      #    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
      #    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
      #    License for the specific language governing permissions and limitations
      #    under the License.

      """
      IP Scheduler implementation
      """

      import random

      from oslo_config import cfg

      from nova.compute import rpcapi as compute_rpcapi
      from nova import exception
      from nova.openstack.common import log as logging
      from nova.openstack.common.gettextutils import _
      from nova.scheduler import driver

      CONF = cfg.CONF
      CONF.import_opt('compute_topic', 'nova.compute.rpcapi')
      LOG = logging.getLogger(__name__)

      class IPScheduler(driver.Scheduler):
          """
          Implements Scheduler as a random node selector based on
          IP address and hostname prefix.
          """

          def __init__(self, *args, **kwargs):
              super(IPScheduler, self).__init__(*args, **kwargs)
              self.compute_rpcapi = compute_rpcapi.ComputeAPI()

          def _filter_hosts(self, request_spec, hosts, filter_properties,
              hostname_prefix):
              """Filter a list of hosts based on hostname prefix."""

              hosts = [host for host in hosts if host.startswith(hostname_prefix)]
              return hosts

          def _schedule(self, context, topic, request_spec, filter_properties):
              """Picks a host that is up at random."""

              elevated = context.elevated()
              hosts = self.hosts_up(elevated, topic)
              if not hosts:
                  msg = _("Is the appropriate service running?")
                  raise exception.NoValidHost(reason=msg)

              remote_ip = context.remote_address

              if remote_ip.startswith('10.1'):
                  hostname_prefix = 'doc'
              elif remote_ip.startswith('10.2'):
                  hostname_prefix = 'ops'
              else:
                  hostname_prefix = 'dev'

              hosts = self._filter_hosts(request_spec, hosts, filter_properties,
                  hostname_prefix)
              if not hosts:
                  msg = _("Could not find another compute")
                  raise exception.NoValidHost(reason=msg)

              host = random.choice(hosts)
              LOG.debug("Request from %(remote_ip)s scheduled to %(host)s" % locals())

              return host

          def select_destinations(self, context, request_spec, filter_properties):
              """Selects random destinations."""
              num_instances = request_spec['num_instances']
              # NOTE(timello): Returns a list of dicts with 'host', 'nodename' and
              # 'limits' as keys for compatibility with filter_scheduler.
              dests = []
              for i in range(num_instances):
                  host = self._schedule(context, CONF.compute_topic,
                          request_spec, filter_properties)
                  host_state = dict(host=host, nodename=None, limits=None)
                  dests.append(host_state)

              if len(dests) < num_instances:
                  raise exception.NoValidHost(reason='')
              return dests

          def schedule_run_instance(self, context, request_spec,
                                    admin_password, injected_files,
                                    requested_networks, is_first_time,
                                    filter_properties, legacy_bdm_in_spec):
              """Create and run an instance or instances."""
              instance_uuids = request_spec.get('instance_uuids')
              for num, instance_uuid in enumerate(instance_uuids):
                  request_spec['instance_properties']['launch_index'] = num
                  try:
                      host = self._schedule(context, CONF.compute_topic,
                                            request_spec, filter_properties)
                      updated_instance = driver.instance_update_db(context,
                              instance_uuid)
                      self.compute_rpcapi.run_instance(context,
                              instance=updated_instance, host=host,
                              requested_networks=requested_networks,
                              injected_files=injected_files,
                              admin_password=admin_password,
                              is_first_time=is_first_time,
                              request_spec=request_spec,
                              filter_properties=filter_properties,
                              legacy_bdm_in_spec=legacy_bdm_in_spec)
                  except Exception as ex:
                      # NOTE(vish): we don't reraise the exception here to make sure
                      #             that all instances in the request get set to
                      #             error properly
                      driver.handle_schedule_error(context, ex, instance_uuid,
                                                   request_spec)

   There is a lot of useful information in ``context``, ``request_spec``,
   and ``filter_properties`` that you can use to decide where to schedule
   the instance. To find out more about what properties are available, you
   can insert the following log statements into the
   ``schedule_run_instance`` method of the scheduler above:

   .. code-block:: python

      LOG.debug("context = %(context)s" % {'context': context.__dict__})
      LOG.debug("request_spec = %(request_spec)s" % locals())
      LOG.debug("filter_properties = %(filter_properties)s" % locals())

#. To plug this scheduler into nova, edit one configuration file,
   ``/etc/nova/nova.conf``:

   .. code-block:: console

      $ vim /etc/nova/nova.conf

#. Find the ``scheduler_driver`` config and change it like so:

   .. code-block:: ini

      scheduler_driver=nova.scheduler.ip_scheduler.IPScheduler

#. Restart the nova scheduler service to make nova use your scheduler.
   Start by switching to the ``n-sch`` screen:

   #. Press **Ctrl+A** followed by **9**.

   #. Press **Ctrl+A** followed by **N** until you reach the ``n-sch`` screen.

   #. Press **Ctrl+C** to kill the service.

   #. Press **Up Arrow** to bring up the last command.

   #. Press **Enter** to run it.

#. Test your scheduler with the nova CLI. Start by switching to the
   ``shell`` screen and finish by switching back to the ``n-sch`` screen to
   check the log output:

   #. Press  **Ctrl+A** followed by **0**.

   #. Make sure you are in the ``devstack`` directory:

      .. code-block:: console

         $ cd /root/devstack

   #. Source ``openrc`` to set up your environment variables for the CLI:

      .. code-block:: console

         $ . openrc

   #. Put the image ID for the only installed image into an environment
      variable:

      .. code-block:: console

         $ IMAGE_ID=`openstack image list | egrep cirros | egrep -v "kernel|ramdisk" | awk '{print $2}'`

   #. Boot a test server:

      .. code-block:: console

         $ openstack server create --flavor 1 --image $IMAGE_ID scheduler-test

#. Switch back to the ``n-sch`` screen. Among the log statements, you'll
   see the line:

   .. code-block:: console

      2014-01-23 19:57:47.262 DEBUG nova.scheduler.ip_scheduler
      [req-... demo demo] Request from xx.xx.xx.xx scheduled to devstack-havana
      _schedule /opt/stack/nova/nova/scheduler/ip_scheduler.py:76

.. warning::

   Functional testing like this is not a replacement for proper unit
   and integration testing, but it serves to get you started.

A similar pattern can be followed in other projects that use the driver
architecture. Simply create a module and class that conform to the
driver interface and plug it in through configuration. Your code runs
when that feature is used and can call out to other services as
necessary. No project core code is touched. Look for a "driver" value in
the project's ``.conf`` configuration files in ``/etc/<project>`` to
identify projects that use a driver architecture.

When your scheduler is done, we encourage you to open source it and let
the community know on the OpenStack mailing list. Perhaps others need
the same functionality. They can use your code, provide feedback, and
possibly contribute. If enough support exists for it, perhaps you can
propose that it be added to the official Compute
`schedulers <https://git.openstack.org/cgit/openstack/nova/tree/nova/scheduler>`_.
