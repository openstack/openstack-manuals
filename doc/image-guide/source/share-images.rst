=============
Image sharing
=============

Image producers and consumers are both OpenStack users, or projects.
Image producers create and share images with image consumers, allowing
the consumers to use the shared image when booting a server. The
producer shares an image with the consumer by making the consumer a
member of that image. The consumer then accepts or rejects the image
by changing the image member status. After it is accepted, the image
appears in the consumer's image list. As long as the consumer is a
member of the image, the consumer can use the image, regardless of the
image member status, if the consumer knows the image ID.

.. note::
   In the OpenStack Image API, the image member status serves three
   purposes:

   -  The member status controls whether image appears in the consumer's
      image list. If the image member status is ``accepted``, the image
      appears in the consumer's image list. Otherwise, the image does not
      appear in the image list. The image may still be used as long as
      the consumer knows the image ID.

   -  The member status can be used to filter the consumer's image list.

   -  The member status lets the producer know whether the consumer has
      seen and acted on the shared image. If the status is ``accepted`` or
      ``rejected``, the consumer has definitely seen the shared image. If
      the status is ``pending``, the consumer may not be aware that an
      image was shared.

Image producers and consumers have different abilities and
responsibilities regarding image sharing, which the following list shows.

-  Image producers add members to images, or remove members from images, but
   they may not modify the member status of an image member.

-  Image producers and consumers view the status of image members. When
   listing image members, the producers see all the image members, and
   the consumers see only themselves.

-  Image consumers change their own member status, but they may not add
   or remove themselves as an image member.

-  Image consumers can boot from any image shared by the image producer,
   regardless of the member status, as long as the consumer knows the
   image ID.

Sharing an image
~~~~~~~~~~~~~~~~~

The following procedure is a workflow for image sharing after image creation.

Communications between the image producer and the consumer, such as
those described in this example, must be arranged independently of
the OpenStack Image API. The consumer and producer can send notifications
by using email, phone, Twitter, or other channels.

#. The producer posts the availability of specific images for consumers to
   review.

#. A potential consumer provides the producer with the consumer's project
   ID. Optionally, the producer might request the consumer's email
   address for notification purposes, but this is outside the scope of
   the API.

#. The producer shares the image with the consumer,  by using the
   ``Create image member`` API operation.

#. Optionally, the producer notifies the consumer that the image has
   been shared and provides the image's ID (UUID).

#. If the consumer wants the image to appear in the image list, the
   consumer uses the OpenStack Image API to change the image member status
   to ``accepted``, by using the ``Update image member`` API operation.

#. If the consumer subsequently wants to hide the image, the consumer
   uses the OpenStack Image API to change the image member status to
   ``rejected``. If the consumer wants to hide the image, but is open to
   the possibility of being reminded by the producer that the image is
   available, the consumer uses the OpenStack Image API to change the image
   member status back to ``pending``, by using the ``Update image member``
   API operation.
