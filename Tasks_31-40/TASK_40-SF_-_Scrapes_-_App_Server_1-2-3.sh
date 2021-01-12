
-----------------------------------------------------------------------------------------------------------------

# SUPPORTING FILE 

# This is a supporting file for the Task of the same name.
# This may contain configurations/config file.
# Basically, any file that is edited/created/modified through the 'vi' or 'nano' command will appear here.
# Note that there may be more than one supporting files for the Task at hand.

-----------------------------------------------------------------------------------------------------------------

TASK 40 - SupportFile - IPtables Installation And Configuration


thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
Warning: Permanently added '172.16.238.10' (ECDSA) to the list of known hosts.
sudo su -
******[tony@stapp01 ~]$ sudo su -

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for tony:
[root@stapp01 ~]#
[root@stapp01 ~]# sudo yum install -y iptables-services
Loaded plugins: fastestmirror, ovl
Determining fastest mirrors

epel/x86_64/metalink                                                                |  17 kB  00:00:00
 * base: mirror.checkdomain.de
 * epel: ftp.plusline.net
 * extras: mirror.ratiokontakt.de
 * remi-php72: remi.mirror.karneval.cz
 * remi-safe: remi.mirror.karneval.cz
 * updates: mirror.plustech.de
base                                                                                | 3.6 kB  00:00:00
epel                                                                                | 4.7 kB  00:00:00
extras                                                                              | 2.9 kB  00:00:00
remi-php72                                                                          | 3.0 kB  00:00:00
remi-safe                                                                           | 3.0 kB  00:00:00
updates                                                                             | 2.9 kB  00:00:00
(1/9): base/7/x86_64/group_gz                                                       | 153 kB  00:00:00
(2/9): base/7/x86_64/primary_db                                                     | 6.1 MB  00:00:00
(3/9): epel/x86_64/updateinfo                                                       | 1.0 MB  00:00:00
(4/9): extras/7/x86_64/primary_db                                                   | 206 kB  00:00:00
(5/9): epel/x86_64/group_gz                                                         |  95 kB  00:00:00
(6/9): remi-php72/primary_db                                                        | 239 kB  00:00:01
(7/9): remi-safe/primary_db                                                         | 1.8 MB  00:00:01
(8/9): epel/x86_64/primary_db                                                       | 6.9 MB  00:00:02
(9/9): updates/7/x86_64/primary_db                                                  | 4.5 MB  00:00:02
Resolving Dependencies
--> Running transaction check
---> Package iptables-services.x86_64 0:1.4.21-34.el7 will be installed
--> Processing Dependency: iptables = 1.4.21-34.el7 for package: iptables-services-1.4.21-34.el7.x86_64
--> Running transaction check
---> Package iptables.x86_64 0:1.4.21-33.el7 will be updated
---> Package iptables.x86_64 0:1.4.21-34.el7 will be an update
--> Finished Dependency Resolution

Dependencies Resolved

===========================================================================================================
 Package                         Arch                 Version                     Repository          Size
===========================================================================================================
Installing:
 iptables-services               x86_64               1.4.21-34.el7               base                52 k
Updating for dependencies:
 iptables                        x86_64               1.4.21-34.el7               base               432 k

Transaction Summary
===========================================================================================================
Install  1 Package
Upgrade             ( 1 Dependent package)

Total download size: 485 k
Downloading packages:
Delta RPMs disabled because /usr/bin/applydeltarpm not installed.
(1/2): iptables-1.4.21-34.el7.x86_64.rpm                                            | 432 kB  00:00:00
(2/2): iptables-services-1.4.21-34.el7.x86_64.rpm                                   |  52 kB  00:00:00
-----------------------------------------------------------------------------------------------------------
Total                                                                      4.4 MB/s | 485 kB  00:00:00
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Updating   : iptables-1.4.21-34.el7.x86_64                                                           1/3
  Installing : iptables-services-1.4.21-34.el7.x86_64                                                  2/3
  Cleanup    : iptables-1.4.21-33.el7.x86_64                                                           3/3
  Verifying  : iptables-services-1.4.21-34.el7.x86_64                                                  1/3
  Verifying  : iptables-1.4.21-34.el7.x86_64                                                           2/3
  Verifying  : iptables-1.4.21-33.el7.x86_64                                                           3/3

Installed:
  iptables-services.x86_64 0:1.4.21-34.el7

Dependency Updated:
  iptables.x86_64 0:1.4.21-34.el7

Complete!
[root@stapp01 ~]#
[root@stapp01 ~]# systemctl enable iptables
Created symlink from /etc/systemd/system/basic.target.wants/iptables.service to /usr/lib/systemd/system/iptables.service.
[root@stapp01 ~]# systemctl start iptables
[root@stapp01 ~]# systemctl status iptables
● iptables.service - IPv4 firewall with iptables
   Loaded: loaded (/usr/lib/systemd/system/iptables.service; enabled; vendor preset: disabled)
   Active: active (exited) since Sun 2020-09-13 13:14:40 UTC; 15ms ago
  Process: 447 ExecStart=/usr/libexec/iptables/iptables.init start (code=exited, status=0/SUCCESS)
 Main PID: 447 (code=exited, status=0/SUCCESS)

Sep 13 13:14:40 stapp01 systemd[1]: Starting IPv4 firewall with iptables...
Sep 13 13:14:40 stapp01 iptables.init[447]: iptables: Applying firewall rules: [  OK  ]
Sep 13 13:14:40 stapp01 systemd[1]: Started IPv4 firewall with iptables.
[root@stapp01 ~]#
[root@stapp01 ~]# iptables -R INPUT 5 -p tcp --destination-port 5004 -s 172.16.238.14 -j ACCEPT
[root@stapp01 ~]# iptables -A INPUT -p tcp --destination-port 5004 -j DROP
[root@stapp01 ~]# service iptables save
iptables: Saving firewall rules to /etc/sysconfig/iptables:[  OK  ]
[root@stapp01 ~]#
[root@stapp01 ~]# rpm -qc iptables-services
/etc/sysconfig/ip6tables
/etc/sysconfig/iptables
[root@stapp01 ~]#
[root@stapp01 ~]# sudo /sbin/iptables-save
# Generated by iptables-save v1.4.21 on Sun Sep 13 13:14:54 2020
*nat
:PREROUTING ACCEPT [13:1258]
:INPUT ACCEPT [3:180]
:OUTPUT ACCEPT [306:19262]
:POSTROUTING ACCEPT [453:28934]
:DOCKER_OUTPUT - [0:0]
:DOCKER_POSTROUTING - [0:0]
-A OUTPUT -d 127.0.0.11/32 -j DOCKER_OUTPUT
-A POSTROUTING -d 127.0.0.11/32 -j DOCKER_POSTROUTING
-A DOCKER_OUTPUT -d 127.0.0.11/32 -p tcp -m tcp --dport 53 -j DNAT --to-destination 127.0.0.11:39117
-A DOCKER_OUTPUT -d 127.0.0.11/32 -p udp -m udp --dport 53 -j DNAT --to-destination 127.0.0.11:46635
-A DOCKER_POSTROUTING -s 127.0.0.11/32 -p tcp -m tcp --sport 39117 -j SNAT --to-source :53
-A DOCKER_POSTROUTING -s 127.0.0.11/32 -p udp -m udp --sport 46635 -j SNAT --to-source :53
COMMIT
# Completed on Sun Sep 13 13:14:54 2020
# Generated by iptables-save v1.4.21 on Sun Sep 13 13:14:54 2020
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [67:7104]
-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
-A INPUT -p icmp -j ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT
-A INPUT -s 172.16.238.14/32 -p tcp -m tcp --dport 5004 -j ACCEPT
-A INPUT -p tcp -m tcp --dport 5004 -j DROP
-A FORWARD -j REJECT --reject-with icmp-host-prohibited
COMMIT
# Completed on Sun Sep 13 13:14:54 2020
[root@stapp01 ~]#
[root@stapp01 ~]# iptables -L
Chain INPUT (policy ACCEPT)
target     prot opt source               destination
ACCEPT     all  --  anywhere             anywhere             state RELATED,ESTABLISHED
ACCEPT     icmp --  anywhere             anywhere
ACCEPT     all  --  anywhere             anywhere
ACCEPT     tcp  --  anywhere             anywhere             state NEW tcp dpt:ssh
ACCEPT     tcp  --  stlb01               anywhere             tcp dpt:avt-profile-1
DROP       tcp  --  anywhere             anywhere             tcp dpt:avt-profile-1

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination
REJECT     all  --  anywhere             anywhere             reject-with icmp-host-prohibited

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination
[root@stapp01 ~]#
[root@stapp01 ~]#
[root@stapp01 ~]# service iptables save
iptables: Saving firewall rules to /etc/sysconfig/iptables:[  OK  ]
[root@stapp01 ~]#
[root@stapp01 ~]# Connection to host01 closed by remote host.
Connection to host01 closed.

The environment has expired.

Please refresh to get a new environment.