.. _launch-instance-manila:

Shared File Systems
~~~~~~~~~~~~~~~~~~~

Create the service image
------------------------

.. note::

   In typical deployments, you should create an instance from an image that
   supports network file systems such as NFS/CIFS to evaluate the Shared File
   Systems service. This guide should use the CirrOS image for instances to
   reduce resource requirements for evaluation. However, the CirrOS image
   lacks support for network file systems. For evaluation of the Shared File
   Systems service, this guide creates a regular instance using the
   ``manila-share-service`` image because it supports network file systems and
   using the ``manila-service-flavor`` that limits resource consumption by the
   instance to 256 MB memory on the compute node.

#. Download the source image of the share server:

   .. code-block:: console

      $ wget http://tarballs.openstack.org/manila-image-elements/images/manila-service-image-master.qcow2

#. Add the image to the Image service:

   .. code-block:: console

      # openstack image create "manila-service-image" \
      --file manila-service-image-master.qcow2 \
      --disk-format qcow2 \
      --container-format bare \
      --public
      +------------------+------------------------------------------------------+
      | Field            | Value                                                |
      +------------------+------------------------------------------------------+
      | checksum         | abb1fdf972162c7214db9fad43229dad                     |
      | container_format | bare                                                 |
      | created_at       | 2016-03-16T23:37:51Z                                 |
      | disk_format      | qcow2                                                |
      | file             | /v2/images/dcec8c7f-4c59-4223-a06f-220231b49c0c/file |
      | id               | dcec8c7f-4c59-4223-a06f-220231b49c0c                 |
      | min_disk         | 0                                                    |
      | min_ram          | 0                                                    |
      | name             | manila-service-image                                 |
      | owner            | fd4a657caa054ca99d8b4179722f49de                     |
      | protected        | False                                                |
      | schema           | /v2/schemas/image                                    |
      | size             | 324665344                                            |
      | status           | active                                               |
      | tags             |                                                      |
      | updated_at       | 2016-03-16T23:37:55Z                                 |
      | virtual_size     | None                                                 |
      | visibility       | public                                               |
      +------------------+------------------------------------------------------+

#. Create a new flavor to support the service image:

   .. code-block:: console

      # openstack flavor create manila-service-flavor --id 100 --ram 256 --disk 0 --vcpus 1
      +----------------------------+-----------------------+
      | Field                      | Value                 |
      +----------------------------+-----------------------+
      | OS-FLV-DISABLED:disabled   | False                 |
      | OS-FLV-EXT-DATA:ephemeral  | 0                     |
      | disk                       | 0                     |
      | id                         | 100                   |
      | name                       | manila-service-flavor |
      | os-flavor-access:is_public | True                  |
      | ram                        | 256                   |
      | rxtx_factor                | 1.0                   |
      | swap                       |                       |
      | vcpus                      | 1                     |
      +----------------------------+-----------------------+

   .. note::

      Flavor is image specific and may differ from image to image.

Launch an instance of the service image
---------------------------------------

.. note::

   This section uses ``manila-service-image`` image as an instance for
   mounting shares.

#. Launch an instance using the ``manila-service-image`` and
   ``manila-service-flavor``.

#. Log into the instance using ``manila`` as the username and password.

Create a share
--------------

Create a share for the Shared File Systems service option that you chose
in :ref:`manila-storage`.

.. toctree::
   :maxdepth: 1

   launch-instance-manila-dhss-false-option1.rst
   launch-instance-manila-dhss-true-option2.rst
