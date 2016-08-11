============
Uninstalling
============

While we'd always recommend using your automated deployment system to
reinstall systems from scratch, sometimes you do need to remove
OpenStack from a system the hard way. Here's how:

* Remove all packages.
* Remove remaining files.
* Remove databases.

These steps depend on your underlying distribution, but in general you
should be looking for :command:`purge` commands in your package manager, like
:command:`aptitude purge ~c $package`. Following this, you can look for
orphaned files in the directories referenced throughout this guide. To
uninstall the database properly, refer to the manual appropriate for the
product in use.
