.. _discoverability:

===============
Discoverability
===============

Your Object Storage system might not enable all features that this
document describes. These features are:

* :ref:`large-object-creation`
* :ref:`archive-auto-extract`
* :ref:`bulk-delete`
* :ref:`static-website`

To discover which features are enabled in your Object Storage system,
use the ``/info`` request.

To use the ``/info`` request, send a ``GET`` request using the ``/info``
path to the Object Store endpoint as shown in this example:

.. code-block:: console

   $ curl https://storage.example.com/info

This example shows a truncated response body:

.. code-block:: json

   {
      "swift":{
         "version":"1.11.0"
      },
      "staticweb":{

      },
      "tempurl":{

      }
   }

This output shows that the Object Storage system has enabled the static
website and temporary URL features.

.. note::

   In some cases, the ``/info`` request will return an error. This could be
   because your service provider has disabled the ``/info`` request
   function, or because you are using an older version that does not
   support it.
