Start the Identity services
===========================

To start the services for Identity, run the following command:

.. code-block:: console

   $ keystone-all

This command starts two wsgi.Server instances configured by the
``keystone.conf`` file as described previously. One of these wsgi
servers is ``admin`` (the administration API) and the other is
``main`` (the primary/public API interface). Both run in a single
process.
