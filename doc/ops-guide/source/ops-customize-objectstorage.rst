=============================================
Customizing Object Storage (Swift) Middleware
=============================================

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

   #. Press **Ctrl+A** followed by **3**.

   #. Press **Ctrl+C** to kill the service.

   #. Press **Up Arrow** to bring up the last command.

   #. Press Enter to run it.

#. Test your middleware with the ``swift`` CLI. Start by switching to the
   shell screen and finish by switching back to the ``swift-proxy`` screen
   to check the log output:

   #. Press  **Ctrl+A** followed by **0**.

   #. Make sure you're in the ``devstack`` directory:

      .. code-block:: console

         $ cd /root/devstack

   #. Source openrc to set up your environment variables for the CLI:

      .. code-block:: console

         $ . openrc

   #. Create a container called ``middleware-test``:

      .. code-block:: console

         $ swift post middleware-test

   #. Press **Ctrl+A** followed by **3** to check the log output.

#. Among the log statements you'll see the lines:

   .. code-block:: none

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

#. Press **Ctrl+A** followed by **3** to check the log output. Look at the
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

   #. Press **Ctrl+A** followed by **0**.

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
