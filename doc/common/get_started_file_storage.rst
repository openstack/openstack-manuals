=====================================
OpenStack Shared File Systems service
=====================================

The OpenStack Shared File Systems service (manila) provides file
storage to a virtual machine. The Shared File Systems service
provides an infrastructure for managing shares and provides access
to shares to instances. The service also enables management of share
types as well as share snapshots if a driver supports snapshots.

The Shared File Systems service consists of the following components:

manila-api
  Accepts API requests and routes them to the ``manila-share`` for
  action.

manila-share
  Interacts directly with the Shared File Systems service and processes
  such as the ``manila-scheduler``. It also interacts with these processes
  through a message queue. The ``manila-share`` service responds to read
  and write requests sent to the Shared File Systems service to maintain
  state. It can interact with a variety of storage providers through a
  driver architecture.

manila-scheduler daemon
  Selects the optimal storage provider node on which to create the
  share. A similar component to the ``cinder-scheduler``.

Messaging queue
  Routes information between the Shared File Systems processes.
