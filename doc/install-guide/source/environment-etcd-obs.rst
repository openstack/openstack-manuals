=============
Etcd for SUSE
=============

Right now, there is no distro package available for etcd3. This guide uses
the tarball installation as a workaround until proper distro packages are
available.

Install and configure components
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Install etcd:

   - Create etcd user:

     .. code-block:: console

        # groupadd --system etcd
        # useradd --home-dir "/var/lib/etcd" \
              --system \
              --shell /bin/false \
              -g etcd \
              etcd

     .. end

   - Create the necessary directories:

     .. code-block:: console

        # mkdir -p /etc/etcd
        # chown etcd:etcd /etc/etcd
        # mkdir -p /var/lib/etcd
        # chown etcd:etcd /var/lib/etcd

     .. end

   - Download and install the etcd tarball:

     .. code-block:: console

        # ETCD_VER=v3.2.7
        # rm -rf /tmp/etcd && mkdir -p /tmp/etcd
        # curl -L \
              https://github.com/coreos/etcd/releases/download/${ETCD_VER}/etcd-${ETCD_VER}-linux-amd64.tar.gz \
              -o /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz
        # tar xzvf /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz \
              -C /tmp/etcd --strip-components=1
        # cp /tmp/etcd/etcd /usr/bin/etcd
        # cp /tmp/etcd/etcdctl /usr/bin/etcdctl

     .. end

2. Create and edit the ``/etc/etcd/etcd.conf.yml`` file
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

3. Create and edit the ``/usr/lib/systemd/system/etcd.service`` file:

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

   Reload systemd service files with:

   .. code-block:: console

      # systemctl daemon-reload

   .. end


Finalize installation
~~~~~~~~~~~~~~~~~~~~~

#. Enable and start the etcd service:

   .. code-block:: console

      # systemctl enable etcd
      # systemctl start etcd

   .. end
