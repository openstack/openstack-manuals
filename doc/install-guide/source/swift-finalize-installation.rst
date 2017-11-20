Finalize installation
~~~~~~~~~~~~~~~~~~~~~

.. include:: shared/note_configuration_vary_by_distribution.rst

.. only:: ubuntu or rdo or debian

   #. Obtain the ``/etc/swift/swift.conf`` file from the Object
      Storage source repository:

      .. code-block:: console

         # curl -o /etc/swift/swift.conf \
           https://git.openstack.org/cgit/openstack/swift/plain/etc/swift.conf-sample?h=mitaka-eol

   #. Edit the ``/etc/swift/swift.conf`` file and complete the following
      actions:

      * In the ``[swift-hash]`` section, configure the hash path prefix and
        suffix for your environment.

        .. code-block:: ini

           [swift-hash]
           ...
           swift_hash_path_suffix = HASH_PATH_SUFFIX
           swift_hash_path_prefix = HASH_PATH_PREFIX

        Replace HASH_PATH_PREFIX and HASH_PATH_SUFFIX with unique values.

        .. warning::

           Keep these values secret and do not change or lose them.

      * In the ``[storage-policy:0]`` section, configure the default
        storage policy:

        .. code-block:: ini

           [storage-policy:0]
           ...
           name = Policy-0
           default = yes

   #. Copy the ``swift.conf`` file to the ``/etc/swift`` directory on
      each storage node and any additional nodes running the proxy service.

.. only:: obs

   #. Edit the ``/etc/swift/swift.conf`` file and complete the following
      actions:

      * In the ``[swift-hash]`` section, configure the hash path prefix and
        suffix for your environment.

        .. code-block:: ini

           [swift-hash]
           ...
           swift_hash_path_suffix = HASH_PATH_SUFFIX
           swift_hash_path_prefix = HASH_PATH_PREFIX

        Replace HASH_PATH_PREFIX and HASH_PATH_SUFFIX with unique values.

        .. warning::

           Keep these values secret and do not change or lose them.

      * In the ``[storage-policy:0]`` section, configure the default
        storage policy:

        .. code-block:: ini

           [storage-policy:0]
           ...
           name = Policy-0
           default = yes

   #. Copy the ``swift.conf`` file to the ``/etc/swift`` directory on
      each storage node and any additional nodes running the proxy service.

.. only:: ubuntu or debian

   4. On all nodes, ensure proper ownership of the configuration directory:

      .. code-block:: console

         # chown -R root:swift /etc/swift

   5. On the controller node and any other nodes running the proxy service,
      restart the Object Storage proxy service including its dependencies:

      .. code-block:: console

         # service memcached restart
         # service swift-proxy restart

   6. On the storage nodes, start the Object Storage services:

      .. code-block:: console

         # swift-init all start

      .. note::

         The storage node runs many Object Storage services and the
         :command:`swift-init` command makes them easier to manage.
         You can ignore errors from services not running on the storage node.

.. only:: rdo

   4. On all nodes, ensure proper ownership of the configuration directory:

      .. code-block:: console

         # chown -R root:swift /etc/swift

   5. On the controller node and any other nodes running the proxy service,
      start the Object Storage proxy service including its dependencies and
      configure them to start when the system boots:

      .. code-block:: console

         # systemctl enable openstack-swift-proxy.service memcached.service
         # systemctl start openstack-swift-proxy.service memcached.service

   6. On the storage nodes, start the Object Storage services and configure
      them to start when the system boots:

      .. code-block:: console

         # systemctl enable openstack-swift-account.service openstack-swift-account-auditor.service \
           openstack-swift-account-reaper.service openstack-swift-account-replicator.service
         # systemctl start openstack-swift-account.service openstack-swift-account-auditor.service \
           openstack-swift-account-reaper.service openstack-swift-account-replicator.service
         # systemctl enable openstack-swift-container.service \
           openstack-swift-container-auditor.service openstack-swift-container-replicator.service \
           openstack-swift-container-updater.service
         # systemctl start openstack-swift-container.service \
           openstack-swift-container-auditor.service openstack-swift-container-replicator.service \
           openstack-swift-container-updater.service
         # systemctl enable openstack-swift-object.service openstack-swift-object-auditor.service \
           openstack-swift-object-replicator.service openstack-swift-object-updater.service
         # systemctl start openstack-swift-object.service openstack-swift-object-auditor.service \
           openstack-swift-object-replicator.service openstack-swift-object-updater.service

.. only:: obs

   3. On all nodes, ensure proper ownership of the configuration directory:

      .. code-block:: console

         # chown -R root:swift /etc/swift

   4. On the controller node and any other nodes running the proxy service,
      start the Object Storage proxy service including its dependencies and
      configure them to start when the system boots:

      .. code-block:: console

         # systemctl enable openstack-swift-proxy.service memcached.service
         # systemctl start openstack-swift-proxy.service memcached.service

   5. On the storage nodes, start the Object Storage services and configure
      them to start when the system boots:

      .. code-block:: console

         # systemctl enable openstack-swift-account.service openstack-swift-account-auditor.service \
           openstack-swift-account-reaper.service openstack-swift-account-replicator.service
         # systemctl start openstack-swift-account.service openstack-swift-account-auditor.service \
           openstack-swift-account-reaper.service openstack-swift-account-replicator.service
         # systemctl enable openstack-swift-container.service openstack-swift-container-auditor.service \
           openstack-swift-container-replicator.service openstack-swift-container-updater.service
         # systemctl start openstack-swift-container.service openstack-swift-container-auditor.service \
           openstack-swift-container-replicator.service openstack-swift-container-updater.service
         # systemctl enable openstack-swift-object.service openstack-swift-object-auditor.service \
           openstack-swift-object-replicator.service openstack-swift-object-updater.service
         # systemctl start openstack-swift-object.service openstack-swift-object-auditor.service \
           openstack-swift-object-replicator.service openstack-swift-object-updater.service
