autogenerate-config-docs
========================

Automatically generate configuration tables to document OpenStack.


Dependencies: python-git (at least version 0.3.2 RC1), oslo.config,
	      openstack-doc-tools

Setting up your environment
---------------------------

Note: This tool is best run in a fresh VM environment, as running it
 requires installing the dependencies of the particular OpenStack
 product you are working with. Installing all of that on your normal
machine could leave you with a bunch of cruft!

First install git and python-pip,

    $ sudo apt-get install git python-pip

next, install oslo.config and GitPython

    $ sudo pip install oslo.config "GitPython>=0.3.2.RC1"

then, checkout the repository you are working with:

    $ git clone https://github.com/openstack/nova.git

 (this guide makes reference to a /repos directory, so you should
  record the directory you are using and replace as appropriate below)

and the tool itself:

    $ git clone https://github.com/openstack/openstack-doc-tools.git


and finally, the dependencies for the product you are working with:

    $ sudo pip install -r nova/requirements.txt

Now you are ready to use the tool.


Using the tool
--------------

This tool is divided into three parts:

1) Extraction of flags names
eg

    $ openstack-doc-tools/autogenerate-config-docs/autohelp.py --action create -i nova.flagmappings -o names --path /repos/nova

2) Grouping of flags

This is currently done manually, by using the flag name file and placing
a category after a space.

eg

     $ head flagmappings/glance.flagmappings
     admin\_password registry
     admin\_role api
     admin\_tenant\_name registry
     admin\_user registry
     ...

3) Creation of docbook-formatted configuration table files

eg

    $ openstack-doc-tools/autogenerate-config-docs/autohelp.py --action create -i nova.flagmappings -o docbook --path /repos/nova

A worked example - updating the docs for H2
----------------------------------------------------
update automatically generated tables - from scratch    
     
 $ sudo apt-get update    
 $ sudo apt-get install git python-pip python-dev    
 $ sudo pip install git-review GitPython       
 $ git clone git://github.com/openstack/openstack-manuals.git    
 $ git clone git://github.com/openstack/openstack-doc-tools.git    
 $ cd openstack-manuals/    
 $ git review -d 35726    
 $ cd tools/autogenerate-config-flagmappings
 
Now, cloning and installing requirements for nova, glance, quantum
    
 $ for i in nova glance quantum; do git clone git://github.com/openstack/$i.git; done        
 $ for i in nova glance quantum; do sudo pip install -r $i/requirements.txt; done    

This missed some requirements for nova, which were fixed by:
    
 $ sudo pip install python-glanceclient websockify pyasn1 python-cinderclient error\_util    
 $ sudo apt-get install python-ldap python-lxml    

Making the flag names update

  ../../openstack-doc-tools/autogenerate-config/autohelp.py -vvv --action update -i nova.flagmappings -o names --path ~/nova | more    

At this point, search through nova.flagmappings.new for anything labelled Unknown and fix,
once that is done use:     
     
 ../../openstack-doc-tools/autogenerate-config/autohelp.py -vvv --action create -i nova.flagmappings -o docbook --path ~/nova    

to generate the XML files and move those into the appropriate part ofthe git repo
