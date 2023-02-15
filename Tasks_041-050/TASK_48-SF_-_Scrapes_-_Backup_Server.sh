

-----------------------------------------------------------------------------------------------------------------

# SUPPORTING FILE 

# This is a supporting file for the Task of the same name.
# This may contain configurations/config file.
# Basically, any file that is edited/created/modified through the 'vi' or 'nano' command will appear here.
# Note that there may be more than one supporting files for the Task at hand.

-----------------------------------------------------------------------------------------------------------------

TASK 48 - SF - Scrapes - Backup Server.sh


thor@jump_host /$ sshpass -p '******' ssh -o StrictHostKeyChecking=no  clint@172.16.238.16Warning: Permanently added '172.16.238.16' (ECDSA) to the list of known hosts.
sudo su -
******
[clint@stbkp01 ~]$ sudo su -

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for clint:
[root@stbkp01 ~]#[root@stbkp01 ~]# ll /packages/downloaded_rpms/
total 53084
-rw-r--r-- 3 root root   105968 Aug 22  2019 apr-1.4.8-5.el7.x86_64.rpm
-rw-r--r-- 3 root root    94132 Jul  4  2014 apr-util-1.5.2-6.el7.x86_64.rpm
.
.
.
-rw-r--r-- 3 root root   560272 May 16  2019 wget-1.14-18.el7_6.1.x86_64.rpm
-rw-r--r-- 3 root root    41716 Jul  4  2014 which-2.20-7.el7.x86_64.rpm
[root@stbkp01 ~]# ll /etc
total 1140
-rw-r--r-- 26 root root     12 Aug  8  2019 adjtime
-rw-r--r-- 34 root root     16 Aug  1  2019 adjtime.rpmsave
.
.
.
drwxr-xr-x  2 root root   4096 Apr 11  2018 xinetd.d
drwxr-xr-x  6 root root   4096 Aug  1  2019 yum
-rw-r--r-- 34 root root   1019 Aug  1  2019 yum.conf
drwxr-xr-x  2 root root   4096 Jan 28  2020 yum.repos.d
[root@stbkp01 ~]#
[root@stbkp01 ~]# cd /etc/yum.repos.d/
[root@stbkp01 yum.repos.d]# ll
total 0
[root@stbkp01 yum.repos.d]# cat > yum_local.repo

[yum_local]
name=yum_local
baseurl=file:///packages/downloaded_rpms/
gpgcheck=0
enabled=1

[root@stbkp01 yum.repos.d]#
[root@stbkp01 yum.repos.d]# cat yum_local.repo

[yum_local]
name=yum_local
baseurl=file:///packages/downloaded_rpms/
gpgcheck=0
enabled=1

[root@stbkp01 yum.repos.d]# sudo yum clean all
Loaded plugins: fastestmirror, ovl
Cleaning repos: yum_local
Cleaning up list of fastest mirrors
Other repos take up 73 M of disk space (use --verbose for details)
[root@stbkp01 yum.repos.d]# sudo yum update
Loaded plugins: fastestmirror, ovl
Determining fastest mirrors
yum_local                                                                | 2.9 kB  00:00:00
yum_local/primary_db                                                     |  57 kB  00:00:00
No packages marked for update
[root@stbkp01 yum.repos.d]# sudo yum repolist
Loaded plugins: fastestmirror, ovl
Loading mirror speeds from cached hostfile
repo id                                      repo name                                    status
yum_local                                    yum_local                                    55
repolist: 55
[root@stbkp01 yum.repos.d]#
[root@stbkp01 yum.repos.d]#
[root@stbkp01 yum.repos.d]# sudo yum install -y --enablerepo="yum_local" samba
Loaded plugins: fastestmirror, ovl
Loading mirror speeds from cached hostfile
Resolving Dependencies
--> Running transaction check
---> Package samba.x86_64 0:4.9.1-10.el7_7 will be installed
--> Processing Dependency: samba-libs = 4.9.1-10.el7_7 for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: samba-common-tools = 4.9.1-10.el7_7 for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: samba-common-libs = 4.9.1-10.el7_7 for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: samba-common = 4.9.1-10.el7_7 for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: samba-common = 4.9.1-10.el7_7 for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: samba-client-libs = 4.9.1-10.el7_7 for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libwbclient = 4.9.1-10.el7_7 for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libxattr-tdb-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libutil-tdb-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libutil-reg-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libtevent.so.0(TEVENT_0.9.9)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libtevent.so.0(TEVENT_0.9.21)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libtevent.so.0(TEVENT_0.9.16)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libtevent-util.so.0(TEVENT_UTIL_0.0.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libtdb.so.1(TDB_1.2.5)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libtdb.so.1(TDB_1.2.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libtalloc.so.2(TALLOC_2.0.2)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsys-rw-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsocket-blocking-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsmbd-shim-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsmbd-base-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsmbconf.so.0(SMBCONF_0)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsmb-transport-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libserver-id-db-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsecrets3-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba3-util-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba-util.so.0(SAMBA_UTIL_0.0.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba-sockets-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba-security-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba-passdb.so.0(SAMBA_PASSDB_0.2.0)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba-hostconfig.so.0(SAMBA_HOSTCONFIG_0.0.1)(64bit) for package:samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba-errors.so.1(SAMBA_ERRORS_1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba-debug-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba-cluster-support-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libreplace-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libpopt-samba3-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libndr.so.0(NDR_0.0.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libndr-standard.so.0(NDR_STANDARD_0.0.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libndr-samba-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libndr-nbt.so.0(NDR_NBT_0.0.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libmsghdr-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libmessages-dgm-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: liblibsmb-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libgse-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libgenrand-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libdbwrap-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libcmdline-contexts-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libcliauth-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libcli-smb-common-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libcli-nbt-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libcli-cldap-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libauth-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libCHARSET3-samba4.so(SAMBA_4.9.1)(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libxattr-tdb-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libutil-tdb-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libutil-reg-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libtevent.so.0()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libtevent-util.so.0()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libtdb.so.1()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libtalloc.so.2()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsys-rw-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsocket-blocking-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsmbd-shim-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsmbd-base-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsmbconf.so.0()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsmb-transport-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libserver-id-db-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsecrets3-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba3-util-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba-util.so.0()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba-sockets-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba-security-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba-passdb.so.0()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba-hostconfig.so.0()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba-errors.so.1()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba-debug-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libsamba-cluster-support-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libreplace-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libpopt-samba3-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libndr.so.0()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libndr-standard.so.0()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libndr-samba-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libndr-nbt.so.0()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libmsghdr-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libmessages-dgm-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: liblibsmb-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libgse-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libgenrand-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libdbwrap-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libcmdline-contexts-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libcliauth-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libcli-smb-common-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libcli-nbt-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libcli-cldap-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libauth-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libCHARSET3-samba4.so()(64bit) for package: samba-4.9.1-10.el7_7.x86_64
--> Running transaction check
---> Package libtalloc.x86_64 0:2.1.14-1.el7 will be installed
---> Package libtdb.x86_64 0:1.3.16-1.el7 will be installed
---> Package libtevent.x86_64 0:0.9.37-1.el7 will be installed
---> Package libwbclient.x86_64 0:4.9.1-10.el7_7 will be installed
---> Package samba-client-libs.x86_64 0:4.9.1-10.el7_7 will be installed
--> Processing Dependency: libldb.so.1(LDB_1.3.0)(64bit) for package: samba-client-libs-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libldb.so.1(LDB_1.1.30)(64bit) for package: samba-client-libs-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libldb.so.1(LDB_1.1.19)(64bit) for package: samba-client-libs-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libldb.so.1(LDB_1.1.1)(64bit) for package: samba-client-libs-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libldb.so.1(LDB_0.9.23)(64bit) for package: samba-client-libs-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libldb.so.1(LDB_0.9.15)(64bit) for package: samba-client-libs-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libldb.so.1(LDB_0.9.10)(64bit) for package: samba-client-libs-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libldb.so.1()(64bit) for package: samba-client-libs-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libjansson.so.4()(64bit) for package: samba-client-libs-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libcups.so.2()(64bit) for package: samba-client-libs-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libavahi-common.so.3()(64bit) for package: samba-client-libs-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libavahi-client.so.3()(64bit) for package: samba-client-libs-4.9.1-10.el7_7.x86_64
---> Package samba-common.noarch 0:4.9.1-10.el7_7 will be installed
---> Package samba-common-libs.x86_64 0:4.9.1-10.el7_7 will be installed
---> Package samba-common-tools.x86_64 0:4.9.1-10.el7_7 will be installed
---> Package samba-libs.x86_64 0:4.9.1-10.el7_7 will be installed
--> Processing Dependency: libpytalloc-util.so.2(PYTALLOC_UTIL_2.1.9)(64bit) for package: samba-libs-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libpytalloc-util.so.2(PYTALLOC_UTIL_2.1.6)(64bit) for package: samba-libs-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libpytalloc-util.so.2(PYTALLOC_UTIL_2.0.6)(64bit) for package: samba-libs-4.9.1-10.el7_7.x86_64
--> Processing Dependency: libpytalloc-util.so.2()(64bit) for package: samba-libs-4.9.1-10.el7_7.x86_64
--> Running transaction check
---> Package avahi-libs.x86_64 0:0.6.31-19.el7 will be installed
---> Package cups-libs.x86_64 1:1.6.3-40.el7 will be installed
---> Package jansson.x86_64 0:2.10-1.el7 will be installed
---> Package libldb.x86_64 0:1.4.2-1.el7 will be installed
---> Package pytalloc.x86_64 0:2.1.14-1.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================================
 Package                     Arch            Version                   Repository          Size
================================================================================================
Installing:
 samba                       x86_64          4.9.1-10.el7_7            yum_local          685 k
Installing for dependencies:
 avahi-libs                  x86_64          0.6.31-19.el7             yum_local           61 k
 cups-libs                   x86_64          1:1.6.3-40.el7            yum_local          358 k
 jansson                     x86_64          2.10-1.el7                yum_local           37 k
 libldb                      x86_64          1.4.2-1.el7               yum_local          144 k
 libtalloc                   x86_64          2.1.14-1.el7              yum_local           32 k
 libtdb                      x86_64          1.3.16-1.el7              yum_local           48 k
 libtevent                   x86_64          0.9.37-1.el7              yum_local           40 k
 libwbclient                 x86_64          4.9.1-10.el7_7            yum_local          111 k
 pytalloc                    x86_64          2.1.14-1.el7              yum_local           17 k
 samba-client-libs           x86_64          4.9.1-10.el7_7            yum_local          4.9 M
 samba-common                noarch          4.9.1-10.el7_7            yum_local          210 k
 samba-common-libs           x86_64          4.9.1-10.el7_7            yum_local          171 k
 samba-common-tools          x86_64          4.9.1-10.el7_7            yum_local          456 k
 samba-libs                  x86_64          4.9.1-10.el7_7            yum_local          260 k

Transaction Summary
================================================================================================
Install  1 Package (+14 Dependent packages)

Total download size: 7.5 M
Installed size: 25 M
Downloading packages:
------------------------------------------------------------------------------------------------
Total                                                           247 MB/s | 7.5 MB  00:00:00
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : libtalloc-2.1.14-1.el7.x86_64                                               1/15
  Installing : libtdb-1.3.16-1.el7.x86_64                                                  2/15
  Installing : libtevent-0.9.37-1.el7.x86_64                                               3/15
  Installing : samba-common-4.9.1-10.el7_7.noarch                                          4/15
  Installing : libldb-1.4.2-1.el7.x86_64                                                   5/15
  Installing : avahi-libs-0.6.31-19.el7.x86_64                                             6/15
  Installing : 1:cups-libs-1.6.3-40.el7.x86_64                                             7/15
  Installing : pytalloc-2.1.14-1.el7.x86_64                                                8/15
  Installing : jansson-2.10-1.el7.x86_64                                                   9/15
  Installing : libwbclient-4.9.1-10.el7_7.x86_64                                          10/15
  Installing : samba-common-libs-4.9.1-10.el7_7.x86_64                                    11/15
  Installing : samba-client-libs-4.9.1-10.el7_7.x86_64                                    12/15
  Installing : samba-libs-4.9.1-10.el7_7.x86_64                                           13/15
  Installing : samba-common-tools-4.9.1-10.el7_7.x86_64                                   14/15
  Installing : samba-4.9.1-10.el7_7.x86_64                                                15/15
  Verifying  : samba-4.9.1-10.el7_7.x86_64                                                 1/15
  Verifying  : samba-client-libs-4.9.1-10.el7_7.x86_64                                     2/15
  Verifying  : libtalloc-2.1.14-1.el7.x86_64                                               3/15
  Verifying  : pytalloc-2.1.14-1.el7.x86_64                                                4/15
  Verifying  : libtdb-1.3.16-1.el7.x86_64                                                  5/15
  Verifying  : 1:cups-libs-1.6.3-40.el7.x86_64                                             6/15
  Verifying  : samba-libs-4.9.1-10.el7_7.x86_64                                            7/15
  Verifying  : libwbclient-4.9.1-10.el7_7.x86_64                                           8/15
  Verifying  : avahi-libs-0.6.31-19.el7.x86_64                                             9/15
  Verifying  : libldb-1.4.2-1.el7.x86_64                                                  10/15
  Verifying  : samba-common-tools-4.9.1-10.el7_7.x86_64                                   11/15
  Verifying  : libtevent-0.9.37-1.el7.x86_64                                              12/15
  Verifying  : samba-common-4.9.1-10.el7_7.noarch                                         13/15
  Verifying  : samba-common-libs-4.9.1-10.el7_7.x86_64                                    14/15
  Verifying  : jansson-2.10-1.el7.x86_64                                                  15/15

Installed:
  samba.x86_64 0:4.9.1-10.el7_7

Dependency Installed:
  avahi-libs.x86_64 0:0.6.31-19.el7               cups-libs.x86_64 1:1.6.3-40.el7
  jansson.x86_64 0:2.10-1.el7                     libldb.x86_64 0:1.4.2-1.el7
  libtalloc.x86_64 0:2.1.14-1.el7                 libtdb.x86_64 0:1.3.16-1.el7
  libtevent.x86_64 0:0.9.37-1.el7                 libwbclient.x86_64 0:4.9.1-10.el7_7
  pytalloc.x86_64 0:2.1.14-1.el7                  samba-client-libs.x86_64 0:4.9.1-10.el7_7
  samba-common.noarch 0:4.9.1-10.el7_7            samba-common-libs.x86_64 0:4.9.1-10.el7_7
  samba-common-tools.x86_64 0:4.9.1-10.el7_7      samba-libs.x86_64 0:4.9.1-10.el7_7

Complete!
[root@stbkp01 yum.repos.d]#
[root@stbkp01 yum.repos.d]#
[root@stbkp01 yum.repos.d]# systemctl start smb && systemctl enable smb && systemctl start smb
Created symlink from /etc/systemd/system/multi-user.target.wants/smb.service to /usr/lib/systemd/system/smb.service.
[root@stbkp01 yum.repos.d]#
[root@stbkp01 yum.repos.d]# systemctl enable smb && systemctl start smb
[root@stbkp01 yum.repos.d]# systemctl status smb
● smb.service - Samba SMB Daemon
   Loaded: loaded (/usr/lib/systemd/system/smb.service; enabled; vendor preset: disabled)
   Active: active (running) since Mon 2020-11-09 21:14:54 UTC; 42s ago
     Docs: man:smbd(8)
           man:samba(7)
           man:smb.conf(5)
 Main PID: 182 (smbd)
   Status: "smbd: ready to serve connections..."
   CGroup: /docker/482af05b13e2cdc83c01e8b27ae791d86de87659efa685194c4d90a32837045d/system.slice/smb.service
           ├─182 /usr/sbin/smbd --foreground --no-process-group
           ├─184 /usr/sbin/smbd --foreground --no-process-group
           ├─185 /usr/sbin/smbd --foreground --no-process-group
           └─187 /usr/sbin/smbd --foreground --no-process-group

Nov 09 21:14:54 stbkp01 systemd[1]: smb.service changed dead -> running
Nov 09 21:14:54 stbkp01 systemd[1]: Trying to enqueue job smb.service/start/replace
Nov 09 21:14:54 stbkp01 systemd[1]: Installed new job smb.service/start as 170
Nov 09 21:14:54 stbkp01 systemd[1]: Enqueued job smb.service/start as 170
Nov 09 21:14:54 stbkp01 systemd[1]: Job smb.service/start finished, result=done
Nov 09 21:15:10 stbkp01 systemd[1]: smb.service changed dead -> running
Nov 09 21:15:10 stbkp01 systemd[1]: Trying to enqueue job smb.service/start/replace
Nov 09 21:15:10 stbkp01 systemd[1]: Installed new job smb.service/start as 197
Nov 09 21:15:10 stbkp01 systemd[1]: Enqueued job smb.service/start as 197
Nov 09 21:15:10 stbkp01 systemd[1]: Job smb.service/start finished, result=done
[root@stbkp01 yum.repos.d]#
[root@stbkp01 yum.repos.d]# ll /etc/yum.repos.d/
total 4
-rw-r--r-- 1 root root 95 Nov  9 21:13 yum_local.repo
[root@stbkp01 yum.repos.d]#
[root@stbkp01 yum.repos.d]# cat /etc/yum.repos.d/
cat: /etc/yum.repos.d/: Is a directory
[root@stbkp01 yum.repos.d]#
[root@stbkp01 yum.repos.d]# cat /etc/yum.repos.d/yum_local.repo

[yum_local]
name=yum_local
baseurl=file:///packages/downloaded_rpms/
gpgcheck=0
enabled=1

[root@stbkp01 yum.repos.d]# Connection to host01 closed by remote host.
Connection to host01 closed.

The environment has expired.

Please refresh to get a new environment.