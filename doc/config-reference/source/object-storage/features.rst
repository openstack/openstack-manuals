=================================
Configure Object Storage features
=================================

Object Storage zones
~~~~~~~~~~~~~~~~~~~~

In OpenStack Object Storage, data is placed across different tiers of failure
domains. First, data is spread across regions, then zones, then servers, and
finally across drives. Data is placed to get the highest failure domain
isolation. If you deploy multiple regions, the Object Storage service places
the data across the regions. Within a region, each replica of the data should
be stored in unique zones, if possible. If there is only one zone, data should
be placed on different servers. And if there is only one server, data should
be placed on different drives.

Regions are widely separated installations with a high-latency or otherwise
constrained network link between them. Zones are arbitrarily assigned, and it
is up to the administrator of the Object Storage cluster to choose an isolation
level and attempt to maintain the isolation level through appropriate zone
assignment. For example, a zone may be defined as a rack with a single power
source. Or a zone may be a DC room with a common utility provider. Servers are
identified by a unique IP/port. Drives are locally attached storage volumes
identified by mount point.

In small clusters (five nodes or fewer), everything is normally in a single
zone. Larger Object Storage deployments may assign zone designations
differently; for example, an entire cabinet or rack of servers may be
designated as a single zone to maintain replica availability if the cabinet
becomes unavailable (for example, due to failure of the top of rack switches or
a dedicated circuit). In very large deployments, such as service provider level
deployments, each zone might have an entirely autonomous switching and power
infrastructure, so that even the loss of an electrical circuit or switching
aggregator would result in the loss of a single replica at most.

Rackspace zone recommendations
------------------------------

For ease of maintenance on OpenStack Object Storage, Rackspace recommends that
you set up at least five nodes. Each node is assigned its own zone (for a total
of five zones), which gives you host level redundancy. This enables you to take
down a single zone for maintenance and still guarantee object availability in
the event that another zone fails during your maintenance.

You could keep each server in its own cabinet to achieve cabinet level
isolation, but you may wish to wait until your Object Storage service is better
established before developing cabinet-level isolation. OpenStack Object Storage
is flexible; if you later decide to change the isolation level, you can take
down one zone at a time and move them to appropriate new homes.

RAID controller configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack Object Storage does not require RAID. In fact, most RAID
configurations cause significant performance degradation. The main reason for
using a RAID controller is the battery-backed cache. It is very important for
data integrity reasons that when the operating system confirms a write has been
committed that the write has actually been committed to a persistent location.
Most disks lie about hardware commits by default, instead writing to a faster
write cache for performance reasons. In most cases, that write cache exists
only in non-persistent memory. In the case of a loss of power, this data may
never actually get committed to disk, resulting in discrepancies that the
underlying file system must handle.

OpenStack Object Storage works best on the XFS file system, and this document
assumes that the hardware being used is configured appropriately to be mounted
with the ``nobarriers`` option. For more information, see the `XFS FAQ
<http://xfs.org/index.php/XFS_FAQ>`__.

To get the most out of your hardware, it is essential that every disk used in
OpenStack Object Storage is configured as a standalone, individual RAID 0 disk;
in the case of 6 disks, you would have six RAID 0s or one JBOD. Some RAID
controllers do not support JBOD or do not support battery backed cache with
JBOD. To ensure the integrity of your data, you must ensure that the individual
drive caches are disabled and the battery backed cache in your RAID card is
configured and used.  Failure to configure the controller properly in this case
puts data at risk in the case of sudden loss of power.

You can also use hybrid drives or similar options for battery backed up cache
configurations without a RAID controller.

Throttle resources through rate limits
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Rate limiting in OpenStack Object Storage is implemented as a pluggable
middleware that you configure on the proxy server. Rate limiting is performed
on requests that result in database writes to the account and container SQLite
databases. It uses memcached and is dependent on the proxy servers having
highly synchronized time. The rate limits are limited by the accuracy of the
proxy server clocks.

Configure rate limiting
-----------------------

All configuration is optional. If no account or container limits are provided,
no rate limiting occurs. Available configuration options include:

.. include:: ../tables/swift-proxy-server-filter-ratelimit.rst

The container rate limits are linearly interpolated from the values given. A
sample container rate limiting could be:

.. code-block:: ini

    container_ratelimit_100 = 100
    container_ratelimit_200 = 50
    container_ratelimit_500 = 20

This would result in:

.. list-table:: Values for Rate Limiting with Sample Configuration Settings
   :header-rows: 1

   * - Container Size
     - Rate Limit
   * - 0-99
     - No limiting
   * - 100
     - 100
   * - 150
     - 75
   * - 500
     - 20
   * - 1000
     - 20

Health check
~~~~~~~~~~~~

Provides an easy way to monitor whether the Object Storage proxy server is
alive. If you access the proxy with the path ``/healthcheck``, it responds with
``OK`` in the response body, which monitoring tools can use.

.. include:: ../tables/swift-account-server-filter-healthcheck.rst

Domain remap
~~~~~~~~~~~~

Middleware that translates container and account parts of a domain to path
parameters that the proxy server understands.

.. include:: ../tables/swift-proxy-server-filter-domain_remap.rst

CNAME lookup
~~~~~~~~~~~~

Middleware that translates an unknown domain in the host header to
something that ends with the configured ``storage_domain`` by looking up
the given domain's CNAME record in DNS.

.. include:: ../tables/swift-proxy-server-filter-cname_lookup.rst

Temporary URL
~~~~~~~~~~~~~

Allows the creation of URLs to provide temporary access to objects. For
example, a website may wish to provide a link to download a large object in
OpenStack Object Storage, but the Object Storage account has no public access.
The website can generate a URL that provides GET access for a limited time to
the resource. When the web browser user clicks on the link, the browser
downloads the object directly from Object Storage, eliminating the need for the
website to act as a proxy for the request.  If the user shares the link with
all his friends, or accidentally posts it on a forum, the direct access is
limited to the expiration time set when the website created the link.

A temporary URL is the typical URL associated with an object, with two
additional query parameters:

``temp_url_sig``
    A cryptographic signature.

``temp_url_expires``
    An expiration date, in Unix time.

An example of a temporary URL:

.. code-block:: none

        https://swift-cluster.example.com/v1/AUTH_a422b2-91f3-2f46-74b7-d7c9e8958f5d30/container/object?
        temp_url_sig=da39a3ee5e6b4b0d3255bfef95601890afd80709&
        temp_url_expires=1323479485

To create temporary URLs, first set the ``X-Account-Meta-Temp-URL-Key`` header
on your Object Storage account to an arbitrary string. This string serves as a
secret key. For example, to set a key of ``b3968d0207b54ece87cccc06515a89d4``
by using the ``swift`` command-line tool:

.. code-block:: console

    $ swift post -m "Temp-URL-Key:b3968d0207b54ece87cccc06515a89d4"

Next, generate an HMAC-SHA1 (RFC 2104) signature to specify:

-  Which HTTP method to allow (typically ``GET`` or ``PUT``).

-  The expiry date as a Unix timestamp.

-  The full path to the object.

-  The secret key set as the ``X-Account-Meta-Temp-URL-Key``.

Here is code generating the signature for a GET for 24 hours on
``/v1/AUTH_account/container/object``:

.. code-block:: python

    import hmac
    from hashlib import sha1
    from time import time
    method = 'GET'
    duration_in_seconds = 60*60*24
    expires = int(time() + duration_in_seconds)
    path = '/v1/AUTH_a422b2-91f3-2f46-74b7-d7c9e8958f5d30/container/object'
    key = 'mykey'
    hmac_body = '%s\n%s\n%s' % (method, expires, path)
    sig = hmac.new(key, hmac_body, sha1).hexdigest()
    s = 'https://{host}/{path}?temp_url_sig={sig}&temp_url_expires={expires}'
    url = s.format(host='swift-cluster.example.com', path=path, sig=sig, expires=expires)

Any alteration of the resource path or query arguments results in a 401
Unauthorized error. Similarly, a PUT where GET was the allowed method returns a
401 error. HEAD is allowed if GET or PUT is allowed. Using this in combination
with browser form post translation middleware could also allow
direct-from-browser uploads to specific locations in Object Storage.

.. note::

    Changing the ``X-Account-Meta-Temp-URL-Key`` invalidates any previously
    generated temporary URLs within 60 seconds, which is the memcache time for
    the key. Object Storage supports up to two keys, specified by
    ``X-Account-Meta-Temp-URL-Key`` and ``X-Account-Meta-Temp-URL-Key-2``.
    Signatures are checked against both keys, if present. This process enables
    key rotation without invalidating all existing temporary URLs.

Object Storage includes the ``swift-temp-url`` script that generates the
query parameters automatically:

.. code-block:: console

    $ bin/swift-temp-url GET 3600 /v1/AUTH_account/container/object mykey\
    /v1/AUTH_account/container/object?\
    temp_url_sig=5c4cc8886f36a9d0919d708ade98bf0cc71c9e91&\
    temp_url_expires=1374497657

Because this command only returns the path, you must prefix the Object Storage
host name (for example, ``https://swift-cluster.example.com``).

With GET Temporary URLs, a ``Content-Disposition`` header is set on the
response so that browsers interpret this as a file attachment to be saved. The
file name chosen is based on the object name, but you can override this with a
``filename`` query parameter. The following example specifies a filename of
``My Test File.pdf``:

.. code-block:: none

    https://swift-cluster.example.com/v1/AUTH_a422b2-91f3-2f46-74b7-d7c9e8958f5d30/container/object?
    temp_url_sig=da39a3ee5e6b4b0d3255bfef95601890afd80709&
    temp_url_expires=1323479485&
    filename=My+Test+File.pdf

If you do not want the object to be downloaded, you can cause
``Content-Disposition: inline`` to be set on the response by adding the
``inline`` parameter to the query string, as follows:

.. code-block:: none

    https://swift-cluster.example.com/v1/AUTH_account/container/object?
    temp_url_sig=da39a3ee5e6b4b0d3255bfef95601890afd80709&
    temp_url_expires=1323479485&inline

To enable Temporary URL functionality, edit ``/etc/swift/proxy-server.conf`` to
add ``tempurl`` to the ``pipeline`` variable defined in the ``[pipeline:main]``
section. The ``tempurl`` entry should appear immediately before the
authentication filters in the pipeline, such as ``authtoken``, ``tempauth`` or
``keystoneauth``. For example:

.. code-block:: ini

    [pipeline:main]
    pipeline = healthcheck cache tempurl authtoken keystoneauth proxy-server

.. include:: ../tables/swift-proxy-server-filter-tempurl.rst

Name check filter
~~~~~~~~~~~~~~~~~

Name Check is a filter that disallows any paths that contain defined forbidden
characters or that exceed a defined length.

.. include:: ../tables/swift-proxy-server-filter-name_check.rst

Constraints
~~~~~~~~~~~

To change the OpenStack Object Storage internal limits, update the values in
the ``swift-constraints`` section in the ``swift.conf`` file.  Use caution when
you update these values because they affect the performance in the entire
cluster.

.. include:: ../tables/swift-swift-swift-constraints.rst

Cluster health
~~~~~~~~~~~~~~

Use the ``swift-dispersion-report`` tool to measure overall cluster health.
This tool checks if a set of deliberately distributed containers and objects
are currently in their proper places within the cluster. For instance, a common
deployment has three replicas of each object. The health of that object can be
measured by checking if each replica is in its proper place. If only 2 of the 3
is in place the object's health can be said to be at 66.66%, where 100% would
be perfect. A single object's health, especially an older object, usually
reflects the health of that entire partition the object is in. If you make
enough objects on a distinct percentage of the partitions in the cluster,you
get a good estimate of the overall cluster health.

In practice, about 1% partition coverage seems to balance well between accuracy
and the amount of time it takes to gather results. To provide this health
value, you must create an account solely for this usage.  Next, you must place
the containers and objects throughout the system so that they are on distinct
partitions. Use the ``swift-dispersion-populate`` tool to create random
container and object names until they fall on distinct partitions.

Last, and repeatedly for the life of the cluster, you must run the
``swift-dispersion-report`` tool to check the health of each container and
object.

These tools must have direct access to the entire cluster and ring files.
Installing them on a proxy server suffices.

The ``swift-dispersion-populate`` and ``swift-dispersion-report`` commands both
use the same ``/etc/swift/dispersion.conf`` configuration file. Example
``dispersion.conf`` file:

.. code-block:: ini

    [dispersion]
    auth_url = http://localhost:8080/auth/v1.0
    auth_user = test:tester
    auth_key = testing

You can use configuration options to specify the dispersion coverage, which
defaults to 1%, retries, concurrency, and so on. However, the defaults are
usually fine. After the configuration is in place, run the
``swift-dispersion-populate`` tool to populate the containers and objects
throughout the cluster. Now that those containers and objects are in place, you
can run the ``swift-dispersion-report`` tool to get a dispersion report or view
the overall health of the cluster. Here is an example of a cluster in perfect
health:

.. code-block:: console

    $ swift-dispersion-report
    Queried 2621 containers for dispersion reporting, 19s, 0 retries
    100.00% of container copies found (7863 of 7863)
    Sample represents 1.00% of the container partition space

    Queried 2619 objects for dispersion reporting, 7s, 0 retries
    100.00% of object copies found (7857 of 7857)
    Sample represents 1.00% of the object partition space

Now, deliberately double the weight of a device in the object ring (with
replication turned off) and re-run the dispersion report to show what impact
that has:

.. code-block:: console

    $ swift-ring-builder object.builder set_weight d0 200
    $ swift-ring-builder object.builder rebalance
    ...
    $ swift-dispersion-report
    Queried 2621 containers for dispersion reporting, 8s, 0 retries
    100.00% of container copies found (7863 of 7863)
    Sample represents 1.00% of the container partition space

    Queried 2619 objects for dispersion reporting, 7s, 0 retries
    There were 1763 partitions missing one copy.
    77.56% of object copies found (6094 of 7857)
    Sample represents 1.00% of the object partition space

You can see the health of the objects in the cluster has gone down
significantly. Of course, this test environment has just four devices, in a
production environment with many devices the impact of one device change is
much less. Next, run the replicators to get everything put back into place and
then rerun the dispersion report:

.. code-block:: none

    # start object replicators and monitor logs until they're caught up ...
    $ swift-dispersion-report
    Queried 2621 containers for dispersion reporting, 17s, 0 retries
    100.00% of container copies found (7863 of 7863)
    Sample represents 1.00% of the container partition space

    Queried 2619 objects for dispersion reporting, 7s, 0 retries
    100.00% of object copies found (7857 of 7857)
    Sample represents 1.00% of the object partition space

Alternatively, the dispersion report can also be output in JSON format. This
allows it to be more easily consumed by third-party utilities:

.. code-block:: console

    $ swift-dispersion-report -j
    {"object": {"retries:": 0, "missing_two": 0, "copies_found": 7863, "missing_one": 0,
    "copies_expected": 7863, "pct_found": 100.0, "overlapping": 0, "missing_all": 0}, "container":
    {"retries:": 0, "missing_two": 0, "copies_found": 12534, "missing_one": 0, "copies_expected":
    12534, "pct_found": 100.0, "overlapping": 15, "missing_all": 0}}

.. include:: ../tables/swift-dispersion-dispersion.rst

Static Large Object (SLO) support
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This feature is very similar to Dynamic Large Object (DLO) support in that it
enables the user to upload many objects concurrently and afterwards download
them as a single object. It is different in that it does not rely on eventually
consistent container listings to do so.  Instead, a user-defined manifest of
the object segments is used.

For more information regarding SLO usage and support, please see: `Static Large
Objects <https://docs.openstack.org/developer/swift/middleware.html#slo-doc>`__.

.. include:: ../tables/swift-proxy-server-filter-slo.rst

Container quotas
~~~~~~~~~~~~~~~~

The ``container_quotas`` middleware implements simple quotas that can be
imposed on Object Storage containers by a user with the ability to set
container metadata, most likely the account administrator. This can be useful
for limiting the scope of containers that are delegated to non-admin users,
exposed to form POST uploads, or just as a self-imposed sanity check.

Any object PUT operations that exceed these quotas return a ``Forbidden (403)``
status code.

Quotas are subject to several limitations: eventual consistency, the timeliness
of the cached container\_info (60 second TTL by default), and it is unable to
reject chunked transfer uploads that exceed the quota (though once the quota is
exceeded, new chunked transfers are refused).

Set quotas by adding meta values to the container. These values are validated
when you set them:

``X-Container-Meta-Quota-Bytes``
   Maximum size of the container, in bytes.

``X-Container-Meta-Quota-Count``
   Maximum object count of the container.

Account quotas
~~~~~~~~~~~~~~

The ``x-account-meta-quota-bytes`` metadata entry must be requests (PUT, POST)
if a given account quota (in bytes) is exceeded while DELETE requests are still
allowed.

The ``x-account-meta-quota-bytes`` metadata entry must be set to store and
enable the quota. Write requests to this metadata entry are only permitted for
resellers. There is no account quota limitation on a reseller account even if
``x-account-meta-quota-bytes`` is set.

Any object PUT operations that exceed the quota return a 413 response (request
entity too large) with a descriptive body.

The following command uses an admin account that owns the Reseller role to
set a quota on the test account:

.. code-block:: console

    $ swift -A http://127.0.0.1:8080/auth/v1.0 -U admin:admin -K admin \
    --os-storage-url http://127.0.0.1:8080/v1/AUTH_test post -m quota-bytes:10000

Here is the stat listing of an account where quota has been set:

.. code-block:: console

    $ swift -A http://127.0.0.1:8080/auth/v1.0 -U test:tester -K testing stat
    Account: AUTH_test
    Containers: 0
    Objects: 0
    Bytes: 0
    Meta Quota-Bytes: 10000
    X-Timestamp: 1374075958.37454
    X-Trans-Id: tx602634cf478546a39b1be-0051e6bc7a

This command removes the account quota:

.. code-block:: console

    $ swift -A http://127.0.0.1:8080/auth/v1.0 -U admin:admin -K admin \
      --os-storage-url http://127.0.0.1:8080/v1/AUTH_test post -m quota-bytes:

Bulk delete
~~~~~~~~~~~

Use ``bulk-delete`` to delete multiple files from an account with a single
request. Responds to DELETE requests with a header 'X-Bulk-Delete:
true\_value'. The body of the DELETE request is a new line-separated list of
files to delete. The files listed must be URL encoded and in the form:

.. code-block:: none

        /container_name/obj_name

If all files are successfully deleted (or did not exist), the operation returns
``HTTPOk``. If any files failed to delete, the operation returns
``HTTPBadGateway``. In both cases, the response body is a JSON dictionary that
shows the number of files that were successfully deleted or not found. The
files that failed are listed.

.. include:: ../tables/swift-proxy-server-filter-bulk.rst


Drive audit
~~~~~~~~~~~

The ``swift-drive-audit`` configuration items reference a script that can be
run by using ``cron`` to watch for bad drives. If errors are detected, it
unmounts the bad drive so that OpenStack Object Storage can work around it. It
takes the following options:

.. include:: ../tables/swift-drive-audit-drive-audit.rst

Form post
~~~~~~~~~

Middleware that enables you to upload objects to a cluster by using an HTML
form POST.

The format of the form is:

.. code-block:: html

    <form action="<swift-url>" method="POST"
          enctype="multipart/form-data">
      <input type="hidden" name="redirect" value="<redirect-url>" />
      <input type="hidden" name="max_file_size" value="<bytes>" />
      <input type="hidden" name="max_file_count" value="<count>" />
      <input type="hidden" name="expires" value="<unix-timestamp>" />
      <input type="hidden" name="signature" value="<hmac>" />
      <input type="hidden" name="x_delete_at" value="<unix-timestamp>"/>
      <input type="hidden" name="x_delete_after" value="<seconds>"/>
      <input type="file" name="file1" /><br />
      <input type="submit" />
    </form>

In the form:

``action="<swift-url>"``
   The URL to the Object Storage destination, such as
   https://swift-cluster.example.com/v1/AUTH_account/container/object_prefix.

   The name of each uploaded file is appended to the specified ``swift-url``.
   So, you can upload directly to the root of container with a URL like
   https://swift-cluster.example.com/v1/AUTH_account/container/.

   Optionally, you can include an object prefix to separate different users'
   uploads, such as
   https://swift-cluster.example.com/v1/AUTH_account/container/object_prefix.

``method="POST"``
   The form ``method`` must be POST.

``enctype="multipart/form-data``
   The ``enctype`` must be set to ``multipart/form-data``.

``name="redirect"``
   The URL to which to redirect the browser after the upload completes.
   The URL has status and message query parameters added to it that
   indicate the HTTP status code for the upload and, optionally,
   additional error information. The 2\ *nn* status code indicates
   success. If an error occurs, the URL might include error information,
   such as ``"max_file_size exceeded"``.

``name="max_file_size"``
   Required. The maximum number of bytes that can be uploaded in a single file
   upload.

``name="max_file_count"``
   Required. The maximum number of files that can be uploaded with the form.

``name="expires"``
   The expiration date and time for the form in `UNIX Epoch time stamp format
   <https://en.wikipedia.org/wiki/Unix_time>`__. After this date and time, the
   form is no longer valid.

   For example, ``1440619048`` is equivalent to ``Mon, Wed, 26 Aug 2015
   19:57:28 GMT``.

``name="signature"``
   The HMAC-SHA1 signature of the form. This sample Python code shows
   how to compute the signature:

   .. code-block:: python

       import hmac
       from hashlib import sha1
       from time import time
       path = '/v1/account/container/object_prefix'
       redirect = 'https://myserver.com/some-page'
       max_file_size = 104857600
       max_file_count = 10
       expires = int(time() + 600)
       key = 'mykey'
       hmac_body = '%s\n%s\n%s\n%s\n%s' % (path, redirect,
           max_file_size, max_file_count, expires)
       signature = hmac.new(key, hmac_body, sha1).hexdigest()

   The key is the value of the ``X-Account-Meta-Temp-URL-Key`` header on the
   account.

   Use the full path from the ``/v1/`` value and onward.

   During testing, you can use the ``swift-form-signature`` command-line tool
   to compute the ``expires`` and ``signature`` values.

``name="x_delete_at"``
   The date and time in `UNIX Epoch time stamp format
   <https://en.wikipedia.org/wiki/Unix_time>`__ when the object will be
   removed.

   For example, ``1440619048`` is equivalent to ``Mon, Wed, 26 Aug 2015
   19:57:28 GMT``.

   This attribute enables you to specify the ``X-Delete- At`` header value in
   the form POST.

``name="x_delete_after"``
   The number of seconds after which the object is removed. Internally, the
   Object Storage system stores this value in the ``X-Delete-At`` metadata
   item. This attribute enables you to specify the ``X-Delete-After`` header
   value in the form POST.

``type="file" name="filexx"``
   Optional. One or more files to upload. Must appear after the other
   attributes to be processed correctly. If attributes come after the ``file``
   attribute, they are not sent with the sub- request because on the server
   side, all attributes in the file cannot be parsed unless the whole file is
   read into memory and the server does not have enough memory to service these
   requests. So, attributes that follow the ``file`` attribute are ignored.

.. include:: ../tables/swift-proxy-server-filter-formpost.rst

Static web sites
~~~~~~~~~~~~~~~~

When configured, this middleware serves container data as a static web site
with index file and error file resolution and optional file listings. This mode
is normally only active for anonymous requests.

.. include:: ../tables/swift-proxy-server-filter-staticweb.rst
