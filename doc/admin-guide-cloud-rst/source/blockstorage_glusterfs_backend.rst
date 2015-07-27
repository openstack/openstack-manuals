==============================
Configure a GlusterFS back end
==============================

This section explains how to configure OpenStack Block Storage to use
GlusterFS as a back end. You must be able to access the GlusterFS shares
from the server that hosts the ``cinder`` volume service.

.. note::

   The cinder volume service is named ``openstack-cinder-volume`` on the
   following distributions:

   * CentOS

   * Fedora

   * openSUSE

   * Red Hat Enterprise Linux

   * SUSE Linux Enterprise

   In Ubuntu and Debian distributions, the ``cinder`` volume service is
   named ``cinder-volume``.

Mounting GlusterFS volumes requires utilities and libraries from the
``glusterfs-fuse`` package. This package must be installed on all systems
that will access volumes backed by GlusterFS.

.. note::

   The utilities and libraries required for mounting GlusterFS volumes on
   Ubuntu and Debian distributions are available from the ``glusterfs-client``
   package instead.

For information on how to install and configure GlusterFS, refer to the
`GlusterDocumentation`_ page.

**Configure GlusterFS for OpenStack Block Storage**

The GlusterFS server must also be configured accordingly in order to allow
OpenStack Block Storage to use GlusterFS shares:

#. Log in as ``root`` to the GlusterFS server.

#. Set each Gluster volume to use the same UID and GID as the ``cinder`` user::

    # gluster volume set VOL_NAME storage.owner-uid CINDER_UID
    # gluster volume set VOL_NAME storage.owner-gid CINDER_GID

   Where:

   * VOL_NAME is the Gluster volume name.

   * CINDER_UID is the UID of the ``cinder`` user.

   * CINDER_GID is the GID of the ``cinder`` user.

   .. note::

      The default UID and GID of the ``cinder`` user is 165 on
      most distributions.

#. Configure each Gluster volume to accept ``libgfapi`` connections.
   To do this, set each Gluster volume to allow insecure ports::

    # gluster volume set VOL_NAME server.allow-insecure on

#. Enable client connections from unprivileged ports. To do this,
   add the following line to :file:`/etc/glusterfs/glusterd.vol`::

    option rpc-auth-allow-insecure on

#. Restart the ``glusterd`` service::

    # service glusterd restart

|

**Configure Block Storage to use a GlusterFS back end**

After you configure the GlusterFS service, complete these steps:

#. Log in as ``root`` to the system hosting the Block Storage service.

#. Create a text file named :file:`glusterfs` in :file:`/etc/cinder/`.

#. Add an entry to :file:`/etc/cinder/glusterfs` for each GlusterFS
   share that OpenStack Block Storage should use for back end storage.
   Each entry should be a separate line, and should use the following
   format::

    HOST:/VOL_NAME

   Where:

   * HOST is the IP address or host name of the Red Hat Storage server.

   * VOL_NAME is the name of an existing and accessible volume on the
     GlusterFS server.

   |

   Optionally, if your environment requires additional mount options for
   a share, you can add them to the share's entry::

    HOST:/VOL_NAME -o OPTIONS

   Replace OPTIONS with a comma-separated list of mount options.

#. Set :file:`/etc/cinder/glusterfs` to be owned by the root user
   and the ``cinder`` group::

    # chown root:cinder /etc/cinder/glusterfs

#. Set :file:`/etc/cinder/glusterfs` to be readable by members of
   the ``cinder`` group::

    # chmod 0640 FILE

#. Configure OpenStack Block Storage to use the :file:`/etc/cinder/glusterfs`
   file created earlier. To do so, open the :file:`/etc/cinder/cinder.conf`
   configuration file and set the ``glusterfs_shares_config`` configuration
   key to :file:`/etc/cinder/glusterfs`.

   On distributions that include openstack-config, you can configure this
   by running the following command instead::

    # openstack-config --set /etc/cinder/cinder.conf \
      DEFAULT glusterfs_shares_config /etc/cinder/glusterfs

   The following distributions include ``openstack-config``:

   * CentOS

   * Fedora

   * openSUSE

   * Red Hat Enterprise Linux

   * SUSE Linux Enterprise

   |

#. Configure OpenStack Block Storage to use the correct volume driver,
   namely ``cinder.volume.drivers.glusterfs``. To do so, open the
   :file:`/etc/cinder/cinder.conf` configuration file and set the
   ``volume_driver`` configuration key to ``cinder.volume.drivers.glusterfs``.

   On distributions that include ``openstack-config``, you can configure
   this by running the following command instead::

    # openstack-config --set /etc/cinder/cinder.conf \
      DEFAULT volume_driver cinder.volume.drivers.glusterfs.GlusterfsDriver

#. You can now restart the service to apply the configuration.

   To restart the ``cinder`` volume service on CentOS, Fedora, openSUSE, Red
   Hat Enterprise Linux, or SUSE Linux Enterprise, run::

    # service openstack-cinder-volume restart

   To restart the ``cinder`` volume service on Ubuntu or Debian, run::

    # service cinder-volume restart

OpenStack Block Storage is now configured to use a GlusterFS back end.

.. note::

   In :file:`/etc/cinder/cinder.conf`, the ``glusterfs_sparsed_volumes`` configuration
   key determines whether volumes are created as sparse files and grown
   as needed or fully allocated up front. The default and recommended
   value of this key is true, which ensures volumes are initially created
   as sparse files.

   Setting ``glusterfs_sparsed_volumes`` to false will result in volumes being
   fully allocated at the time of creation. This leads to increased delays
   in volume creation.

   However, should you choose to set glusterfs_sparsed_volumes to false, you
   can do so directly in :file:`/etc/cinder/cinder.conf`.

   On distributions that include ``openstack-config``, you can configure this by
   running the following command instead::

    # openstack-config --set /etc/cinder/cinder.conf \
      DEFAULT glusterfs_sparsed_volumes false

.. warning::

   If a client host has SELinux enabled, the ``virt_use_fusefs`` boolean
   should also be enabled if the host requires access to GlusterFS volumes
   on an instance. To enable this Boolean, run the following command as
   the ``root`` user::

    # setsebool -P virt_use_fusefs on

   This command also makes the Boolean persistent across reboots. Run
   this command on all client hosts that require access to GlusterFS
   volumes on an instance. This includes all compute nodes.

.. Links
.. _`GlusterDocumentation`: http://www.gluster.org/community/documentation/index.php/Main_Page
