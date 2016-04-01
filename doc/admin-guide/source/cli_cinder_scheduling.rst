===============================
Manage Block Storage scheduling
===============================

As an administrative user, you have some control over which volume
back end your volumes reside on. You can specify affinity or
anti-affinity between two volumes. Affinity between volumes means
that they are stored on the same back end, whereas anti-affinity
means that they are stored on different back ends.

For information on how to set up multiple back ends for Cinder,
refer to :ref:`multi_backend`.

Example Usages
~~~~~~~~~~~~~~

#. Create a new volume on the same back end as Volume_A:

   .. code-block:: console

      $ cinder create --hint same_host=Volume_A-UUID SIZE

#. Create a new volume on a different back end than Volume_A:

   .. code-block:: console

      $ cinder create --hint different_host=Volume_A-UUID SIZE

#. Create a new volume on the same back end as Volume_A and Volume_B:

   .. code-block:: console

      $ cinder create --hint same_host=Volume_A-UUID --hint same_host=Volume_B-UUID SIZE

   Or:

   .. code-block:: console

      $ cinder create --hint same_host="[Volume_A-UUID, Volume_B-UUID]" SIZE

#. Create a new volume on a different back end than both Volume_A and
   Volume_B:

   .. code-block:: console

      $ cinder create --hint different_host=Volume_A-UUID --hint different_host=Volume_B-UUID SIZE

   Or:

   .. code-block:: console

      $ cinder create --hint different_host="[Volume_A-UUID, Volume_B-UUID]" SIZE
