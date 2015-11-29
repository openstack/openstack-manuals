======================
Support for ISO images
======================

You can load ISO images into the Image service. You can subsequently
boot an ISO image using Compute.

To load an ISO image to an Image service data store
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In the Image service, run the following command:

.. code-block:: console

   $ glance image-create --name "my-image.iso" \
     --copy-from IMAGE_URL \
     --is-public True --container-format bare --disk-format iso

In this command, ``my-image.iso`` is the name for the ISO image after
it is loaded to the Image service, and ``IMAGE_URL`` is a remote
location with the URL of the source ISO image.

Optionally, to confirm the upload in Image service (glance), run this
command:

.. code-block:: console

   $ glance image-list
