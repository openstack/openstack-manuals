===============
Etcd for Ubuntu
===============

OpenStack services may use Etcd, a distributed reliable key-value store
for distributed key locking, storing configuration, keeping track of service
live-ness and other scenarios.

Install and configure components
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Install the ``etcd`` package:

   .. code-block:: console

      # apt install etcd

#. Edit the ``/etc/default/etcd`` file and set the ``ETCD_INITIAL_CLUSTER``,
   ``ETCD_INITIAL_ADVERTISE_PEER_URLS``, ``ETCD_ADVERTISE_CLIENT_URLS``,
   ``ETCD_LISTEN_CLIENT_URLS`` to the management IP address of the
   controller node to enable access by other nodes via the management
   network:

   .. code-block:: none

      ETCD_NAME="controller"
      ETCD_DATA_DIR="/var/lib/etcd"
      ETCD_INITIAL_CLUSTER_STATE="new"
      ETCD_INITIAL_CLUSTER_TOKEN="etcd-cluster-01"
      ETCD_INITIAL_CLUSTER="controller=http://10.0.0.11:2380"
      ETCD_INITIAL_ADVERTISE_PEER_URLS="http://10.0.0.11:2380"
      ETCD_ADVERTISE_CLIENT_URLS="http://10.0.0.11:2379"
      ETCD_LISTEN_PEER_URLS="http://0.0.0.0:2380"
      ETCD_LISTEN_CLIENT_URLS="http://10.0.0.11:2379"

Finalize installation
~~~~~~~~~~~~~~~~~~~~~

#. Enable and start the etcd service:

   .. code-block:: console

      # systemctl enable etcd
      # systemctl start etcd
