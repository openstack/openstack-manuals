=====================================
Overview of high availability storage
=====================================

Making the Block Storage (cinder) API service highly available in
active/active mode involves:

* Configuring Block Storage to listen on the VIP address

* Managing the Block Storage API daemon with the Pacemaker cluster manager

* Configuring OpenStack services to use this IP address
