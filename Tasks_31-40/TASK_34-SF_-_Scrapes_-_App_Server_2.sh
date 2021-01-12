
-----------------------------------------------------------------------------------------------------------------

# SUPPORTING FILE 

# This is a supporting file for the Task of the same name.
# This may contain configurations/config file.
# Basically, any file that is edited/created/modified through the 'vi' or 'nano' command will appear here.
# Note that there may be more than one supporting files for the Task at hand.

-----------------------------------------------------------------------------------------------------------------

TASK 34 - Install and Configure NFS Server


thor@jump_host /$
thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
Warning: Permanently added '172.16.238.11' (ECDSA) to the list of known hosts.
sudo su -
******[steve@stapp02 ~]$ sudo su -

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for steve:
[root@stapp02 ~]#
[root@stapp02 ~]#
[root@stapp02 ~]# sudo yum install -y nfs-utils nfs-utils-lib
Loaded plugins: fastestmirror, ovl
Determining fastest mirrors
 * base: mirror.softaculous.com
 * extras: mirror.ratiokontakt.de
 * updates: mirror.23media.com
base                                                                                                                                  | 3.6 kB  00:00:00
extras                                                                                                                                | 2.9 kB  00:00:00
updates                                                                                                                               | 2.9 kB  00:00:00
(1/4): base/7/x86_64/group_gz                                                                                                         | 153 kB  00:00:00
(2/4): extras/7/x86_64/primary_db                                                                                                     | 206 kB  00:00:00
(3/4): base/7/x86_64/primary_db                                                                                                       | 6.1 MB  00:00:00
(4/4): updates/7/x86_64/primary_db                                                                                                    | 4.5 MB  00:00:00
No package nfs-utils-lib available.
Resolving Dependencies
--> Running transaction check
---> Package nfs-utils.x86_64 1:1.3.0-0.66.el7_8 will be installed
--> Processing Dependency: libtirpc >= 0.2.4-0.7 for package: 1:nfs-utils-1.3.0-0.66.el7_8.x86_64
--> Processing Dependency: gssproxy >= 0.7.0-3 for package: 1:nfs-utils-1.3.0-0.66.el7_8.x86_64
--> Processing Dependency: rpcbind for package: 1:nfs-utils-1.3.0-0.66.el7_8.x86_64
--> Processing Dependency: quota for package: 1:nfs-utils-1.3.0-0.66.el7_8.x86_64
--> Processing Dependency: libnfsidmap for package: 1:nfs-utils-1.3.0-0.66.el7_8.x86_64
--> Processing Dependency: libevent for package: 1:nfs-utils-1.3.0-0.66.el7_8.x86_64
--> Processing Dependency: keyutils for package: 1:nfs-utils-1.3.0-0.66.el7_8.x86_64
--> Processing Dependency: libtirpc.so.1()(64bit) for package: 1:nfs-utils-1.3.0-0.66.el7_8.x86_64
--> Processing Dependency: libnfsidmap.so.0()(64bit) for package: 1:nfs-utils-1.3.0-0.66.el7_8.x86_64
--> Processing Dependency: libevent-2.0.so.5()(64bit) for package: 1:nfs-utils-1.3.0-0.66.el7_8.x86_64
--> Running transaction check
---> Package gssproxy.x86_64 0:0.7.0-28.el7 will be installed
--> Processing Dependency: libini_config >= 1.3.1-31 for package: gssproxy-0.7.0-28.el7.x86_64
--> Processing Dependency: libverto-module-base for package: gssproxy-0.7.0-28.el7.x86_64
--> Processing Dependency: libref_array.so.1(REF_ARRAY_0.1.1)(64bit) for package: gssproxy-0.7.0-28.el7.x86_64
--> Processing Dependency: libini_config.so.3(INI_CONFIG_1.2.0)(64bit) for package: gssproxy-0.7.0-28.el7.x86_64
--> Processing Dependency: libini_config.so.3(INI_CONFIG_1.1.0)(64bit) for package: gssproxy-0.7.0-28.el7.x86_64
--> Processing Dependency: libref_array.so.1()(64bit) for package: gssproxy-0.7.0-28.el7.x86_64
--> Processing Dependency: libini_config.so.3()(64bit) for package: gssproxy-0.7.0-28.el7.x86_64
--> Processing Dependency: libcollection.so.2()(64bit) for package: gssproxy-0.7.0-28.el7.x86_64
--> Processing Dependency: libbasicobjects.so.0()(64bit) for package: gssproxy-0.7.0-28.el7.x86_64
---> Package keyutils.x86_64 0:1.5.8-3.el7 will be installed
---> Package libevent.x86_64 0:2.0.21-4.el7 will be installed
---> Package libnfsidmap.x86_64 0:0.25-19.el7 will be installed
---> Package libtirpc.x86_64 0:0.2.4-0.16.el7 will be installed
---> Package quota.x86_64 1:4.01-19.el7 will be installed
--> Processing Dependency: quota-nls = 1:4.01-19.el7 for package: 1:quota-4.01-19.el7.x86_64
--> Processing Dependency: tcp_wrappers for package: 1:quota-4.01-19.el7.x86_64
--> Processing Dependency: libext2fs.so.2()(64bit) for package: 1:quota-4.01-19.el7.x86_64
---> Package rpcbind.x86_64 0:0.2.0-49.el7 will be installed
--> Processing Dependency: systemd-sysv for package: rpcbind-0.2.0-49.el7.x86_64
--> Running transaction check
---> Package e2fsprogs-libs.x86_64 0:1.42.9-17.el7 will be installed
--> Processing Dependency: libcom_err(x86-64) = 1.42.9-17.el7 for package: e2fsprogs-libs-1.42.9-17.el7.x86_64
---> Package libbasicobjects.x86_64 0:0.1.1-32.el7 will be installed
---> Package libcollection.x86_64 0:0.7.0-32.el7 will be installed
---> Package libini_config.x86_64 0:1.3.1-32.el7 will be installed
--> Processing Dependency: libpath_utils.so.1(PATH_UTILS_0.2.1)(64bit) for package: libini_config-1.3.1-32.el7.x86_64
--> Processing Dependency: libpath_utils.so.1()(64bit) for package: libini_config-1.3.1-32.el7.x86_64
---> Package libref_array.x86_64 0:0.1.5-32.el7 will be installed
---> Package libverto-libevent.x86_64 0:0.2.5-4.el7 will be installed
---> Package quota-nls.noarch 1:4.01-19.el7 will be installed
---> Package systemd-sysv.x86_64 0:219-73.el7_8.9 will be installed
--> Processing Dependency: systemd = 219-73.el7_8.9 for package: systemd-sysv-219-73.el7_8.9.x86_64
---> Package tcp_wrappers.x86_64 0:7.6-77.el7 will be installed
--> Running transaction check
---> Package libcom_err.x86_64 0:1.42.9-13.el7 will be updated
---> Package libcom_err.x86_64 0:1.42.9-17.el7 will be an update
---> Package libpath_utils.x86_64 0:0.2.1-32.el7 will be installed
---> Package systemd.x86_64 0:219-62.el7_6.9 will be updated
---> Package systemd.x86_64 0:219-73.el7_8.9 will be an update
--> Processing Dependency: systemd-libs = 219-73.el7_8.9 for package: systemd-219-73.el7_8.9.x86_64
--> Running transaction check
---> Package systemd-libs.x86_64 0:219-62.el7_6.9 will be updated
---> Package systemd-libs.x86_64 0:219-73.el7_8.9 will be an update
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================================
 Package                    Arch            Version                      Repository        Size
================================================================================================
Installing:
 nfs-utils                  x86_64          1:1.3.0-0.66.el7_8           updates          412 k
Installing for dependencies:
 e2fsprogs-libs             x86_64          1.42.9-17.el7                base             168 k
 gssproxy                   x86_64          0.7.0-28.el7                 base             110 k
 keyutils                   x86_64          1.5.8-3.el7                  base              54 k
 libbasicobjects            x86_64          0.1.1-32.el7                 base              26 k
 libcollection              x86_64          0.7.0-32.el7                 base              42 k
 libevent                   x86_64          2.0.21-4.el7                 base             214 k
 libini_config              x86_64          1.3.1-32.el7                 base              64 k
 libnfsidmap                x86_64          0.25-19.el7                  base              50 k
 libpath_utils              x86_64          0.2.1-32.el7                 base              28 k
 libref_array               x86_64          0.1.5-32.el7                 base              27 k
 libtirpc                   x86_64          0.2.4-0.16.el7               base              89 k
 libverto-libevent          x86_64          0.2.5-4.el7                  base             8.9 k
 quota                      x86_64          1:4.01-19.el7                base             179 k
 quota-nls                  noarch          1:4.01-19.el7                base              90 k
 rpcbind                    x86_64          0.2.0-49.el7                 base              60 k
 systemd-sysv               x86_64          219-73.el7_8.9               updates           94 k
 tcp_wrappers               x86_64          7.6-77.el7                   base              78 k
Updating for dependencies:
 libcom_err                 x86_64          1.42.9-17.el7                base              42 k
 systemd                    x86_64          219-73.el7_8.9               updates          5.1 M
 systemd-libs               x86_64          219-73.el7_8.9               updates          416 k

Transaction Summary
================================================================================================
Install  1 Package  (+17 Dependent packages)
Upgrade             (  3 Dependent packages)

Total download size: 7.3 M
Downloading packages:
Delta RPMs disabled because /usr/bin/applydeltarpm not installed.
(1/21): gssproxy-0.7.0-28.el7.x86_64.rpm                                 | 110 kB  00:00:00
(2/21): keyutils-1.5.8-3.el7.x86_64.rpm                                  |  54 kB  00:00:00
(3/21): libbasicobjects-0.1.1-32.el7.x86_64.rpm                          |  26 kB  00:00:00
(4/21): libcollection-0.7.0-32.el7.x86_64.rpm                            |  42 kB  00:00:00
(5/21): e2fsprogs-libs-1.42.9-17.el7.x86_64.rpm                          | 168 kB  00:00:00
(6/21): libcom_err-1.42.9-17.el7.x86_64.rpm                              |  42 kB  00:00:00
(7/21): libevent-2.0.21-4.el7.x86_64.rpm                                 | 214 kB  00:00:00
(8/21): libini_config-1.3.1-32.el7.x86_64.rpm                            |  64 kB  00:00:00
(9/21): libnfsidmap-0.25-19.el7.x86_64.rpm                               |  50 kB  00:00:00
(10/21): libpath_utils-0.2.1-32.el7.x86_64.rpm                           |  28 kB  00:00:00
(11/21): libref_array-0.1.5-32.el7.x86_64.rpm                            |  27 kB  00:00:00
(12/21): libtirpc-0.2.4-0.16.el7.x86_64.rpm                              |  89 kB  00:00:00
(13/21): libverto-libevent-0.2.5-4.el7.x86_64.rpm                        | 8.9 kB  00:00:00
(14/21): quota-4.01-19.el7.x86_64.rpm                                    | 179 kB  00:00:00
(15/21): rpcbind-0.2.0-49.el7.x86_64.rpm                                 |  60 kB  00:00:00
(16/21): quota-nls-4.01-19.el7.noarch.rpm                                |  90 kB  00:00:00
(17/21): nfs-utils-1.3.0-0.66.el7_8.x86_64.rpm                           | 412 kB  00:00:00
(18/21): systemd-libs-219-73.el7_8.9.x86_64.rpm                          | 416 kB  00:00:00
(19/21): systemd-sysv-219-73.el7_8.9.x86_64.rpm                          |  94 kB  00:00:00
(20/21): tcp_wrappers-7.6-77.el7.x86_64.rpm                              |  78 kB  00:00:00
(21/21): systemd-219-73.el7_8.9.x86_64.rpm                               | 5.1 MB  00:00:00
------------------------------------------------------------------------------------------------
Total                                                           9.1 MB/s | 7.3 MB  00:00:00
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Updating   : libcom_err-1.42.9-17.el7.x86_64                                             1/24
  Installing : libtirpc-0.2.4-0.16.el7.x86_64                                              2/24
  Installing : libref_array-0.1.5-32.el7.x86_64                                            3/24
  Installing : libcollection-0.7.0-32.el7.x86_64                                           4/24
  Updating   : systemd-libs-219-73.el7_8.9.x86_64                                          5/24
  Updating   : systemd-219-73.el7_8.9.x86_64                                                                                                            6/24
  Installing : libevent-2.0.21-4.el7.x86_64                                                                                                             7/24
  Installing : libbasicobjects-0.1.1-32.el7.x86_64                                                                                                      8/24
  Installing : libverto-libevent-0.2.5-4.el7.x86_64                                                                                                     9/24
  Installing : systemd-sysv-219-73.el7_8.9.x86_64                                                                                                      10/24
  Installing : rpcbind-0.2.0-49.el7.x86_64                                                                                                             11/24
  Installing : e2fsprogs-libs-1.42.9-17.el7.x86_64                                                                                                     12/24
  Installing : 1:quota-nls-4.01-19.el7.noarch                                                                                                          13/24
  Installing : tcp_wrappers-7.6-77.el7.x86_64                                                                                                          14/24
  Installing : 1:quota-4.01-19.el7.x86_64                                                                                                              15/24
  Installing : keyutils-1.5.8-3.el7.x86_64                                                                                                             16/24
  Installing : libnfsidmap-0.25-19.el7.x86_64                                                                                                          17/24
  Installing : libpath_utils-0.2.1-32.el7.x86_64                                                                                                       18/24
  Installing : libini_config-1.3.1-32.el7.x86_64                                                                                                       19/24
  Installing : gssproxy-0.7.0-28.el7.x86_64                                                                                                            20/24
  Installing : 1:nfs-utils-1.3.0-0.66.el7_8.x86_64                                                                                                     21/24
  Cleanup    : systemd-219-62.el7_6.9.x86_64                                                                                                           22/24
  Cleanup    : systemd-libs-219-62.el7_6.9.x86_64                                                                                                      23/24
  Cleanup    : libcom_err-1.42.9-13.el7.x86_64                                                                                                         24/24
  Verifying  : libtirpc-0.2.4-0.16.el7.x86_64                                                                                                           1/24
  Verifying  : systemd-sysv-219-73.el7_8.9.x86_64                                                                                                       2/24
  Verifying  : e2fsprogs-libs-1.42.9-17.el7.x86_64                                                                                                      3/24
  Verifying  : libcom_err-1.42.9-17.el7.x86_64                                                                                                          4/24
  Verifying  : gssproxy-0.7.0-28.el7.x86_64                                                                                                             5/24
  Verifying  : libbasicobjects-0.1.1-32.el7.x86_64                                                                                                      6/24
  Verifying  : rpcbind-0.2.0-49.el7.x86_64                                                                                                              7/24
  Verifying  : libini_config-1.3.1-32.el7.x86_64                                                                                                        8/24
  Verifying  : libevent-2.0.21-4.el7.x86_64                                                                                                             9/24
  Verifying  : systemd-libs-219-73.el7_8.9.x86_64                                                                                                      10/24
  Verifying  : libverto-libevent-0.2.5-4.el7.x86_64                                                                                                    11/24
  Verifying  : libcollection-0.7.0-32.el7.x86_64                                                                                                       12/24
  Verifying  : libref_array-0.1.5-32.el7.x86_64                                                                                                        13/24
  Verifying  : systemd-219-73.el7_8.9.x86_64                                                                                                           14/24
  Verifying  : libpath_utils-0.2.1-32.el7.x86_64                                                                                                       15/24
  Verifying  : 1:quota-4.01-19.el7.x86_64                                                                                                              16/24
  Verifying  : libnfsidmap-0.25-19.el7.x86_64                                                                                                          17/24
  Verifying  : keyutils-1.5.8-3.el7.x86_64                                                                                                             18/24
  Verifying  : tcp_wrappers-7.6-77.el7.x86_64                                                                                                          19/24
  Verifying  : 1:nfs-utils-1.3.0-0.66.el7_8.x86_64                                                                                                     20/24
  Verifying  : 1:quota-nls-4.01-19.el7.noarch                                                                                                          21/24
  Verifying  : systemd-219-62.el7_6.9.x86_64                                                                                                           22/24
  Verifying  : systemd-libs-219-62.el7_6.9.x86_64                                                                                                      23/24
  Verifying  : libcom_err-1.42.9-13.el7.x86_64                                                                                                         24/24

Installed:
  nfs-utils.x86_64 1:1.3.0-0.66.el7_8

Dependency Installed:
  e2fsprogs-libs.x86_64 0:1.42.9-17.el7   gssproxy.x86_64 0:0.7.0-28.el7       keyutils.x86_64 0:1.5.8-3.el7         libbasicobjects.x86_64 0:0.1.1-32.el7
  libcollection.x86_64 0:0.7.0-32.el7     libevent.x86_64 0:2.0.21-4.el7       libini_config.x86_64 0:1.3.1-32.el7   libnfsidmap.x86_64 0:0.25-19.el7
  libpath_utils.x86_64 0:0.2.1-32.el7     libref_array.x86_64 0:0.1.5-32.el7   libtirpc.x86_64 0:0.2.4-0.16.el7      libverto-libevent.x86_64 0:0.2.5-4.el7
  quota.x86_64 1:4.01-19.el7              quota-nls.noarch 1:4.01-19.el7       rpcbind.x86_64 0:0.2.0-49.el7         systemd-sysv.x86_64 0:219-73.el7_8.9
  tcp_wrappers.x86_64 0:7.6-77.el7

Dependency Updated:
  libcom_err.x86_64 0:1.42.9-17.el7                  systemd.x86_64 0:219-73.el7_8.9                  systemd-libs.x86_64 0:219-73.el7_8.9

Complete!
[root@stapp02 ~]#
[root@stapp02 ~]# systemctl enable nfs
Created symlink from /etc/systemd/system/multi-user.target.wants/nfs-server.service to /usr/lib/systemd/system/nfs-server.service.
[root@stapp02 ~]# systemctl start nfs
[root@stapp02 ~]# systemctl status nfs
● nfs-server.service - NFS server and services
   Loaded: loaded (/usr/lib/systemd/system/nfs-server.service; enabled; vendor preset: disabled)
   Active: active (exited) since Sat 2020-09-05 14:19:54 UTC; 12ms ago
  Process: 450 ExecStartPost=/bin/sh -c if systemctl -q is-active gssproxy; then systemctl reload gssproxy ; fi (code=exited, status=0/SUCCESS)
  Process: 449 ExecStart=/usr/sbin/rpc.nfsd $RPCNFSDARGS (code=exited, status=0/SUCCESS)
  Process: 448 ExecStartPre=/usr/sbin/exportfs -r (code=exited, status=0/SUCCESS)
 Main PID: 449 (code=exited, status=0/SUCCESS)
   CGroup: /docker/f2a08070978ec83eaf41db224312ac19a7c713cc98cceb26a90a4950bffc78ff/system.slice/nfs-server.service

Sep 05 14:19:54 stapp02 systemd[1]: Starting NFS server and services...
Sep 05 14:19:54 stapp02 systemd[1]: Started NFS server and services.
[root@stapp02 ~]#
[root@stapp02 ~]# sudo mkdir -p /var/www/app
[root@stapp02 ~]# ls -l /var/www
total 4
drwxr-xr-x 2 root root 4096 Sep  5 14:21 app
[root@stapp02 ~]# showmount -e 172.16.238.15
Export list for 172.16.238.15:
/code 172.16.238.12,172.16.238.11,172.16.238.10
[root@stapp02 ~]# sudo mount -t nfs 172.16.238.15:/code /var/www/app
[root@stapp02 ~]# mount | grep nfs
nfsd on /proc/fs/nfsd type nfsd (rw,relatime)
sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw,relatime)
172.16.238.15:/code on /var/www/app type nfs (rw,relatime,vers=3,rsize=262144,wsize=262144,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=172.16.238.15,mountvers=3,mountport=20048,mountproto=udp,local_lock=none,addr=172.16.238.15)
[root@stapp02 ~]#
[root@stapp02 ~]# ls -l /var/www/app
total 0
[root@stapp02 ~]# ls -l /var/www/app
total 0
-rw-r--r-- 1 steve steve 0 Sep  5 14:22 index.html
[root@stapp02 ~]#
The environment has expired.

Please refresh to get a new environment.