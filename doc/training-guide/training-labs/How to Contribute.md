How to contribute
=================

I would be glad to get some hands on the testing part of this repository. Please do follow these steps to get down to testing.

Setting Up Test Environment
---------

For using Virtual Box as test environment, you need to attach three network adapters

1. Host-Only/ Bridged -- 10.10.10.51 (Guest) -- 10.10.10.xx (Host IP for Host-Only) 
2. Host-Only/ Bridged -- 192.168.100.51 (Guest) -- 192.168.100.xx (Host IP for Host-Only)
3. Bridged/NAT -- DHCP --

**Note:** These Scripts should be run without internet connection after Pre-Install.sh. If your networking configuration is not exact a few command will not work. you need to change the Templates/* to the required IP Addresses for custom networks.

Testing
-------

**Note:** As of now only */Scripts/ folders content are being tested. Please run the file ~/Scripts/test_scripts.sh for testing all the scripts at once with one click.

1. Test Scripts Individually.
  Run the Scripts inside the Scripts Folder to check whether the shell scripts are properly functioning.
  You Dont Need to install Vitual Box although it is adviced to do so, as there is a good chance that you may end up breaking your host machine.
  
  * How to Test them??
    
    Testing these scripts is as simple as running them. Although some of the scripts need the required Input parameters.

    If you do not want to run them manually then you may run the Scripts/test_scripts.sh file.
    
  **Note:** No Need for Virutalbox Guest Addons for testing the scripts as units.

2. Test Entire System
  You need to install Virtual Box, install Ubuntu Server 12.04 or 13.04. After installation you also need to install Virtual Box Guest Addons.
  To install Virtual Box guest addons you need do the following :

  Either use the Virtual Box Guest Addons Installation via. ISO,
    ```
    #apt-get install linux-headers-generic
    #mount /dev/cdrom0/ /tmp/cdrom
    #cd /tmp/cdrom/
    #./virtualbox 
    ```
  Or You May use Ubuntu Repositories for the same
  
    ```
    #apt-get install linux-headers-generic
    #apt-get --no-install-recommends install virtualbox-guest-additions
    ```
