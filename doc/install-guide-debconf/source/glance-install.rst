Install and configure
~~~~~~~~~~~~~~~~~~~~~

This section describes how to install and configure the Image service,
code-named glance, on the controller node. For simplicity, this
configuration stores images on the local file system.

Install and configure components
--------------------------------

#. Install the packages:

   .. code-block:: console

      # apt-get install glance python-glanceclient

#. Respond to prompts for
   :doc:`database management <debconf/debconf-dbconfig-common>`,
   :doc:`Identity service credentials <debconf/debconf-keystone-authtoken>`,
   :doc:`service endpoint registration <debconf/debconf-api-endpoints>`,
   and :doc:`message broker credentials <debconf/debconf-rabbitmq>`.

#. Select the ``keystone`` pipeline to configure the Image service
   to use the Identity service:

   .. image:: figures/debconf-screenshots/glance-common_pipeline_flavor.png
      :width: 100%
