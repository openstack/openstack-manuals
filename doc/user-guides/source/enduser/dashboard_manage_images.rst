.. meta::
    :scope: user_only

========================
Upload and manage images
========================
A virtual machine image, referred to in this document simply
as an image, is a single file that contains a virtual disk that
has a bootable operating system installed on it. Images are used
to create virtual machine instances within the cloud. For information about creating image
files, see the `*OpenStack Virtual Machine Image
Guide* <http://docs.openstack.org/image-guide/content/>`__.

Depending on your role, you may have permission to upload and manage
virtual machine images. Operators might restrict the upload and
management of images to cloud administrators or operators only. If you
have the appropriate privileges, you can use the dashboard to upload and
manage images in the admin project.

.. note:: You can also use the :command:`glance` and :command:`nova`
   command-line clients or the Image Service and Compute APIs to manage images.

Upload an image
~~~~~~~~~~~~~~~

Follow this procedure to upload an image to a project.

#. Log in to the dashboard.

#. From the CURRENT PROJECT on the :guilabel:`Project` tab, select the
   appropriate project.

#. On the :guilabel:`Project tab`, click :guilabel:`Images`.

#. Click :guilabel:`Create Image`.

   The :guilabel:`Create An Image` dialog box appears.

#. Enter the following values:

Name
   Enter a name for the image

Description
   Optionally, enter a brief description of the image.

#. Click :guilabel:`Create Image`.

   The image is queued to be uploaded. It might take some time before
   the status changes from Queued to Active.

Update an image
~~~~~~~~~~~~~~~

Follow this procedure to update an existing image.

#. Log in to the dashboard.

#. From the CURRENT PROJECT on the :guilabel:`Project` tab, select the
   appropriate project.

#. On the :guilabel:`Project` tab, click :guilabel:`Images`.

#. Select the image that you want to edit.

#. In the :guilabel:`Actions` column, click :guilabel:`More` and then select
   :guilabel:`Edit` from the list.

#. In the :guilabel:`Update Image` dialog box, you can perform the following
   actions:

   -  Change the name of the image.

   -  Select the :guilabel:`Public` check box to make the image public.

   -  Clear the :guilabel:`Public` check box to make the image private.

#. Click :guilabel:`Update Image`.

Delete an image
~~~~~~~~~~~~~~~

Deletion of images is permanent and **cannot** be reversed. Only users
with the appropriate permissions can delete images.

#. Log in to the dashboard.

#. From the CURRENT PROJECT on the :guilabel:`Project` tab, select the
   appropriate project.

#. On the :guilabel:`Project` tab, click :guilabel:`Images`.

#. Select the images that you want to delete.

#. Click :guilabel:`Delete Images`.

#. In the :guilabel:`Confirm Delete Image` dialog box, click
   :guilabel:`Delete Images` to confirm the deletion.
