============
Requirements
============

External requirements affecting glance
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Like other OpenStack projects, glance uses some external libraries for a subset
of its features. Some examples include the ``qemu-img`` utility used by the
tasks feature, ``sendfile`` to utilize the "zero-copy" way of copying data
faster, ``pydev`` to debug using popular IDEs, ``python-xattr`` for Image Cache
using "xattr" driver.

On the other hand, if ``dnspython`` is installed in an environment, glance
provides a workaround to make it work with IPv6.

Additionally, some libraries like ``xattr`` are not compatible when using
glance on Windows (see :doc:`the documentation on config options affecting the
Image Cache <image-configuring>`).


Guideline to include your requirement in the requirements.txt file
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As described above, we do not include all the possible requirements needed by
glance features in the source tree requirements file. Therefore, when
you decide to use an **advanced feature** in glance, you have to check the
documentation/guidelines for those features to set up the feature in a workable
way. To reduce pain, the development team works with different operators
to figure out when a popular feature should have its
dependencies included in the requirements file. However, there is a tradeoff in
including more of requirements in source tree as it becomes more painful for
packagers. So, it is a bit of a haggle among different stakeholders and a
judicious decision is taken by the project PTL or release liaison to determine
the outcome.

To simplify the identification of an **advanced feature** in glance, we can
think of it as something not being used and deployed by most of the
upstream/known community members.

To name a few features that have been identified as advanced:

* glance tasks
* image signing
* image prefetcher
* glance db purge utility
* image locations


Steps to include your requirement in the requirements.txt file
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Propose a change against the ``openstack/requirements``
   project to include the requirement(s) as a part of the
   ``global-requirements`` and ``upper-constraints`` files.

#. If your requirement is not a part of the project, propose a
   change adding that requirement to the requirements.txt file in glance.
   Include a ``Depends-On: <ChangeID>`` flag in the commit message, where
   the ``ChangeID`` is the gerrit ID of corresponding change against
   ``openstack/requirements`` project.

A sync bot then syncs the global requirements into project requirements on a
regular basis, so any updates to the requirements are synchronized on a timely
basis.
