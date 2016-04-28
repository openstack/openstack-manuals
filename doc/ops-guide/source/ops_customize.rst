=============
Customization
=============

OpenStack might not do everything you need it to do out of the box. To
add a new feature, you can follow different paths.

To take the first path, you can modify the OpenStack code directly.
Learn `how to
contribute <https://wiki.openstack.org/wiki/How_To_Contribute>`_,
follow the `code review
workflow <https://wiki.openstack.org/wiki/GerritWorkflow>`_, make your
changes, and contribute them back to the upstream OpenStack project.
This path is recommended if the feature you need requires deep
integration with an existing project. The community is always open to
contributions and welcomes new functionality that follows the
feature-development guidelines. This path still requires you to use
DevStack for testing your feature additions, so this chapter walks you
through the DevStack environment.

For the second path, you can write new features and plug them in using
changes to a configuration file. If the project where your feature would
need to reside uses the Python Paste framework, you can create
middleware for it and plug it in through configuration. There may also
be specific ways of customizing a project, such as creating a new
scheduler driver for Compute or a custom tab for the dashboard.

This chapter focuses on the second path for customizing OpenStack by
providing two examples for writing new features. The first example shows
how to modify Object Storage (swift) middleware to add a new feature,
and the second example provides a new scheduler feature for OpenStack
Compute (nova). To customize OpenStack this way you need a development
environment. The best way to get an environment up and running quickly
is to run DevStack within your cloud.

Create an OpenStack Development Environment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To create a development environment, you can use DevStack. DevStack is
essentially a collection of shell scripts and configuration files that
builds an OpenStack development environment for you. You use it to
create such an environment for developing a new feature.

You can find all of the documentation at the
`DevStack <http://docs.openstack.org/developer/devstack/>`_ website.

**To run DevStack on an instance in your OpenStack cloud:**

#. Boot an instance from the dashboard or the nova command-line interface
   (CLI) with the following parameters:

   -  Name: devstack

   -  Image: Ubuntu 14.04 LTS

   -  Memory Size: 4 GB RAM

   -  Disk Size: minimum 5 GB

   If you are using the ``nova`` client, specify :option:`--flavor 3` for the
   :command:`nova boot` command to get adequate memory and disk sizes.

#. Log in and set up DevStack. Here's an example of the commands you can
   use to set up DevStack on a virtual machine:

   #. Log in to the instance:

      .. code-block:: console

         $ ssh username@my.instance.ip.address

   #. Update the virtual machine's operating system:

      .. code-block:: console

         # apt-get -y update

   #. Install git:

      .. code-block:: console

         # apt-get -y install git

   #. Clone the ``devstack`` repository:

      .. code-block:: console

         $ git clone https://git.openstack.org/openstack-dev/devstack

   #. Change to the ``devstack`` repository:

      .. code-block:: console

         $ cd devstack

#. (Optional) If you've logged in to your instance as the root user, you
   must create a "stack" user; otherwise you'll run into permission issues.
   If you've logged in as a user other than root, you can skip these steps:

   #. Run the DevStack script to create the stack user:

      .. code-block:: console

         # tools/create-stack-user.sh

   #. Give ownership of the ``devstack`` directory to the stack user:

      .. code-block:: console

         # chown -R stack:stack /root/devstack

   #. Set some permissions you can use to view the DevStack screen later:

      .. code-block:: console

         # chmod o+rwx /dev/pts/0

   #. Switch to the stack user:

      .. code-block:: console

         $ su stack

#. Edit the ``local.conf`` configuration file that controls what DevStack
   will deploy. Copy the example ``local.conf`` file at the end of this
   section (:ref:`local.conf`):

   .. code-block:: console

      $ vim local.conf

#. Run the stack script that will install OpenStack:

   .. code-block:: console

      $ ./stack.sh

#. When the stack script is done, you can open the screen session it
   started to view all of the running OpenStack services:

   .. code-block:: console

      $ screen -r stack

#. Press ``Ctrl+A`` followed by 0 to go to the first ``screen`` window.

.. note::

   -  The ``stack.sh`` script takes a while to run. Perhaps you can
      take this opportunity to `join the OpenStack
      Foundation <https://www.openstack.org/join/>`__.

   -  ``Screen`` is a useful program for viewing many related services
      at once. For more information, see the `GNU screen quick
      reference <http://aperiodic.net/screen/quick_reference>`__.

Now that you have an OpenStack development environment, you're free to
hack around without worrying about damaging your production deployment.
:ref:`local.conf` provides a working environment for
running OpenStack Identity, Compute, Block Storage, Image service, the
OpenStack dashboard, and Object Storage as the starting point.

.. _local.conf:

local.conf
----------

.. code-block:: bash

   [[local|localrc]]
   FLOATING_RANGE=192.168.1.224/27
   FIXED_RANGE=10.11.12.0/24
   FIXED_NETWORK_SIZE=256
   FLAT_INTERFACE=eth0
   ADMIN_PASSWORD=supersecret
   DATABASE_PASSWORD=iheartdatabases
   RABBIT_PASSWORD=flopsymopsy
   SERVICE_PASSWORD=iheartksl
   SERVICE_TOKEN=xyzpdqlazydog

Customizing Object Storage (Swift) Middleware
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack Object Storage, known as swift when reading the code, is based
on the Python `Paste <http://pythonpaste.org/>`_ framework. The best
introduction to its architecture is `A Do-It-Yourself
Framework <http://pythonpaste.org/do-it-yourself-framework.html>`_.
Because of the swift project's use of this framework, you are able to
add features to a project by placing some custom code in a project's
pipeline without having to change any of the core code.

Imagine a scenario where you have public access to one of your
containers, but what you really want is to restrict access to that to a
set of IPs based on a whitelist. In this example, we'll create a piece
of middleware for swift that allows access to a container from only a
set of IP addresses, as determined by the container's metadata items.
Only those IP addresses that you explicitly whitelist using the
container's metadata will be able to access the container.

.. warning::

   This example is for illustrative purposes only. It should not be
   used as a container IP whitelist solution without further
   development and extensive security testing.

When you join the screen session that ``stack.sh`` starts with
``screen -r stack``, you see a screen for each service running, which
can be a few or several, depending on how many services you configured
DevStack to run.

The asterisk * indicates which screen window you are viewing. This
example shows we are viewing the key (for keystone) screen window:


.. code-block:: console

   0$ shell  1$ key*  2$ horizon  3$ s-proxy  4$ s-object  5$ s-container  6$ s-account

The purpose of the screen windows are as follows:


``shell``
    A shell where you can get some work done

``key*``
    The keystone service

``horizon``
    The horizon dashboard web application

``s-{name}``
    The swift services

**To create the middleware and plug it in through Paste configuration:**

All of the code for OpenStack lives in ``/opt/stack``. Go to the swift
directory in the ``shell`` screen and edit your middleware module.

#. Change to the directory where Object Storage is installed:

   .. code-block:: console

      $ cd /opt/stack/swift

#. Create the ``ip_whitelist.py`` Python source code file:

   .. code-block:: console

      $ vim swift/common/middleware/ip_whitelist.py

#. Copy the code as shown below into ``ip_whitelist.py``.
   The following code is a middleware example that
   restricts access to a container based on IP address as explained at the
   beginning of the section. Middleware passes the request on to another
   application. This example uses the swift "swob" library to wrap Web
   Server Gateway Interface (WSGI) requests and responses into objects for
   swift to interact with. When you're done, save and close the file.

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

      import socket

      from swift.common.utils import get_logger
      from swift.proxy.controllers.base import get_container_info
      from swift.common.swob import Request, Response

      class IPWhitelistMiddleware(object):
          """
          IP Whitelist Middleware

          Middleware that allows access to a container from only a set of IP
          addresses as determined by the container's metadata items that start
          with the prefix 'allow'. E.G. allow-dev=192.168.0.20
          """

          def __init__(self, app, conf, logger=None):
              self.app = app

              if logger:
                  self.logger = logger
              else:
                  self.logger = get_logger(conf, log_route='ip_whitelist')

              self.deny_message = conf.get('deny_message', "IP Denied")
              self.local_ip = socket.gethostbyname(socket.gethostname())

          def __call__(self, env, start_response):
              """
              WSGI entry point.
              Wraps env in swob.Request object and passes it down.

              :param env: WSGI environment dictionary
              :param start_response: WSGI callable
              """
              req = Request(env)

              try:
                  version, account, container, obj = req.split_path(1, 4, True)
              except ValueError:
                  return self.app(env, start_response)

              container_info = get_container_info(
                  req.environ, self.app, swift_source='IPWhitelistMiddleware')

              remote_ip = env['REMOTE_ADDR']
              self.logger.debug("Remote IP: %(remote_ip)s",
                                {'remote_ip': remote_ip})

              meta = container_info['meta']
              allow = {k:v for k,v in meta.iteritems() if k.startswith('allow')}
              allow_ips = set(allow.values())
              allow_ips.add(self.local_ip)
              self.logger.debug("Allow IPs: %(allow_ips)s",
                                {'allow_ips': allow_ips})

              if remote_ip in allow_ips:
                  return self.app(env, start_response)
              else:
                  self.logger.debug(
                      "IP %(remote_ip)s denied access to Account=%(account)s "
                      "Container=%(container)s. Not in %(allow_ips)s", locals())
                  return Response(
                      status=403,
                      body=self.deny_message,
                      request=req)(env, start_response)


      def filter_factory(global_conf, **local_conf):
          """
          paste.deploy app factory for creating WSGI proxy apps.
          """
          conf = global_conf.copy()
          conf.update(local_conf)

          def ip_whitelist(app):
              return IPWhitelistMiddleware(app, conf)
          return ip_whitelist


   There is a lot of useful information in ``env`` and ``conf`` that you
   can use to decide what to do with the request. To find out more about
   what properties are available, you can insert the following log
   statement into the ``__init__`` method:

   .. code-block:: python

      self.logger.debug("conf = %(conf)s", locals())


   and the following log statement into the ``__call__`` method:

   .. code-block:: python

      self.logger.debug("env = %(env)s", locals())

#. To plug this middleware into the swift Paste pipeline, you edit one
   configuration file, ``/etc/swift/proxy-server.conf``:

   .. code-block:: console

      $ vim /etc/swift/proxy-server.conf

#. Find the ``[filter:ratelimit]`` section in
   ``/etc/swift/proxy-server.conf``, and copy in the following
   configuration section after it:

   .. code-block:: ini

      [filter:ip_whitelist]
      paste.filter_factory = swift.common.middleware.ip_whitelist:filter_factory
      # You can override the default log routing for this filter here:
      # set log_name = ratelimit
      # set log_facility = LOG_LOCAL0
      # set log_level = INFO
      # set log_headers = False
      # set log_address = /dev/log
      deny_message = You shall not pass!

#. Find the ``[pipeline:main]`` section in
   ``/etc/swift/proxy-server.conf``, and add ``ip_whitelist`` after
   ratelimit to the list like so. When you're done, save and close the
   file:

   .. code-block:: ini

      [pipeline:main]
      pipeline = catch_errors gatekeeper healthcheck proxy-logging cache bulk tempurl ratelimit ip_whitelist ...

#. Restart the ``swift proxy`` service to make swift use your middleware.
   Start by switching to the ``swift-proxy`` screen:

   #. Press **Ctrl+A** followed by 3.

   #. Press **Ctrl+C** to kill the service.

   #. Press Up Arrow to bring up the last command.

   #. Press Enter to run it.

#. Test your middleware with the ``swift`` CLI. Start by switching to the
   shell screen and finish by switching back to the ``swift-proxy`` screen
   to check the log output:

   #. Press  **Ctrl+A** followed by 0.

   #. Make sure you're in the ``devstack`` directory:

      .. code-block:: console

         $ cd /root/devstack

   #. Source openrc to set up your environment variables for the CLI:

      .. code-block:: console

         $ source openrc

   #. Create a container called ``middleware-test``:

      .. code-block:: console

         $ swift post middleware-test

   #. Press **Ctrl+A** followed by 3 to check the log output.

#. Among the log statements you'll see the lines:

   .. code-block:: ini

      proxy-server Remote IP: my.instance.ip.address (txn: ...)
      proxy-server Allow IPs: set(['my.instance.ip.address']) (txn: ...)

   These two statements are produced by our middleware and show that the
   request was sent from our DevStack instance and was allowed.

#. Test the middleware from outside DevStack on a remote machine that has
   access to your DevStack instance:

   #. Install the ``keystone`` and ``swift`` clients on your local machine:

      .. code-block:: console

         # pip install python-keystoneclient python-swiftclient

   #. Attempt to list the objects in the ``middleware-test`` container:

      .. code-block:: console

         $ swift --os-auth-url=http://my.instance.ip.address:5000/v2.0/ \
         --os-region-name=RegionOne --os-username=demo:demo \
         --os-password=devstack list middleware-test
         Container GET failed: http://my.instance.ip.address:8080/v1/AUTH_.../
             middleware-test?format=json 403 Forbidden   You shall not pass!

#. Press **Ctrl+A** followed by 3 to check the log output. Look at the
   swift log statements again, and among the log statements, you'll see the
   lines:

   .. code-block:: console

      proxy-server Authorizing from an overriding middleware (i.e: tempurl) (txn: ...)
      proxy-server ... IPWhitelistMiddleware
      proxy-server Remote IP: my.local.ip.address (txn: ...)
      proxy-server Allow IPs: set(['my.instance.ip.address']) (txn: ...)
      proxy-server IP my.local.ip.address denied access to Account=AUTH_... \
         Container=None. Not in set(['my.instance.ip.address']) (txn: ...)

   Here we can see that the request was denied because the remote IP
   address wasn't in the set of allowed IPs.

#. Back in your DevStack instance on the shell screen, add some metadata to
   your container to allow the request from the remote machine:

   #. Press **Ctrl+A** followed by 0.

   #. Add metadata to the container to allow the IP:

      .. code-block:: console

         $ swift post --meta allow-dev:my.local.ip.address middleware-test

   #. Now try the command from Step 10 again and it succeeds. There are no
      objects in the container, so there is nothing to list; however, there is
      also no error to report.

.. warning::

   Functional testing like this is not a replacement for proper unit
   and integration testing, but it serves to get you started.

You can follow a similar pattern in other projects that use the Python
Paste framework. Simply create a middleware module and plug it in
through configuration. The middleware runs in sequence as part of that
project's pipeline and can call out to other services as necessary. No
project core code is touched. Look for a ``pipeline`` value in the
project's ``conf`` or ``ini`` configuration files in ``/etc/<project>``
to identify projects that use Paste.

When your middleware is done, we encourage you to open source it and let
the community know on the OpenStack mailing list. Perhaps others need
the same functionality. They can use your code, provide feedback, and
possibly contribute. If enough support exists for it, perhaps you can
propose that it be added to the official swift
`middleware <https://git.openstack.org/cgit/openstack/swift/tree/swift/common/middleware>`_.

Customizing the OpenStack Compute (nova) Scheduler
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Many OpenStack projects allow for customization of specific features
using a driver architecture. You can write a driver that conforms to a
particular interface and plug it in through configuration. For example,
you can easily plug in a new scheduler for Compute. The existing
schedulers for Compute are feature full and well documented at
`Scheduling <http://docs.openstack.org/liberty/config-reference/content/section_compute-scheduler.html>`_.
However, depending on your user's use cases, the existing schedulers
might not meet your requirements. You might need to create a new
scheduler.

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
   you're done, save and close the file.

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

      from oslo.config import cfg

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

   #. Press **Ctrl+A** followed by 9.

   #. Press **Ctrl+A** followed by N until you reach the ``n-sch`` screen.

   #. Press **Ctrl+C** to kill the service.

   #. Press Up Arrow to bring up the last command.

   #. Press Enter to run it.

#. Test your scheduler with the nova CLI. Start by switching to the
   ``shell`` screen and finish by switching back to the ``n-sch`` screen to
   check the log output:

   #. Press  **Ctrl+A** followed by 0.

   #. Make sure you're in the ``devstack`` directory:

      .. code-block:: console

         $ cd /root/devstack

   #. Source ``openrc`` to set up your environment variables for the CLI:

      .. code-block:: console

         $ source openrc

   #. Put the image ID for the only installed image into an environment
      variable:

      .. code-block:: console

         $ IMAGE_ID=`nova image-list | egrep cirros | egrep -v "kernel|ramdisk" | awk '{print $2}'`

   #. Boot a test server:

      .. code-block:: console

         $ nova boot --flavor 1 --image $IMAGE_ID scheduler-test

#. Switch back to the ``n-sch`` screen. Among the log statements, you'll
   see the line:

   .. code-block:: console

      2014-01-23 19:57:47.262 DEBUG nova.scheduler.ip_scheduler \
      [req-... demo demo] Request from 162.242.221.84 \
      scheduled to devstack-havana \
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

Customizing the Dashboard (Horizon)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The dashboard is based on the Python
`Django <https://www.djangoproject.com/>`_ web application framework.
The best guide to customizing it has already been written and can be
found at `Building on
Horizon <http://docs.openstack.org/developer/horizon/topics/tutorial.html>`_.

Conclusion
~~~~~~~~~~

When operating an OpenStack cloud, you may discover that your users can
be quite demanding. If OpenStack doesn't do what your users need, it may
be up to you to fulfill those requirements. This chapter provided you
with some options for customization and gave you the tools you need to
get started.
