===========================
Endpoint listing middleware
===========================

The endpoint listing middleware enables third-party services that use data
locality information to integrate with OpenStack Object Storage.  This
middleware reduces network overhead and is designed for third-party services
that run inside the firewall. Deploy this middleware on a proxy server because
usage of this middleware is not authenticated.

Format requests for endpoints, as follows:

.. code-block:: none

    /endpoints/{account}/{container}/{object}
    /endpoints/{account}/{container}
    /endpoints/{account}

Use the ``list_endpoints_path`` configuration option in the
``proxy_server.conf`` file to customize the ``/endpoints/`` path.

Responses are JSON-encoded lists of endpoints, as follows:

.. code-block:: none

    http://{server}:{port}/{dev}/{part}/{acc}/{cont}/{obj}
    http://{server}:{port}/{dev}/{part}/{acc}/{cont}
    http://{server}:{port}/{dev}/{part}/{acc}

An example response is:

.. code-block:: none

    http://10.1.1.1:6000/sda1/2/a/c2/o1
    http://10.1.1.1:6000/sda1/2/a/c2
    http://10.1.1.1:6000/sda1/2/a
