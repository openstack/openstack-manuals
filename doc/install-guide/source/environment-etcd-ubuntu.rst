===============
Etcd for Ubuntu
===============

OpenStack services may use Etcd, a distributed reliable key-value store
for distributed key locking, storing configuration, keeping track of service
live-ness and other scenarios.

Install and configure components
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Install the package:

   .. code-block:: console

      # apt install etcd

   .. end

#. Edit the ``/etc/etcd/etcd.conf.yml`` file
   and set the ``initial-cluster``, ``initial-advertise-peer-urls``,
   ``advertise-client-urls``, ``listen-client-urls`` to the management
   IP address of the controller node to enable access by other nodes via
   the management network:

   .. code-block:: yaml

      name: controller
      data-dir: /var/lib/etcd
      initial-cluster-state: 'new'
      initial-cluster-token: 'etcd-cluster-01'
      initial-cluster: controller=http://10.0.0.11:2380
      initial-advertise-peer-urls: http://10.0.0.11:2380
      advertise-client-urls: http://10.0.0.11:2379
      listen-peer-urls: http://0.0.0.0:2380
      listen-client-urls: http://10.0.0.11:2379

   .. end

#. Create and edit the ``/lib/systemd/system/etcd.service`` file:

   .. code-block:: ini

      [Unit]
      After=network.target
      Description=etcd - highly-available key value store

      [Service]
      LimitNOFILE=65536
      Restart=on-failure
      Type=notify
      ExecStart=/usr/bin/etcd --config-file /etc/etcd/etcd.conf.yml
      User=etcd

      [Install]
      WantedBy=multi-user.target

   .. end

Finalize installation
~~~~~~~~~~~~~~~~~~~~~

#. Enable and start the etcd service:

   .. code-block:: console

      # systemctl enable etcd
      # systemctl start etcd

   .. end
