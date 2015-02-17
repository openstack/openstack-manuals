===============================
Assign CORS headers to requests
===============================

Cross-Origin Resource Sharing (CORS) is a specification that defines how
browsers and servers communicate across origins by using HTTP headers,
such as those assigned by Object Storage API requests. The Object
Storage API supports the following headers:

- Access-Control-Allow-Credentials
- Access-Control-Allow-Methods
- Access-Control-Allow-Origin
- Access-Control-Expose-Headers
- Access-Control-Max-Age
- Access-Control-Request-Headers
- Access-Control-Request-Method
- Origin

You can only assign these headers to objects. For more information, see
`www.w3.org/TR/access-control/ <http://www.w3.org/TR/access-control/>`__.

This example assigns the file origin to the ``Origin`` header, which
ensures that the file originated from a reputable source:

.. code::

    $ curl -i -X POST -H "Origin: example.com" -H "X-Auth-Token:
    48e17715dfce47bb90dc2a336f63493a"
    https://storage.example.com/v1/MossoCloudFS_c31366f1-9f1c-40dc-a
    b92-6b3f0b5a8c45/ephotos
    HTTP/1.1 204 No Content
    Content-Length: 0
    Content-Type: text/html; charset=UTF-8
    Access-Control-Allow-Origin: example.com
    Access-Control-Expose-Headers: cache-control, content-language,
    content-type, expires, last-modified, pragma, etag, x-timestamp, x-trans-id
    X-Trans-Id: tx979bfe26be6649c489ada-0054cba1d9ord1
    Date: Fri, 30 Jan 2015 15:23:05 GMT
