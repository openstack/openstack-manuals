=====================
Notifications options
=====================

The notifications feature in the Message service can be enabled by adding
``zaqar.notification.notifier`` stage to the message storage layer pipeline. To
do it, ensure that ``zaqar.notification.notifier`` is added to
``message_pipeline`` option in the ``[storage]`` section of ``zaqar.conf``:

.. code-block:: ini

   [storage]
   message_pipeline = zaqar.notification.notifier

For more information about storage layer pipelines, see
:doc:`zaqar-storage-drivers`.
