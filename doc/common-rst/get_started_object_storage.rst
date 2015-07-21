========================
OpenStack Object Storage
========================

The OpenStack Object Storage is a multi-tenant object storage system. It
is highly scalable and can manage large amounts of unstructured data at
low cost through a RESTful HTTP API.

It includes the following components:

Proxy servers (swift-proxy-server)
  Accepts OpenStack Object Storage API and raw HTTP requests to upload
  files, modify metadata, and create containers. It also serves file
  or container listings to web browsers. To improve performance, the
  proxy server can use an optional cache that is usually deployed with
  memcache.

Account servers (swift-account-server)
  Manages accounts defined with Object Storage.

Container servers (swift-container-server)
  Manages the mapping of containers or folders, within Object Storage.

Object servers (swift-object-server)
  Manages actual objects,such as files, on the storage nodes.

Various periodic processes
  Performs housekeeping tasks on the large data store. The replication
  services ensure consistency and availability through the cluster.
  Other periodic processes include auditors, updaters, and reapers.

WSGI middleware
  Handles authentication and is usually OpenStack Identity.
