=============================
Cross-origin resource sharing
=============================

Cross-Origin Resource Sharing (CORS) is a mechanism that allows code running in
a browser (JavaScript for example) to make requests to a domain, other than the
one it was originated from. OpenStack Object Storage supports CORS requests to
containers and objects within the containers using metadata held on the
container.

In addition to the metadata on containers, you can use the
``cors_allow_origin`` option in the ``proxy-server.conf`` file to set a list of
hosts that are included with any CORS request by default.
