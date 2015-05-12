===============================
Manage volumes and volume types
===============================

Volumes are the Block Storage devices that you attach to instances to enable
persistent storage. Users can attach a volume to a running instance or detach
a volume and attach it to another instance at any time. For information about
using the dashboard to create and manage volumes as an end user, see the
`OpenStack End User Guide <http://docs.openstack.org/user-guide/>`_.

As an administrative user, you can manage volumes and volume types for users
in various projects. You can create and delete volume types, and you can view
and delete volumes. Note that a volume can be encrypted by using the steps
outlined below.

Create a volume type
~~~~~~~~~~~~~~~~~~~~

#. Log in to the dashboard and choose the :guilabel:`admin`
   project from the drop-down list at the top of the page.

#. On the :guilabel:`Admin` tab, open the :guilabel:`System Panel` button
   and click the :guilabel:`Volumes` category.

#. Click :guilabel:`Create Volume Type` button. In the
   :guilabel:`Create Volume Type` window, enter a name for the volume type.

#. Click :guilabel:`Create Volume Type` button to confirm your changes.

.. note:: A message indicates whether the action succeeded.

Delete volume types
~~~~~~~~~~~~~~~~~~~

When you delete a volume type, volumes of that type are not deleted.

#. Log in to the dashboard and choose the :guilabel:`admin` project from
   the drop-down list at the top of the page.

#. On the :guilabel:`Admin` tab, open the :guilabel:`System Panel` button
   and click the :guilabel:`Volumes` category.

#. Select the volume type or types that you want to delete.

#. Click :guilabel:`Delete Volume Types` button.

#. In the :guilabel:`Confirm Delete Volume Types` window, click the
   :guilabel:`Delete Volume Types` button to confirm the action.

.. note:: A message indicates whether the action succeeded.

Delete volumes
~~~~~~~~~~~~~~

When you delete an instance, the data of its attached volumes is not
destroyed.

#. Log in to the dashboard and choose the :guilabel:`admin` project
   from the drop-down list at the top of the page.

#. On the :guilabel:`Admin` tab, open the :guilabel:`System Panel` button
   and click the :guilabel:`Volumes` category.

#. Select the volume or volumes that you want to delete.

#. Click :guilabel:`Delete Volumes` button.

#. In the :guilabel:`Confirm Delete Volumes` window, click the
   :guilabel:`Delete Volumes` button to confirm the action.

.. note:: A message indicates whether the action succeeded.
