=================================
Tales From the Cryp^H^H^H^H Cloud
=================================

Herein lies a selection of tales from OpenStack cloud operators. Read,
and learn from their wisdom.

Double VLAN
~~~~~~~~~~~

I was on-site in Kelowna, British Columbia, Canada setting up a new
OpenStack cloud. The deployment was fully automated: Cobbler deployed
the OS on the bare metal, bootstrapped it, and Puppet took over from
there. I had run the deployment scenario so many times in practice and
took for granted that everything was working.

On my last day in Kelowna, I was in a conference call from my hotel. In
the background, I was fooling around on the new cloud. I launched an
instance and logged in. Everything looked fine. Out of boredom, I ran
:command:`ps aux` and all of the sudden the instance locked up.

Thinking it was just a one-off issue, I terminated the instance and
launched a new one. By then, the conference call ended and I was off to
the data center.

At the data center, I was finishing up some tasks and remembered the
lock-up. I logged into the new instance and ran :command:`ps aux` again.
It worked. Phew. I decided to run it one more time. It locked up.

After reproducing the problem several times, I came to the unfortunate
conclusion that this cloud did indeed have a problem. Even worse, my
time was up in Kelowna and I had to return back to Calgary.

Where do you even begin troubleshooting something like this? An instance
that just randomly locks up when a command is issued. Is it the image?
Nope—it happens on all images. Is it the compute node? Nope—all nodes.
Is the instance locked up? No! New SSH connections work just fine!

We reached out for help. A networking engineer suggested it was an MTU
issue. Great! MTU! Something to go on! What's MTU and why would it cause
a problem?

MTU is maximum transmission unit. It specifies the maximum number of
bytes that the interface accepts for each packet. If two interfaces have
two different MTUs, bytes might get chopped off and weird things
happen—such as random session lockups.

.. note::

   Not all packets have a size of 1500. Running the :command:`ls` command over
   SSH might only create a single packets less than 1500 bytes.
   However, running a command with heavy output, such as :command:`ps aux`
   requires several packets of 1500 bytes.

OK, so where is the MTU issue coming from? Why haven't we seen this in
any other deployment? What's new in this situation? Well, new data
center, new uplink, new switches, new model of switches, new servers,
first time using this model of servers… so, basically everything was
new. Wonderful. We toyed around with raising the MTU at various areas:
the switches, the NICs on the compute nodes, the virtual NICs in the
instances, we even had the data center raise the MTU for our uplink
interface. Some changes worked, some didn't. This line of
troubleshooting didn't feel right, though. We shouldn't have to be
changing the MTU in these areas.

As a last resort, our network admin (Alvaro) and myself sat down with
four terminal windows, a pencil, and a piece of paper. In one window, we
ran ping. In the second window, we ran ``tcpdump`` on the cloud
controller. In the third, ``tcpdump`` on the compute node. And the forth
had ``tcpdump`` on the instance. For background, this cloud was a
multi-node, non-multi-host setup.

One cloud controller acted as a gateway to all compute nodes.
VlanManager was used for the network config. This means that the cloud
controller and all compute nodes had a different VLAN for each OpenStack
project. We used the ``-s`` option of ``ping`` to change the packet
size. We watched as sometimes packets would fully return, sometimes they'd
only make it out and never back in, and sometimes the packets would stop at a
random point. We changed ``tcpdump`` to start displaying the hex dump of
the packet. We pinged between every combination of outside, controller,
compute, and instance.

Finally, Alvaro noticed something. When a packet from the outside hits
the cloud controller, it should not be configured with a VLAN. We
verified this as true. When the packet went from the cloud controller to
the compute node, it should only have a VLAN if it was destined for an
instance. This was still true. When the ping reply was sent from the
instance, it should be in a VLAN. True. When it came back to the cloud
controller and on its way out to the Internet, it should no longer have
a VLAN. False. Uh oh. It looked as though the VLAN part of the packet
was not being removed.

That made no sense.

While bouncing this idea around in our heads, I was randomly typing
commands on the compute node:

.. code-block:: console

   $ ip a
   …
   10: vlan100@vlan20: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master br100 state UP
   …

"Hey Alvaro, can you run a VLAN on top of a VLAN?"

"If you did, you'd add an extra 4 bytes to the packet…"

Then it all made sense…

.. code-block:: console

   $ grep vlan_interface /etc/nova/nova.conf
   vlan_interface=vlan20

In ``nova.conf``, ``vlan_interface`` specifies what interface OpenStack
should attach all VLANs to. The correct setting should have been:

.. code-block:: ini

   vlan_interface=bond0

As this would be the server's bonded NIC.

vlan20 is the VLAN that the data center gave us for outgoing Internet
access. It's a correct VLAN and is also attached to bond0.

By mistake, I configured OpenStack to attach all tenant VLANs to vlan20
instead of bond0 thereby stacking one VLAN on top of another. This added
an extra 4 bytes to each packet and caused a packet of 1504 bytes to be
sent out which would cause problems when it arrived at an interface that
only accepted 1500.

As soon as this setting was fixed, everything worked.

"The Issue"
~~~~~~~~~~~

At the end of August 2012, a post-secondary school in Alberta, Canada
migrated its infrastructure to an OpenStack cloud. As luck would have
it, within the first day or two of it running, one of their servers just
disappeared from the network. Blip. Gone.

After restarting the instance, everything was back up and running. We
reviewed the logs and saw that at some point, network communication
stopped and then everything went idle. We chalked this up to a random
occurrence.

A few nights later, it happened again.

We reviewed both sets of logs. The one thing that stood out the most was
DHCP. At the time, OpenStack, by default, set DHCP leases for one minute
(it's now two minutes). This means that every instance contacts the
cloud controller (DHCP server) to renew its fixed IP. For some reason,
this instance could not renew its IP. We correlated the instance's logs
with the logs on the cloud controller and put together a conversation:

#. Instance tries to renew IP.

#. Cloud controller receives the renewal request and sends a response.

#. Instance "ignores" the response and re-sends the renewal request.

#. Cloud controller receives the second request and sends a new
   response.

#. Instance begins sending a renewal request to ``255.255.255.255``
   since it hasn't heard back from the cloud controller.

#. The cloud controller receives the ``255.255.255.255`` request and
   sends a third response.

#. The instance finally gives up.

With this information in hand, we were sure that the problem had to do
with DHCP. We thought that for some reason, the instance wasn't getting
a new IP address and with no IP, it shut itself off from the network.

A quick Google search turned up this: `DHCP lease errors in VLAN
mode <https://lists.launchpad.net/openstack/msg11696.html>`_
which further supported our DHCP theory.

An initial idea was to just increase the lease time. If the instance
only renewed once every week, the chances of this problem happening
would be tremendously smaller than every minute. This didn't solve the
problem, though. It was just covering the problem up.

We decided to have ``tcpdump`` run on this instance and see if we could
catch it in action again. Sure enough, we did.

The ``tcpdump`` looked very, very weird. In short, it looked as though
network communication stopped before the instance tried to renew its IP.
Since there is so much DHCP chatter from a one minute lease, it's very
hard to confirm it, but even with only milliseconds difference between
packets, if one packet arrives first, it arrived first, and if that
packet reported network issues, then it had to have happened before
DHCP.

Additionally, this instance in question was responsible for a very, very
large backup job each night. While "The Issue" (as we were now calling
it) didn't happen exactly when the backup happened, it was close enough
(a few hours) that we couldn't ignore it.

Further days go by and we catch The Issue in action more and more. We
find that dhclient is not running after The Issue happens. Now we're
back to thinking it's a DHCP issue. Running ``/etc/init.d/networking``
restart brings everything back up and running.

Ever have one of those days where all of the sudden you get the Google
results you were looking for? Well, that's what happened here. I was
looking for information on dhclient and why it dies when it can't renew
its lease and all of the sudden I found a bunch of OpenStack and dnsmasq
discussions that were identical to the problem we were seeing!

`Problem with Heavy Network IO and
Dnsmasq <http://www.gossamer-threads.com/lists/openstack/operators/18197>`_.

`instances losing IP address while running, due to No
DHCPOFFER <http://www.gossamer-threads.com/lists/openstack/dev/14696>`_.

Seriously, Google.

This bug report was the key to everything: `KVM images lose connectivity
with bridged
network <https://bugs.launchpad.net/ubuntu/+source/qemu-kvm/+bug/997978>`_.

It was funny to read the report. It was full of people who had some
strange network problem but didn't quite explain it in the same way.

So it was a qemu/kvm bug.

At the same time of finding the bug report, a co-worker was able to
successfully reproduce The Issue! How? He used ``iperf`` to spew a ton
of bandwidth at an instance. Within 30 minutes, the instance just
disappeared from the network.

Armed with a patched qemu and a way to reproduce, we set out to see if
we've finally solved The Issue. After 48 hours straight of hammering the
instance with bandwidth, we were confident. The rest is history. You can
search the bug report for "joe" to find my comments and actual tests.

Disappearing Images
~~~~~~~~~~~~~~~~~~~

At the end of 2012, Cybera (a nonprofit with a mandate to oversee the
development of cyberinfrastructure in Alberta, Canada) deployed an
updated OpenStack cloud for their `DAIR
project <http://www.canarie.ca/cloud/>`_. A few days into
production, a compute node locks up. Upon rebooting the node, I checked
to see what instances were hosted on that node so I could boot them on
behalf of the customer. Luckily, only one instance.

The :command:`nova reboot` command wasn't working, so I used :command:`virsh`,
but it immediately came back with an error saying it was unable to find the
backing disk. In this case, the backing disk is the Glance image that is
copied to ``/var/lib/nova/instances/_base`` when the image is used for
the first time. Why couldn't it find it? I checked the directory and
sure enough it was gone.

I reviewed the ``nova`` database and saw the instance's entry in the
``nova.instances`` table. The image that the instance was using matched
what virsh was reporting, so no inconsistency there.

I checked Glance and noticed that this image was a snapshot that the
user created. At least that was good news—this user would have been the
only user affected.

Finally, I checked StackTach and reviewed the user's events. They had
created and deleted several snapshots—most likely experimenting.
Although the timestamps didn't match up, my conclusion was that they
launched their instance and then deleted the snapshot and it was somehow
removed from ``/var/lib/nova/instances/_base``. None of that made sense,
but it was the best I could come up with.

It turns out the reason that this compute node locked up was a hardware
issue. We removed it from the DAIR cloud and called Dell to have it
serviced. Dell arrived and began working. Somehow or another (or a fat
finger), a different compute node was bumped and rebooted. Great.

When this node fully booted, I ran through the same scenario of seeing
what instances were running so I could turn them back on. There were a
total of four. Three booted and one gave an error. It was the same error
as before: unable to find the backing disk. Seriously, what?

Again, it turns out that the image was a snapshot. The three other
instances that successfully started were standard cloud images. Was it a
problem with snapshots? That didn't make sense.

A note about DAIR's architecture: ``/var/lib/nova/instances`` is a
shared NFS mount. This means that all compute nodes have access to it,
which includes the ``_base`` directory. Another centralized area is
``/var/log/rsyslog`` on the cloud controller. This directory collects
all OpenStack logs from all compute nodes. I wondered if there were any
entries for the file that :command:`virsh` is reporting:

.. code-block:: console

   dair-ua-c03/nova.log:Dec 19 12:10:59 dair-ua-c03
   2012-12-19 12:10:59 INFO nova.virt.libvirt.imagecache
   [-] Removing base file:
   /var/lib/nova/instances/_base/7b4783508212f5d242cbf9ff56fb8d33b4ce6166_10

Ah-hah! So OpenStack was deleting it. But why?

A feature was introduced in Essex to periodically check and see if there
were any ``_base`` files not in use. If there were, OpenStack Compute
would delete them. This idea sounds innocent enough and has some good
qualities to it. But how did this feature end up turned on? It was
disabled by default in Essex. As it should be. It was `decided to be
turned on in Folsom <https://bugs.launchpad.net/nova/+bug/1029674>`_.
I cannot emphasize enough that:

*Actions which delete things should not be enabled by default.*

Disk space is cheap these days. Data recovery is not.

Secondly, DAIR's shared ``/var/lib/nova/instances`` directory
contributed to the problem. Since all compute nodes have access to this
directory, all compute nodes periodically review the \_base directory.
If there is only one instance using an image, and the node that the
instance is on is down for a few minutes, it won't be able to mark the
image as still in use. Therefore, the image seems like it's not in use
and is deleted. When the compute node comes back online, the instance
hosted on that node is unable to start.

The Valentine's Day Compute Node Massacre
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Although the title of this story is much more dramatic than the actual
event, I don't think, or hope, that I'll have the opportunity to use
"Valentine's Day Massacre" again in a title.

This past Valentine's Day, I received an alert that a compute node was
no longer available in the cloud—meaning,

.. code-block:: console

   $ openstack compute service list

showed this particular node in a down state.

I logged into the cloud controller and was able to both ``ping`` and SSH
into the problematic compute node which seemed very odd. Usually if I
receive this type of alert, the compute node has totally locked up and
would be inaccessible.

After a few minutes of troubleshooting, I saw the following details:

-  A user recently tried launching a CentOS instance on that node

-  This user was the only user on the node (new node)

-  The load shot up to 8 right before I received the alert

-  The bonded 10gb network device (bond0) was in a DOWN state

-  The 1gb NIC was still alive and active

I looked at the status of both NICs in the bonded pair and saw that
neither was able to communicate with the switch port. Seeing as how each
NIC in the bond is connected to a separate switch, I thought that the
chance of a switch port dying on each switch at the same time was quite
improbable. I concluded that the 10gb dual port NIC had died and needed
replaced. I created a ticket for the hardware support department at the
data center where the node was hosted. I felt lucky that this was a new
node and no one else was hosted on it yet.

An hour later I received the same alert, but for another compute node.
Crap. OK, now there's definitely a problem going on. Just like the
original node, I was able to log in by SSH. The bond0 NIC was DOWN but
the 1gb NIC was active.

And the best part: the same user had just tried creating a CentOS
instance. What?

I was totally confused at this point, so I texted our network admin to
see if he was available to help. He logged in to both switches and
immediately saw the problem: the switches detected spanning tree packets
coming from the two compute nodes and immediately shut the ports down to
prevent spanning tree loops:

.. code-block:: console

   Feb 15 01:40:18 SW-1 Stp: %SPANTREE-4-BLOCK_BPDUGUARD: Received BPDU packet on Port-Channel35 with BPDU guard enabled. Disabling interface. (source mac fa:16:3e:24:e7:22)
   Feb 15 01:40:18 SW-1 Ebra: %ETH-4-ERRDISABLE: bpduguard error detected on Port-Channel35.
   Feb 15 01:40:18 SW-1 Mlag: %MLAG-4-INTF_INACTIVE_LOCAL: Local interface Port-Channel35 is link down. MLAG 35 is inactive.
   Feb 15 01:40:18 SW-1 Ebra: %LINEPROTO-5-UPDOWN: Line protocol on Interface Port-Channel35 (Server35), changed state to down
   Feb 15 01:40:19 SW-1 Stp: %SPANTREE-6-INTERFACE_DEL: Interface Port-Channel35 has been removed from instance MST0
   Feb 15 01:40:19 SW-1 Ebra: %LINEPROTO-5-UPDOWN: Line protocol on Interface Ethernet35 (Server35), changed state to down

He re-enabled the switch ports and the two compute nodes immediately
came back to life.

Unfortunately, this story has an open ending... we're still looking into
why the CentOS image was sending out spanning tree packets. Further,
we're researching a proper way on how to mitigate this from happening.
It's a bigger issue than one might think. While it's extremely important
for switches to prevent spanning tree loops, it's very problematic to
have an entire compute node be cut from the network when this happens.
If a compute node is hosting 100 instances and one of them sends a
spanning tree packet, that instance has effectively DDOS'd the other 99
instances.

This is an ongoing and hot topic in networking circles —especially with
the raise of virtualization and virtual switches.

Down the Rabbit Hole
~~~~~~~~~~~~~~~~~~~~

Users being able to retrieve console logs from running instances is a
boon for support—many times they can figure out what's going on inside
their instance and fix what's going on without bothering you.
Unfortunately, sometimes overzealous logging of failures can cause
problems of its own.

A report came in: VMs were launching slowly, or not at all. Cue the
standard checks—nothing on the Nagios, but there was a spike in network
towards the current master of our RabbitMQ cluster. Investigation
started, but soon the other parts of the queue cluster were leaking
memory like a sieve. Then the alert came in—the master Rabbit server
went down and connections failed over to the slave.

At that time, our control services were hosted by another team and we
didn't have much debugging information to determine what was going on
with the master, and we could not reboot it. That team noted that it
failed without alert, but managed to reboot it. After an hour, the
cluster had returned to its normal state and we went home for the day.

Continuing the diagnosis the next morning was kick started by another
identical failure. We quickly got the message queue running again, and
tried to work out why Rabbit was suffering from so much network traffic.
Enabling debug logging on nova-api quickly brought understanding. A
``tail -f /var/log/nova/nova-api.log`` was scrolling by faster
than we'd ever seen before. CTRL+C on that and we could plainly see the
contents of a system log spewing failures over and over again - a system
log from one of our users' instances.

After finding the instance ID we headed over to
``/var/lib/nova/instances`` to find the ``console.log``:

.. code-block:: console

   adm@cc12:/var/lib/nova/instances/instance-00000e05# wc -l console.log
   92890453 console.log
   adm@cc12:/var/lib/nova/instances/instance-00000e05# ls -sh console.log
   5.5G console.log

Sure enough, the user had been periodically refreshing the console log
page on the dashboard and the 5G file was traversing the Rabbit cluster
to get to the dashboard.

We called them and asked them to stop for a while, and they were happy
to abandon the horribly broken VM. After that, we started monitoring the
size of console logs.

To this day, `the issue <https://bugs.launchpad.net/nova/+bug/832507>`__
doesn't have a permanent resolution, but we look forward to the discussion
at the next summit.

Havana Haunted by the Dead
~~~~~~~~~~~~~~~~~~~~~~~~~~

Felix Lee of Academia Sinica Grid Computing Centre in Taiwan contributed
this story.

I just upgraded OpenStack from Grizzly to Havana 2013.2-2 using the RDO
repository and everything was running pretty well—except the EC2 API.

I noticed that the API would suffer from a heavy load and respond slowly
to particular EC2 requests such as ``RunInstances``.

Output from ``/var/log/nova/nova-api.log`` on :term:`Havana`:

.. code-block:: console

   2014-01-10 09:11:45.072 129745 INFO nova.ec2.wsgi.server
   [req-84d16d16-3808-426b-b7af-3b90a11b83b0
   0c6e7dba03c24c6a9bce299747499e8a 7052bd6714e7460caeb16242e68124f9]
   117.103.103.29 "GET
   /services/Cloud?AWSAccessKeyId=[something]&Action=RunInstances&ClientToken=[something]&ImageId=ami-00000001&InstanceInitiatedShutdownBehavior=terminate...
   HTTP/1.1" status: 200 len: 1109 time: 138.5970151

This request took over two minutes to process, but executed quickly on
another co-existing Grizzly deployment using the same hardware and
system configuration.

Output from ``/var/log/nova/nova-api.log`` on :term:`Grizzly`:

.. code-block:: console

   2014-01-08 11:15:15.704 INFO nova.ec2.wsgi.server
   [req-ccac9790-3357-4aa8-84bd-cdaab1aa394e
   ebbd729575cb404081a45c9ada0849b7 8175953c209044358ab5e0ec19d52c37]
   117.103.103.29 "GET
   /services/Cloud?AWSAccessKeyId=[something]&Action=RunInstances&ClientToken=[something]&ImageId=ami-00000007&InstanceInitiatedShutdownBehavior=terminate...
   HTTP/1.1" status: 200 len: 931 time: 3.9426181

While monitoring system resources, I noticed a significant increase in
memory consumption while the EC2 API processed this request. I thought
it wasn't handling memory properly—possibly not releasing memory. If the
API received several of these requests, memory consumption quickly grew
until the system ran out of RAM and began using swap. Each node has 48
GB of RAM and the "nova-api" process would consume all of it within
minutes. Once this happened, the entire system would become unusably
slow until I restarted the nova-api service.

So, I found myself wondering what changed in the EC2 API on Havana that
might cause this to happen. Was it a bug or a normal behavior that I now
need to work around?

After digging into the nova (OpenStack Compute) code, I noticed two
areas in ``api/ec2/cloud.py`` potentially impacting my system:

.. code-block:: python

   instances = self.compute_api.get_all(context,
                                        search_opts=search_opts,
                                        sort_dir='asc')

   sys_metas = self.compute_api.get_all_system_metadata(
       context, search_filts=[{'key': ['EC2_client_token']},
                              {'value': [client_token]}])

Since my database contained many records—over 1 million metadata records
and over 300,000 instance records in "deleted" or "errored" states—each
search took a long time. I decided to clean up the database by first
archiving a copy for backup and then performing some deletions using the
MySQL client. For example, I ran the following SQL command to remove
rows of instances deleted for over a year:

.. code-block:: console

   mysql> delete from nova.instances where deleted=1 and terminated_at < (NOW() - INTERVAL 1 YEAR);

Performance increased greatly after deleting the old records and my new
deployment continues to behave well.
