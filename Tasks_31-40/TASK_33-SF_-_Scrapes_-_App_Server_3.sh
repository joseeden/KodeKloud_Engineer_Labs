
-----------------------------------------------------------------------------------------------------------------

# SUPPORTING FILE 

# This is a supporting file for the Task of the same name.
# This may contain configurations/config file.
# Basically, any file that is edited/created/modified through the 'vi' or 'nano' command will appear here.
# Note that there may be more than one supporting files for the Task at hand.

-----------------------------------------------------------------------------------------------------------------

TASK 33 - SupportFile - Scrapes for App Server 3


thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
Warning: Permanently added '172.16.238.12' (ECDSA) to the list of known hosts.
sudo su -
******

[banner@stapp03 ~]$ sudo su -

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for banner:
[root@stapp03 ~]#
[root@stapp03 ~]#
[root@stapp03 ~]# yum install firewalld -y
Loaded plugins: fastestmirror, ovl
Determining fastest mirrors
epel/x86_64/metalink                                      |  33 kB  00:00:00
 * base: mirror.plustech.de
 * epel: mirrors.n-ix.net
 * extras: mirror.plustech.de
 * remi-php72: mirror.23media.com
 * remi-safe: mirror.23media.com
 * updates: mirror.plustech.de
base                                                                                                                                  | 3.6 kB  00:00:00
epel                                                                                                                                  | 4.7 kB  00:00:00
extras                                                                                                                                | 2.9 kB  00:00:00
remi-php72                                                                                                                            | 3.0 kB  00:00:00
remi-safe                                                                                                                             | 3.0 kB  00:00:00
updates                                                                                                                               | 2.9 kB  00:00:00
(1/9): base/7/x86_64/group_gz                                                                                                         | 153 kB  00:00:00
(2/9): extras/7/x86_64/primary_db                                                                                                     | 206 kB  00:00:00
(3/9): base/7/x86_64/primary_db                                                                                                       | 6.1 MB  00:00:00
(4/9): epel/x86_64/group_gz                                                                                                           |  95 kB  00:00:00
(5/9): epel/x86_64/updateinfo                                                                                                         | 1.0 MB  00:00:00
(6/9): remi-php72/primary_db                                                                                                          | 241 kB  00:00:00
(7/9): remi-safe/primary_db                                                                                                           | 1.8 MB  00:00:01
(8/9): epel/x86_64/primary_db                                                                                                         | 6.9 MB  00:00:02
(9/9): updates/7/x86_64/primary_db                                                                                                    | 3.8 MB  00:00:04
Resolving Dependencies
--> Running transaction check
---> Package firewalld.noarch 0:0.6.3-8.el7_8.1 will be installed
--> Processing Dependency: python-firewall = 0.6.3-8.el7_8.1 for package: firewalld-0.6.3-8.el7_8.1.noarch
--> Processing Dependency: firewalld-filesystem = 0.6.3-8.el7_8.1 for package: firewalld-0.6.3-8.el7_8.1.noarch
--> Processing Dependency: ipset for package: firewalld-0.6.3-8.el7_8.1.noarch
--> Processing Dependency: ebtables for package: firewalld-0.6.3-8.el7_8.1.noarch
--> Running transaction check
---> Package ebtables.x86_64 0:2.0.10-16.el7 will be installed
---> Package firewalld-filesystem.noarch 0:0.6.3-8.el7_8.1 will be installed
---> Package ipset.x86_64 0:7.1-1.el7 will be installed
--> Processing Dependency: ipset-libs(x86-64) = 7.1-1.el7 for package: ipset-7.1-1.el7.x86_64
--> Processing Dependency: libipset.so.13(LIBIPSET_4.8)(64bit) for package: ipset-7.1-1.el7.x86_64
--> Processing Dependency: libipset.so.13(LIBIPSET_2.0)(64bit) for package: ipset-7.1-1.el7.x86_64
--> Processing Dependency: libipset.so.13()(64bit) for package: ipset-7.1-1.el7.x86_64
---> Package python-firewall.noarch 0:0.6.3-8.el7_8.1 will be installed
--> Processing Dependency: python-slip-dbus for package: python-firewall-0.6.3-8.el7_8.1.noarch
--> Processing Dependency: python-decorator for package: python-firewall-0.6.3-8.el7_8.1.noarch
--> Running transaction check
---> Package ipset-libs.x86_64 0:7.1-1.el7 will be installed
---> Package python-decorator.noarch 0:3.4.0-3.el7 will be installed
---> Package python-slip-dbus.noarch 0:0.4.0-4.el7 will be installed
--> Processing Dependency: python-slip = 0.4.0-4.el7 for package: python-slip-dbus-0.4.0-4.el7.noarch
--> Running transaction check
---> Package python-slip.noarch 0:0.4.0-4.el7 will be installed
--> Processing Dependency: libselinux-python for package: python-slip-0.4.0-4.el7.noarch
--> Running transaction check
---> Package libselinux-python.x86_64 0:2.5-15.el7 will be installed
--> Processing Dependency: libselinux(x86-64) = 2.5-15.el7 for package: libselinux-python-2.5-15.el7.x86_64
--> Running transaction check
---> Package libselinux.x86_64 0:2.5-14.1.el7 will be updated
---> Package libselinux.x86_64 0:2.5-15.el7 will be an update
--> Finished Dependency Resolution

Dependencies Resolved

=============================================================================================================================================================
 Package                                      Arch                           Version                       Repository                       Size
=============================================================================================================================================================
Installing:
 firewalld                                    noarch                         0.6.3-8.el7_8.1                       updates                         443 k
Installing for dependencies:
 ebtables                                     x86_64                         2.0.10-16.el7                       base                            123 k
 firewalld-filesystem                         noarch                         0.6.3-8.el7_8.1                       updates                          51 k
 ipset                                        x86_64                         7.1-1.el7                       base                             39 k
 ipset-libs                                   x86_64                         7.1-1.el7                       base                             64 k
 libselinux-python                            x86_64                         2.5-15.el7                       base                            236 k
 python-decorator                             noarch                         3.4.0-3.el7                       base                             27 k
 python-firewall                              noarch                         0.6.3-8.el7_8.1                       updates                         354 k
 python-slip                                  noarch                         0.4.0-4.el7                       base                             31 k
 python-slip-dbus                             noarch                         0.4.0-4.el7                       base                             32 k
Updating for dependencies:
 libselinux                                   x86_64                         2.5-15.el7                       base                            162 k

Transaction Summary
=============================================================================================================================================================
Install  1 Package  (+9 Dependent packages)
Upgrade             ( 1 Dependent package)

Total download size: 1.5 M
Downloading packages:
Delta RPMs disabled because /usr/bin/applydeltarpm not installed.
(1/11): ebtables-2.0.10-16.el7.x86_64.rpm                                      | 123 kB  00:00:00
(2/11): ipset-libs-7.1-1.el7.x86_64.rpm                                      |  64 kB  00:00:00
(3/11): ipset-7.1-1.el7.x86_64.rpm                                      |  39 kB  00:00:00
(4/11): libselinux-2.5-15.el7.x86_64.rpm                                      | 162 kB  00:00:00
(5/11): python-decorator-3.4.0-3.el7.noarch.rpm                                      |  27 kB  00:00:00
(6/11): firewalld-filesystem-0.6.3-8.el7_8.1.noarch.rpm                                      |  51 kB  00:00:00
(7/11): libselinux-python-2.5-15.el7.x86_64.rpm                                      | 236 kB  00:00:00
(8/11): python-slip-0.4.0-4.el7.noarch.rpm                                      |  31 kB  00:00:00
(9/11): firewalld-0.6.3-8.el7_8.1.noarch.rpm                                      | 443 kB  00:00:00
(10/11): python-slip-dbus-0.4.0-4.el7.noarch.rpm                                      |  32 kB  00:00:00
(11/11): python-firewall-0.6.3-8.el7_8.1.noarch.rpm                                      | 354 kB  00:00:00
-------------------------------------------------------------------------------------------------------------------------------------------------------------
Total                             7.0 MB/s | 1.5 MB  00:00:00
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : python-decorator-3.4.0-3.el7.noarch [  Installing : python-decorator-3.4.0-3.el7.noarch [####  Installing : python-decorator-3.4.0-3.el7.noarch [#####  Installing : python-decorator-3.4.0-3.el7.noarch [####################  Installing : python-decorator-3.4.0-3.el7.noarch [################################  Installing : python-decorator-3.4.0-3.el7.noarch [##########################################  Installing : python-decorator-3.4.0-3.el7.noarch [###########################################  Installing : python-decorator-3.4.0-3.el7.noarch [############################################  Installing : python-decorator-3.4.0-3.el7.noarch                                                        1/12
  Installing : ebtables-2.0.10-16.el7.x86_64 [  Installing : ebtables-2.0.10-16.el7.x86_64 [##  Installing : ebtables-2.0.10-16.el7.x86_64 [####  Installing : ebtables-2.0.10-16.el7.x86_64 [########  Installing : ebtables-2.0.10-16.el7.x86_64 [#############  Installing : ebtables-2.0.10-16.el7.x86_64 [################  Installing : ebtables-2.0.10-16.el7.x86_64 [###################  Installing : ebtables-2.0.10-16.el7.x86_64 [#######################  Installing : ebtables-2.0.10-16.el7.x86_64 [##########################  Installing : ebtables-2.0.10-16.el7.x86_64 [#############################  Installing : ebtables-2.0.10-16.el7.x86_64 [################################  Installing : ebtables-2.0.10-16.el7.x86_64 [###################################  Installing : ebtables-2.0.10-16.el7.x86_64 [######################################  Installing : ebtables-2.0.10-16.el7.x86_64 [#########################################  Installing : ebtables-2.0.10-16.el7.x86_64 [############################################  Installing : ebtables-2.0.10-16.el7.x86_64 [##############################################  Installing : ebtables-2.0.10-16.el7.x86_64 [################################################  Installing : ebtables-2.0.10-16.el7.x86_64 [##################################################  Installing : ebtables-2.0.10-16.el7.x86_64 [##################################################  Installing : ebtables-2.0.10-16.el7.x86_64 [##################################################  Installing : ebtables-2.0.10-16.el7.x86_64 [##################################################  Installing : ebtables-2.0.10-16.el7.x86_64 [##################################################  Installing : ebtables-2.0.10-16.el7.x86_64 [##################################################  Installing : ebtables-2.0.10-16.el7.x86_64 [##################################################  Installing : ebtables-2.0.10-16.el7.x86_64 [##################################################  Installing : ebtables-2.0.10-16.el7.x86_64 [##################################################  Installing : ebtables-2.0.10-16.el7.x86_64 [##################################################  Installing : ebtables-2.0.10-16.el7.x86_64 [##################################################  Installing : ebtables-2.0.10-16.el7.x86_64 [##################################################  Installing : ebtables-2.0.10-16.el7.x86_64 [##################################################  Installing : ebtables-2.0.10-16.el7.x86_64                                                        2/12
  Installing : ipset-libs-7.1-1.el7.x86_64 [  Installing : ipset-libs-7.1-1.el7.x86_64 [################################  Installing : ipset-libs-7.1-1.el7.x86_64 [####################################################  Installing : ipset-libs-7.1-1.el7.x86_64 [####################################################  Installing : ipset-libs-7.1-1.el7.x86_64 [####################################################  Installing : ipset-libs-7.1-1.el7.x86_64                                                        3/12
  Installing : ipset-7.1-1.el7.x86_64 [  Installing : ipset-7.1-1.el7.x86_64 [############  Installing : ipset-7.1-1.el7.x86_64 [#############  Installing : ipset-7.1-1.el7.x86_64 [############################################  Installing : ipset-7.1-1.el7.x86_64 [#########################################################  Installing : ipset-7.1-1.el7.x86_64                                                        4/12
  Installing : firewalld-filesystem-0.6.3-8.el7_8.1.noarch [  Installing : firewalld-filesystem-0.6.3-8.el7_8.1.noarch [########  Installing : firewalld-filesystem-0.6.3-8.el7_8.1.noarch [#################  Installing : firewalld-filesystem-0.6.3-8.el7_8.1.noarch [##########################  Installing : firewalld-filesystem-0.6.3-8.el7_8.1.noarch [####################################  Installing : firewalld-filesystem-0.6.3-8.el7_8.1.noarch [####################################  Installing : firewalld-filesystem-0.6.3-8.el7_8.1.noarch [####################################  Installing : firewalld-filesystem-0.6.3-8.el7_8.1.noarch [####################################  Installing : firewalld-filesystem-0.6.3-8.el7_8.1.noarch                                                        5/12
  Updating   : libselinux-2.5-15.el7.x86_64 [  Updating   : libselinux-2.5-15.el7.x86_64 [###############################  Updating   : libselinux-2.5-15.el7.x86_64 [###################################################  Updating   : libselinux-2.5-15.el7.x86_64 [###################################################  Updating   : libselinux-2.5-15.el7.x86_64 [###################################################  Updating   : libselinux-2.5-15.el7.x86_64                                                        6/12
  Installing : libselinux-python-2.5-15.el7.x86_64 [  Installing : libselinux-python-2.5-15.el7.x86_64 [#######  Installing : libselinux-python-2.5-15.el7.x86_64 [##################  Installing : libselinux-python-2.5-15.el7.x86_64 [#############################  Installing : libselinux-python-2.5-15.el7.x86_64 [#######################################  Installing : libselinux-python-2.5-15.el7.x86_64 [############################################  Installing : libselinux-python-2.5-15.el7.x86_64 [############################################  Installing : libselinux-python-2.5-15.el7.x86_64 [############################################  Installing : libselinux-python-2.5-15.el7.x86_64 [############################################  Installing : libselinux-python-2.5-15.el7.x86_64 [############################################  Installing : libselinux-python-2.5-15.el7.x86_64 [############################################  Installing : libselinux-python-2.5-15.el7.x86_64                                                        7/12
  Installing : python-slip-0.4.0-4.el7.noarch [  Installing : python-slip-0.4.0-4.el7.noarch [#  Installing : python-slip-0.4.0-4.el7.noarch [####  Installing : python-slip-0.4.0-4.el7.noarch [###############  Installing : python-slip-0.4.0-4.el7.noarch [#######################  Installing : python-slip-0.4.0-4.el7.noarch [################################  Installing : python-slip-0.4.0-4.el7.noarch [##########################################  Installing : python-slip-0.4.0-4.el7.noarch [###########################################  Installing : python-slip-0.4.0-4.el7.noarch [#################################################  Installing : python-slip-0.4.0-4.el7.noarch [#################################################  Installing : python-slip-0.4.0-4.el7.noarch [#################################################  Installing : python-slip-0.4.0-4.el7.noarch [#################################################  Installing : python-slip-0.4.0-4.el7.noarch [#################################################  Installing : python-slip-0.4.0-4.el7.noarch [#################################################  Installing : python-slip-0.4.0-4.el7.noarch [#################################################  Installing : python-slip-0.4.0-4.el7.noarch [#################################################  Installing : python-slip-0.4.0-4.el7.noarch [#################################################  Installing : python-slip-0.4.0-4.el7.noarch [#################################################  Installing : python-slip-0.4.0-4.el7.noarch [#################################################  Installing : python-slip-0.4.0-4.el7.noarch [#################################################  Installing : python-slip-0.4.0-4.el7.noarch [#################################################  Installing : python-slip-0.4.0-4.el7.noarch [#################################################  Installing : python-slip-0.4.0-4.el7.noarch [#################################################  Installing : python-slip-0.4.0-4.el7.noarch [#################################################  Installing : python-slip-0.4.0-4.el7.noarch                                                        8/12
  Installing : python-slip-dbus-0.4.0-4.el7.noarch [  Installing : python-slip-dbus-0.4.0-4.el7.noarch [#  Installing : python-slip-dbus-0.4.0-4.el7.noarch [####  Installing : python-slip-dbus-0.4.0-4.el7.noarch [########  Installing : python-slip-dbus-0.4.0-4.el7.noarch [############  Installing : python-slip-dbus-0.4.0-4.el7.noarch [#######################  Installing : python-slip-dbus-0.4.0-4.el7.noarch [##################################  Installing : python-slip-dbus-0.4.0-4.el7.noarch [############################################  Installing : python-slip-dbus-0.4.0-4.el7.noarch [############################################  Installing : python-slip-dbus-0.4.0-4.el7.noarch [############################################  Installing : python-slip-dbus-0.4.0-4.el7.noarch [############################################  Installing : python-slip-dbus-0.4.0-4.el7.noarch [############################################  Installing : python-slip-dbus-0.4.0-4.el7.noarch [############################################  Installing : python-slip-dbus-0.4.0-4.el7.noarch [############################################  Installing : python-slip-dbus-0.4.0-4.el7.noarch [############################################  Installing : python-slip-dbus-0.4.0-4.el7.noarch [############################################  Installing : python-slip-dbus-0.4.0-4.el7.noarch [############################################  Installing : python-slip-dbus-0.4.0-4.el7.noarch [############################################  Installing : python-slip-dbus-0.4.0-4.el7.noarch [############################################  Installing : python-slip-dbus-0.4.0-4.el7.noarch [############################################  Installing : python-slip-dbus-0.4.0-4.el7.noarch [############################################  Installing : python-slip-dbus-0.4.0-4.el7.noarch [############################################  Installing : python-slip-dbus-0.4.0-4.el7.noarch [############################################  Installing : python-slip-dbus-0.4.0-4.el7.noarch [############################################  Installing : python-slip-dbus-0.4.0-4.el7.noarch [############################################  Installing : python-slip-dbus-0.4.0-4.el7.noarch [############################################  Installing : python-slip-dbus-0.4.0-4.el7.noarch                                                        9/12
  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [##  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [####  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#####  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [######  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [########  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [##########  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [###########  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [############  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#############  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [##############  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [##################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [###################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [####################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#####################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [######################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#######################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [###########################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [############################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#############################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [##############################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [##################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [###################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [######################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#######################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch [#########################################  Installing : python-firewall-0.6.3-8.el7_8.1.noarch                                                       10/12
  Installing : firewalld-0.6.3-8.el7_8.1.noarch [  Installing : firewalld-0.6.3-8.el7_8.1.noarch [###  Installing : firewalld-0.6.3-8.el7_8.1.noarch [######  Installing : firewalld-0.6.3-8.el7_8.1.noarch [#########  Installing : firewalld-0.6.3-8.el7_8.1.noarch [###########  Installing : firewalld-0.6.3-8.el7_8.1.noarch [############  Installing : firewalld-0.6.3-8.el7_8.1.noarch [#############  Installing : firewalld-0.6.3-8.el7_8.1.noarch [##############  Installing : firewalld-0.6.3-8.el7_8.1.noarch [###############  Installing : firewalld-0.6.3-8.el7_8.1.noarch [################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [#################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [##################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [####################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [#######################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [##########################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [############################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [##############################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [##################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [###################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [####################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [######################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [#######################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [########################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [##########################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [###########################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [#############################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [###############################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [###############################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [###############################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [###############################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [###############################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [###############################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [###############################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [###############################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [###############################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [###############################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [###############################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [###############################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [###############################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [###############################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [###############################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [###############################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [###############################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [###############################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [###############################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [###############################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [###############################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [###############################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [###############################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [###############################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [###############################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [###############################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [###############################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch [###############################################  Installing : firewalld-0.6.3-8.el7_8.1.noarch                                                       11/12
  Cleanup    : libselinux-2.5-14.1.el7.x86_64                                                                                                          12/12
  Verifying  : ipset-7.1-1.el7.x86_64                                                                                                                   1/12
  Verifying  : python-firewall-0.6.3-8.el7_8.1.noarch                                                                                                   2/12
  Verifying  : firewalld-0.6.3-8.el7_8.1.noarch                                                                                                         3/12
  Verifying  : libselinux-2.5-15.el7.x86_64                                                                                                             4/12
  Verifying  : libselinux-python-2.5-15.el7.x86_64                                                                                                      5/12
  Verifying  : firewalld-filesystem-0.6.3-8.el7_8.1.noarch                                                                                              6/12
  Verifying  : python-slip-0.4.0-4.el7.noarch                                                                                                           7/12
  Verifying  : python-slip-dbus-0.4.0-4.el7.noarch                                                                                                      8/12
  Verifying  : python-decorator-3.4.0-3.el7.noarch                                                                                                      9/12
  Verifying  : ipset-libs-7.1-1.el7.x86_64                                                                                                             10/12
  Verifying  : ebtables-2.0.10-16.el7.x86_64                                                                                                           11/12
  Verifying  : libselinux-2.5-14.1.el7.x86_64                                                                                                          12/12

Installed:
  firewalld.noarch 0:0.6.3-8.el7_8.1

Dependency Installed:
  ebtables.x86_64 0:2.0.10-16.el7                    firewalld-filesystem.noarch 0:0.6.3-8.el7_8.1           ipset.x86_64 0:7.1-1.el7
  ipset-libs.x86_64 0:7.1-1.el7                      libselinux-python.x86_64 0:2.5-15.el7                   python-decorator.noarch 0:3.4.0-3.el7
  python-firewall.noarch 0:0.6.3-8.el7_8.1           python-slip.noarch 0:0.4.0-4.el7                        python-slip-dbus.noarch 0:0.4.0-4.el7

Dependency Updated:
  libselinux.x86_64 0:2.5-15.el7

Complete!
[root@stapp03 ~]#
[root@stapp03 ~]# systemctl start firewalld
[root@stapp03 ~]# systemctl enable firewalld
[root@stapp03 ~]# systemctl status firewalld
● firewalld.service - firewalld - dynamic firewall daemon
   Loaded: loaded (/usr/lib/systemd/system/firewalld.service; enabled; vendor preset: enabled)
   Active: inactive (dead) since Tue 2020-08-11 01:09:08 UTC; 59ms ago
     Docs: man:firewalld(1)
 Main PID: 473 (code=exited, status=0/SUCCESS)

Aug 11 01:09:08 stapp03 systemd[1]: Starting firewalld - dynamic firewall daemon...
Aug 11 01:09:08 stapp03 firewalld[473]: ERROR: Exception DBusException: org.freedesktop.DBus.Error.AccessDenied: Connection ":1.4" is not allowed...tion file
Aug 11 01:09:08 stapp03 systemd[1]: Started firewalld - dynamic firewall daemon.
Hint: Some lines were ellipsized, use -l to show in full.
[root@stapp03 ~]#
[root@stapp03 ~]#
[root@stapp03 ~]# cat /etc/nginx/nginx.conf | grep listen
        listen       8095 default_server;
#        listen       443 ssl http2 default_server;
#        listen       [::]:443 ssl http2 default_server;
[root@stapp03 ~]#
[root@stapp03 ~]# cat /etc/httpd/conf/httpd.conf | grep Listen
# Listen: Allows you to bind Apache to specific IP addresses and/or
# Change this to Listen on specific IP addresses as shown below to
#Listen 12.34.56.78:80
Listen 5003
[root@stapp03 ~]#
[root@stapp03 ~]#
[root@stapp03 ~]# sudo systemctl restart dbus
[root@stapp03 ~]#
[root@stapp03 ~]# sudo systemctl restart firewalld
[root@stapp03 ~]#
[root@stapp03 ~]# systemctl status firewalld
● firewalld.service - firewalld - dynamic firewall daemon
   Loaded: loaded (/usr/lib/systemd/system/firewalld.service; enabled; vendor preset: enabled)
   Active: active (running) since Tue 2020-08-11 01:09:43 UTC; 14ms ago
     Docs: man:firewalld(1)
 Main PID: 503 (firewalld)
   CGroup: /docker/a0992fdea4bd54267b626375bc3b618a412e2a9b1aa79dd378e32a9d4d0d8104/system.slice/firewalld.service
           ├─503 /usr/bin/python2 -Es /usr/sbin/firewalld --nofork --nopid
           └─504 /usr/bin/python2 -Es /usr/sbin/firewalld --nofork --nopid

Aug 11 01:09:43 stapp03 systemd[1]: Starting firewalld - dynamic firewall daemon...
Aug 11 01:09:43 stapp03 systemd[1]: Started firewalld - dynamic firewall daemon.
[root@stapp03 ~]#
[root@stapp03 ~]#
[root@stapp03 ~]#
[root@stapp03 ~]# firewall-cmd --permanent --zone=public --change-interface=eth0
success
[root@stapp03 ~]# firewall-cmd --permanent --zone=public --add-port=8095/tcp
success
[root@stapp03 ~]# firewall-cmd --permanent --zone=public --add-service=http
success
[root@stapp03 ~]# firewall-cmd --permanent --zone=public --add-service=https
success
[root@stapp03 ~]# firewall-cmd --permanent --zone=public \
> --add-rich-rule='rule family="ipv4" source address="172.16.238.14" port port="5003" protocol=tcp accept'
success
[root@stapp03 ~]#
[root@stapp03 ~]#
[root@stapp03 ~]# sudo firewall-cmd --reload
success
[root@stapp03 ~]#
[root@stapp03 ~]# systemctl restart firewalld

[root@stapp03 ~]#
[root@stapp03 ~]# systemctl status firewalld
● firewalld.service - firewalld - dynamic firewall daemon
   Loaded: loaded (/usr/lib/systemd/system/firewalld.service; enabled; vendor preset: enabled)
   Active: active (running) since Tue 2020-08-11 01:11:02 UTC; 16ms ago
     Docs: man:firewalld(1)
 Main PID: 612 (firewalld)
   CGroup: /docker/a0992fdea4bd54267b626375bc3b618a412e2a9b1aa79dd378e32a9d4d0d8104/system.slice/firewalld.service
           ├─612 /usr/bin/python2 -Es /usr/sbin/firewalld --nofork --nopid
           └─614 /usr/bin/python2 -Es /usr/sbin/firewalld --nofork --nopid

Aug 11 01:11:01 stapp03 systemd[1]: Starting firewalld - dynamic firewall daemon...
Aug 11 01:11:02 stapp03 systemd[1]: Started firewalld - dynamic firewall daemon.
[root@stapp03 ~]#
[root@stapp03 ~]#
[root@stapp03 ~]# curl localhost:8091
curl: (7) Failed to connect to ::1: Cannot assign requested address
[root@stapp03 ~]#
[root@stapp03 ~]#
[root@stapp03 ~]# curl stapp01:8095
<html>
<head><title>403 Forbidden</title></head>
<body>
<center><h1>403 Forbidden</h1></center>
<hr><center>nginx/1.16.1</center>
</body>
</html>
[root@stapp03 ~]# curl stapp02:8095
<html>
<head><title>403 Forbidden</title></head>
<body>
<center><h1>403 Forbidden</h1></center>
<hr><center>nginx/1.16.1</center>
</body>
</html>
[root@stapp03 ~]# curl stapp03:8095
<html>
<head><title>403 Forbidden</title></head>
<body>
<center><h1>403 Forbidden</h1></center>
<hr><center>nginx/1.16.1</center>
</body>
</html>
[root@stapp03 ~]#
[root@stapp03 ~]# curl localhost:8095
<html>
<head><title>403 Forbidden</title></head>
<body>
<center><h1>403 Forbidden</h1></center>
<hr><center>nginx/1.16.1</center>
</body>
</html>
[root@stapp03 ~]#
[root@stapp03 ~]# Connection to host01 closed by remote host.
Connection to host01 closed.

The environment has expired.

Please refresh to get a new environment.