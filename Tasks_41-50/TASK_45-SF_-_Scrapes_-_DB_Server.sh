
-----------------------------------------------------------------------------------------------------------------

# SUPPORTING FILE 

# This is a supporting file for the Task of the same name.
# This may contain configurations/config file.
# Basically, any file that is edited/created/modified through the 'vi' or 'nano' command will appear here.
# Note that there may be more than one supporting files for the Task at hand.

-----------------------------------------------------------------------------------------------------------------

TASK 45 - SF - Scrapes - DB Server


[root@stdb01 ~]# systemctl start mariadb
Job for mariadb.service failed because the control process exited with error code. See "systemctl status mariadb.service" and "journalctl -xe" for details.
[root@stdb01 ~]#
[root@stdb01 ~]# cd /var/lib/
[root@stdb01 lib]# ll
total 48
drwxr-xr-x 2 root root  4096 Jan 27  2020 alternatives
drwxr-xr-x 2 root root  4096 Mar 14  2019 dbus
drwxr-xr-x 2 root root  4096 Apr 11  2018 games
drwxr-xr-x 2 root root  4096 Nov  2  2018 initramfs
drwx------ 2 root root  4096 Aug  1  2019 machines
drwxr-xr-x 2 root root  4096 Apr 11  2018 misc
drwxr-xr-x 1 root mysql 4096 Aug  8  2019 mysql
drwxr-xr-x 1 root root  4096 Oct 27 06:42 rpm
drwxr-xr-x 2 root root  4096 Apr 11  2018 rpm-state
drwxr-xr-x 4 root root  4096 Oct 15  2019 stateless
drwxr-xr-x 4 root root  4096 Aug  1  2019 systemd
drwxr-xr-x 6 root root  4096 Jan 27  2020 yum
[root@stdb01 lib]#
[root@stdb01 lib]# chown root:root mysql/
[root@stdb01 lib]#
[root@stdb01 lib]# ll
total 48
drwxr-xr-x 2 root root 4096 Jan 27  2020 alternatives
drwxr-xr-x 2 root root 4096 Mar 14  2019 dbus
drwxr-xr-x 2 root root 4096 Apr 11  2018 games
drwxr-xr-x 2 root root 4096 Nov  2  2018 initramfs
drwx------ 2 root root 4096 Aug  1  2019 machines
drwxr-xr-x 2 root root 4096 Apr 11  2018 misc
drwxr-xr-x 1 root root 4096 Aug  8  2019 mysql
drwxr-xr-x 1 root root 4096 Oct 27 06:42 rpm
drwxr-xr-x 2 root root 4096 Apr 11  2018 rpm-state
drwxr-xr-x 4 root root 4096 Oct 15  2019 stateless
drwxr-xr-x 4 root root 4096 Aug  1  2019 systemd
drwxr-xr-x 6 root root 4096 Jan 27  2020 yum
[root@stdb01 lib]#
[root@stdb01 lib]# systemctl start mariadb
Job for mariadb.service failed because the control process exited with error code. See "systemctl status mariadb.service" and "journalctl -xe" for details.
[root@stdb01 lib]#
[root@stdb01 lib]# sudo yum update -y
Loaded plugins: fastestmirror, ovl
Determining fastest mirrors
 * base: mirror.infonline.de
 * extras: linux.darkpenguin.net
 * updates: mirror.ratiokontakt.de
base                                                                     | 3.6 kB  00:00:00
extras                                                                   | 2.9 kB  00:00:00
updates                                                                  | 2.9 kB  00:00:00
(1/4): extras/7/x86_64/primary_db                                        | 206 kB  00:00:00
(2/4): base/7/x86_64/group_gz                                            | 153 kB  00:00:00
(3/4): base/7/x86_64/primary_db                                          | 6.1 MB  00:00:00
(4/4): updates/7/x86_64/primary_db                                       | 4.5 MB  00:00:01
Resolving Dependencies
--> Running transaction check
---> Package acl.x86_64 0:2.2.51-14.el7 will be updated
---> Package acl.x86_64 0:2.2.51-15.el7 will be an update
---> Package audit-libs.x86_64 0:2.8.4-4.el7 will be updated
---> Package audit-libs.x86_64 0:2.8.5-4.el7 will be an update
---> Package bash.x86_64 0:4.2.46-31.el7 will be updated
---> Package bash.x86_64 0:4.2.46-34.el7 will be an update
---> Package bind-license.noarch 32:9.9.4-74.el7_6.2 will be updated
---> Package bind-license.noarch 32:9.11.4-16.P2.el7_8.6 will be an update
---> Package binutils.x86_64 0:2.27-34.base.el7 will be updated
---> Package binutils.x86_64 0:2.27-43.base.el7_8.1 will be an update
---> Package ca-certificates.noarch 0:2018.2.22-70.0.el7_5 will be updated
---> Package ca-certificates.noarch 0:2020.2.41-70.0.el7_8 will be an update
---> Package centos-release.x86_64 0:7-6.1810.2.el7.centos will be updated
---> Package centos-release.x86_64 0:7-8.2003.0.el7.centos will be an update
---> Package coreutils.x86_64 0:8.22-23.el7 will be updated
---> Package coreutils.x86_64 0:8.22-24.el7 will be an update
---> Package cryptsetup-libs.x86_64 0:2.0.3-3.el7 will be updated
---> Package cryptsetup-libs.x86_64 0:2.0.3-6.el7 will be an update
---> Package curl.x86_64 0:7.29.0-51.el7_6.3 will be updated
---> Package curl.x86_64 0:7.29.0-57.el7_8.1 will be an update
---> Package dbus.x86_64 1:1.10.24-13.el7_6 will be updated
---> Package dbus.x86_64 1:1.10.24-14.el7_8 will be an update
---> Package dbus-libs.x86_64 1:1.10.24-13.el7_6 will be updated
---> Package dbus-libs.x86_64 1:1.10.24-14.el7_8 will be an update
---> Package device-mapper.x86_64 7:1.02.149-10.el7_6.8 will be updated
---> Package device-mapper.x86_64 7:1.02.164-7.el7_8.2 will be an update
---> Package device-mapper-libs.x86_64 7:1.02.149-10.el7_6.8 will be updated
---> Package device-mapper-libs.x86_64 7:1.02.164-7.el7_8.2 will be an update
---> Package diffutils.x86_64 0:3.3-4.el7 will be updated
---> Package diffutils.x86_64 0:3.3-5.el7 will be an update
---> Package dracut.x86_64 0:033-554.el7 will be updated
---> Package dracut.x86_64 0:033-568.el7 will be an update
---> Package elfutils-default-yama-scope.noarch 0:0.172-2.el7 will be updated
---> Package elfutils-default-yama-scope.noarch 0:0.176-4.el7 will be an update
---> Package elfutils-libelf.x86_64 0:0.172-2.el7 will be updated
---> Package elfutils-libelf.x86_64 0:0.176-4.el7 will be an update
---> Package elfutils-libs.x86_64 0:0.172-2.el7 will be updated
---> Package elfutils-libs.x86_64 0:0.176-4.el7 will be an update
---> Package expat.x86_64 0:2.1.0-10.el7_3 will be updated
---> Package expat.x86_64 0:2.1.0-11.el7 will be an update
---> Package file-libs.x86_64 0:5.11-35.el7 will be updated
---> Package file-libs.x86_64 0:5.11-36.el7 will be an update
---> Package glib2.x86_64 0:2.56.1-4.el7_6 will be updated
---> Package glib2.x86_64 0:2.56.1-5.el7 will be an update
---> Package glibc.x86_64 0:2.17-260.el7_6.6 will be updated
---> Package glibc.x86_64 0:2.17-307.el7.1 will be an update
---> Package glibc-common.x86_64 0:2.17-260.el7_6.6 will be updated
---> Package glibc-common.x86_64 0:2.17-307.el7.1 will be an update
---> Package hostname.x86_64 0:3.13-3.el7 will be updated
---> Package hostname.x86_64 0:3.13-3.el7_7.1 will be an update
---> Package initscripts.x86_64 0:9.49.47-1.el7 will be updated
---> Package initscripts.x86_64 0:9.49.49-1.el7 will be an update
---> Package iproute.x86_64 0:4.11.0-25.el7 will be updated
---> Package iproute.x86_64 0:4.11.0-25.el7_7.2 will be an update
---> Package iptables.x86_64 0:1.4.21-33.el7 will be updated
---> Package iptables.x86_64 0:1.4.21-34.el7 will be an update
---> Package kmod.x86_64 0:20-23.el7 will be updated
---> Package kmod.x86_64 0:20-28.el7 will be an update
---> Package kmod-libs.x86_64 0:20-23.el7 will be updated
---> Package kmod-libs.x86_64 0:20-28.el7 will be an update
---> Package kpartx.x86_64 0:0.4.9-123.el7 will be updated
---> Package kpartx.x86_64 0:0.4.9-131.el7 will be an update
---> Package krb5-libs.x86_64 0:1.15.1-37.el7_6 will be updated
---> Package krb5-libs.x86_64 0:1.15.1-46.el7 will be an update
---> Package libacl.x86_64 0:2.2.51-14.el7 will be updated
---> Package libacl.x86_64 0:2.2.51-15.el7 will be an update
---> Package libblkid.x86_64 0:2.23.2-59.el7_6.1 will be updated
---> Package libblkid.x86_64 0:2.23.2-63.el7 will be an update
---> Package libcap.x86_64 0:2.22-9.el7 will be updated
---> Package libcap.x86_64 0:2.22-11.el7 will be an update
---> Package libcom_err.x86_64 0:1.42.9-13.el7 will be updated
---> Package libcom_err.x86_64 0:1.42.9-17.el7 will be an update
---> Package libcurl.x86_64 0:7.29.0-51.el7_6.3 will be updated
---> Package libcurl.x86_64 0:7.29.0-57.el7_8.1 will be an update
---> Package libdb.x86_64 0:5.3.21-24.el7 will be updated
---> Package libdb.x86_64 0:5.3.21-25.el7 will be an update
---> Package libdb-utils.x86_64 0:5.3.21-24.el7 will be updated
---> Package libdb-utils.x86_64 0:5.3.21-25.el7 will be an update
---> Package libffi.x86_64 0:3.0.13-18.el7 will be updated
---> Package libffi.x86_64 0:3.0.13-19.el7 will be an update
---> Package libgcc.x86_64 0:4.8.5-36.el7_6.2 will be updated
---> Package libgcc.x86_64 0:4.8.5-39.el7 will be an update
---> Package libmount.x86_64 0:2.23.2-59.el7_6.1 will be updated
---> Package libmount.x86_64 0:2.23.2-63.el7 will be an update
---> Package libselinux.x86_64 0:2.5-14.1.el7 will be updated
---> Package libselinux.x86_64 0:2.5-15.el7 will be an update
---> Package libsmartcols.x86_64 0:2.23.2-59.el7_6.1 will be updated
---> Package libsmartcols.x86_64 0:2.23.2-63.el7 will be an update
---> Package libssh2.x86_64 0:1.4.3-12.el7_6.3 will be updated
---> Package libssh2.x86_64 0:1.8.0-3.el7 will be an update
---> Package libstdc++.x86_64 0:4.8.5-36.el7_6.2 will be updated
---> Package libstdc++.x86_64 0:4.8.5-39.el7 will be an update
---> Package libuuid.x86_64 0:2.23.2-59.el7_6.1 will be updated
---> Package libuuid.x86_64 0:2.23.2-63.el7 will be an update
---> Package libxml2.x86_64 0:2.9.1-6.el7_2.3 will be updated
---> Package libxml2.x86_64 0:2.9.1-6.el7.4 will be an update
---> Package libxml2-python.x86_64 0:2.9.1-6.el7_2.3 will be updated
---> Package libxml2-python.x86_64 0:2.9.1-6.el7.4 will be an update
---> Package lz4.x86_64 0:1.7.5-2.el7 will be updated
---> Package lz4.x86_64 0:1.7.5-3.el7 will be an update
---> Package mariadb.x86_64 1:5.5.64-1.el7 will be updated
---> Package mariadb.x86_64 1:5.5.65-1.el7 will be an update
---> Package mariadb-libs.x86_64 1:5.5.64-1.el7 will be updated
---> Package mariadb-libs.x86_64 1:5.5.65-1.el7 will be an update
---> Package mariadb-server.x86_64 1:5.5.64-1.el7 will be updated
---> Package mariadb-server.x86_64 1:5.5.65-1.el7 will be an update
---> Package nspr.x86_64 0:4.19.0-1.el7_5 will be updated
---> Package nspr.x86_64 0:4.21.0-1.el7 will be an update
---> Package nss.x86_64 0:3.36.0-7.1.el7_6 will be updated
---> Package nss.x86_64 0:3.44.0-7.el7_7 will be an update
---> Package nss-pem.x86_64 0:1.0.3-5.el7_6.1 will be updated
---> Package nss-pem.x86_64 0:1.0.3-7.el7 will be an update
---> Package nss-softokn.x86_64 0:3.36.0-5.el7_5 will be updated
---> Package nss-softokn.x86_64 0:3.44.0-8.el7_7 will be an update
---> Package nss-softokn-freebl.x86_64 0:3.36.0-5.el7_5 will be updated
---> Package nss-softokn-freebl.x86_64 0:3.44.0-8.el7_7 will be an update
---> Package nss-sysinit.x86_64 0:3.36.0-7.1.el7_6 will be updated
---> Package nss-sysinit.x86_64 0:3.44.0-7.el7_7 will be an update
---> Package nss-tools.x86_64 0:3.36.0-7.1.el7_6 will be updated
---> Package nss-tools.x86_64 0:3.44.0-7.el7_7 will be an update
---> Package nss-util.x86_64 0:3.36.0-1.1.el7_6 will be updated
---> Package nss-util.x86_64 0:3.44.0-4.el7_7 will be an update
---> Package openssl-libs.x86_64 1:1.0.2k-16.el7_6.1 will be updated
---> Package openssl-libs.x86_64 1:1.0.2k-19.el7 will be an update
---> Package pam.x86_64 0:1.1.8-22.el7 will be updated
---> Package pam.x86_64 0:1.1.8-23.el7 will be an update
---> Package passwd.x86_64 0:0.79-4.el7 will be updated
---> Package passwd.x86_64 0:0.79-6.el7 will be an update
---> Package perl.x86_64 4:5.16.3-294.el7_6 will be updated
---> Package perl.x86_64 4:5.16.3-295.el7 will be an update
---> Package perl-Pod-Escapes.noarch 1:1.04-294.el7_6 will be updated
---> Package perl-Pod-Escapes.noarch 1:1.04-295.el7 will be an update
---> Package perl-Socket.x86_64 0:2.010-4.el7 will be updated
---> Package perl-Socket.x86_64 0:2.010-5.el7 will be an update
---> Package perl-libs.x86_64 4:5.16.3-294.el7_6 will be updated
---> Package perl-libs.x86_64 4:5.16.3-295.el7 will be an update
---> Package perl-macros.x86_64 4:5.16.3-294.el7_6 will be updated
---> Package perl-macros.x86_64 4:5.16.3-295.el7 will be an update
---> Package procps-ng.x86_64 0:3.3.10-23.el7 will be updated
---> Package procps-ng.x86_64 0:3.3.10-27.el7 will be an update
---> Package python.x86_64 0:2.7.5-80.el7_6 will be updated
---> Package python.x86_64 0:2.7.5-88.el7 will be an update
---> Package python-chardet.noarch 0:2.2.1-1.el7_1 will be updated
---> Package python-chardet.noarch 0:2.2.1-3.el7 will be an update
---> Package python-libs.x86_64 0:2.7.5-80.el7_6 will be updated
---> Package python-libs.x86_64 0:2.7.5-88.el7 will be an update
---> Package python-urlgrabber.noarch 0:3.10-9.el7 will be updated
---> Package python-urlgrabber.noarch 0:3.10-10.el7 will be an update
---> Package readline.x86_64 0:6.2-10.el7 will be updated
---> Package readline.x86_64 0:6.2-11.el7 will be an update
---> Package rpm.x86_64 0:4.11.3-35.el7 will be updated
---> Package rpm.x86_64 0:4.11.3-43.el7 will be an update
---> Package rpm-build-libs.x86_64 0:4.11.3-35.el7 will be updated
---> Package rpm-build-libs.x86_64 0:4.11.3-43.el7 will be an update
---> Package rpm-libs.x86_64 0:4.11.3-35.el7 will be updated
---> Package rpm-libs.x86_64 0:4.11.3-43.el7 will be an update
---> Package rpm-python.x86_64 0:4.11.3-35.el7 will be updated
---> Package rpm-python.x86_64 0:4.11.3-43.el7 will be an update
---> Package sed.x86_64 0:4.2.2-5.el7 will be updated
---> Package sed.x86_64 0:4.2.2-6.el7 will be an update
---> Package setup.noarch 0:2.8.71-10.el7 will be updated
---> Package setup.noarch 0:2.8.71-11.el7 will be an update
---> Package shadow-utils.x86_64 2:4.1.5.1-25.el7_6.1 will be updated
---> Package shadow-utils.x86_64 2:4.6-5.el7 will be an update
---> Package shared-mime-info.x86_64 0:1.8-4.el7 will be updated
---> Package shared-mime-info.x86_64 0:1.8-5.el7 will be an update
---> Package sqlite.x86_64 0:3.7.17-8.el7 will be updated
---> Package sqlite.x86_64 0:3.7.17-8.el7_7.1 will be an update
---> Package sudo.x86_64 0:1.8.23-4.el7 will be updated
---> Package sudo.x86_64 0:1.8.23-9.el7 will be an update
---> Package systemd.x86_64 0:219-62.el7_6.9 will be updated
---> Package systemd.x86_64 0:219-73.el7_8.9 will be an update
---> Package systemd-libs.x86_64 0:219-62.el7_6.9 will be updated
---> Package systemd-libs.x86_64 0:219-73.el7_8.9 will be an update
---> Package tzdata.noarch 0:2019b-1.el7 will be updated
---> Package tzdata.noarch 0:2020a-1.el7 will be an update
---> Package util-linux.x86_64 0:2.23.2-59.el7_6.1 will be updated
---> Package util-linux.x86_64 0:2.23.2-63.el7 will be an update
---> Package vim-minimal.x86_64 2:7.4.160-6.el7_6 will be updated
---> Package vim-minimal.x86_64 2:7.4.629-6.el7 will be an update
---> Package yum.noarch 0:3.4.3-161.el7.centos will be updated
---> Package yum.noarch 0:3.4.3-167.el7.centos will be an update
---> Package yum-plugin-fastestmirror.noarch 0:1.1.31-50.el7 will be updated
---> Package yum-plugin-fastestmirror.noarch 0:1.1.31-54.el7_8 will be an update
---> Package yum-plugin-ovl.noarch 0:1.1.31-50.el7 will be updated
---> Package yum-plugin-ovl.noarch 0:1.1.31-54.el7_8 will be an update
---> Package yum-utils.noarch 0:1.1.31-50.el7 will be updated
---> Package yum-utils.noarch 0:1.1.31-54.el7_8 will be an update
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================================
 Package                          Arch        Version                        Repository    Size
================================================================================================
Updating:
 acl                              x86_64      2.2.51-15.el7                  base          81 k
 audit-libs                       x86_64      2.8.5-4.el7                    base         102 k
 bash                             x86_64      4.2.46-34.el7                  base         1.0 M
 bind-license                     noarch      32:9.11.4-16.P2.el7_8.6        updates       90 k
 binutils                         x86_64      2.27-43.base.el7_8.1           updates      5.9 M
 ca-certificates                  noarch      2020.2.41-70.0.el7_8           updates      382 k
 centos-release                   x86_64      7-8.2003.0.el7.centos          base          26 k
 coreutils                        x86_64      8.22-24.el7                    base         3.3 M
 cryptsetup-libs                  x86_64      2.0.3-6.el7                    base         339 k
 curl                             x86_64      7.29.0-57.el7_8.1              updates      271 k
 dbus                             x86_64      1:1.10.24-14.el7_8             updates      245 k
 dbus-libs                        x86_64      1:1.10.24-14.el7_8             updates      169 k
 device-mapper                    x86_64      7:1.02.164-7.el7_8.2           updates      295 k
 device-mapper-libs               x86_64      7:1.02.164-7.el7_8.2           updates      324 k
 diffutils                        x86_64      3.3-5.el7                      base         322 k
 dracut                           x86_64      033-568.el7                    base         329 k
 elfutils-default-yama-scope      noarch      0.176-4.el7                    base          33 k
 elfutils-libelf                  x86_64      0.176-4.el7                    base         195 k
 elfutils-libs                    x86_64      0.176-4.el7                    base         291 k
 expat                            x86_64      2.1.0-11.el7                   base          81 k
 file-libs                        x86_64      5.11-36.el7                    base         340 k
 glib2                            x86_64      2.56.1-5.el7                   base         2.5 M
 glibc                            x86_64      2.17-307.el7.1                 base         3.6 M
 glibc-common                     x86_64      2.17-307.el7.1                 base          11 M
 hostname                         x86_64      3.13-3.el7_7.1                 base          17 k
 initscripts                      x86_64      9.49.49-1.el7                  base         440 k
 iproute                          x86_64      4.11.0-25.el7_7.2              base         803 k
 iptables                         x86_64      1.4.21-34.el7                  base         432 k
 kmod                             x86_64      20-28.el7                      base         123 k
 kmod-libs                        x86_64      20-28.el7                      base          51 k
 kpartx                           x86_64      0.4.9-131.el7                  base          80 k
 krb5-libs                        x86_64      1.15.1-46.el7                  base         809 k
 libacl                           x86_64      2.2.51-15.el7                  base          27 k
 libblkid                         x86_64      2.23.2-63.el7                  base         182 k
 libcap                           x86_64      2.22-11.el7                    base          47 k
 libcom_err                       x86_64      1.42.9-17.el7                  base          42 k
 libcurl                          x86_64      7.29.0-57.el7_8.1              updates      223 k
 libdb                            x86_64      5.3.21-25.el7                  base         720 k
 libdb-utils                      x86_64      5.3.21-25.el7                  base         132 k
 libffi                           x86_64      3.0.13-19.el7                  base          30 k
 libgcc                           x86_64      4.8.5-39.el7                   base         102 k
 libmount                         x86_64      2.23.2-63.el7                  base         184 k
 libselinux                       x86_64      2.5-15.el7                     base         162 k
 libsmartcols                     x86_64      2.23.2-63.el7                  base         142 k
 libssh2                          x86_64      1.8.0-3.el7                    base          88 k
 libstdc++                        x86_64      4.8.5-39.el7                   base         305 k
 libuuid                          x86_64      2.23.2-63.el7                  base          83 k
 libxml2                          x86_64      2.9.1-6.el7.4                  base         668 k
 libxml2-python                   x86_64      2.9.1-6.el7.4                  base         247 k
 lz4                              x86_64      1.7.5-3.el7                    base          99 k
 mariadb                          x86_64      1:5.5.65-1.el7                 base         8.7 M
 mariadb-libs                     x86_64      1:5.5.65-1.el7                 base         759 k
 mariadb-server                   x86_64      1:5.5.65-1.el7                 base          11 M
 nspr                             x86_64      4.21.0-1.el7                   base         127 k
 nss                              x86_64      3.44.0-7.el7_7                 base         854 k
 nss-pem                          x86_64      1.0.3-7.el7                    base          74 k
 nss-softokn                      x86_64      3.44.0-8.el7_7                 base         330 k
 nss-softokn-freebl               x86_64      3.44.0-8.el7_7                 base         224 k
 nss-sysinit                      x86_64      3.44.0-7.el7_7                 base          65 k
 nss-tools                        x86_64      3.44.0-7.el7_7                 base         528 k
 nss-util                         x86_64      3.44.0-4.el7_7                 base          79 k
 openssl-libs                     x86_64      1:1.0.2k-19.el7                base         1.2 M
 pam                              x86_64      1.1.8-23.el7                   base         721 k
 passwd                           x86_64      0.79-6.el7                     base         106 k
 perl                             x86_64      4:5.16.3-295.el7               base         8.0 M
 perl-Pod-Escapes                 noarch      1:1.04-295.el7                 base          51 k
 perl-Socket                      x86_64      2.010-5.el7                    base          49 k
 perl-libs                        x86_64      4:5.16.3-295.el7               base         689 k
 perl-macros                      x86_64      4:5.16.3-295.el7               base          44 k
 procps-ng                        x86_64      3.3.10-27.el7                  base         291 k
 python                           x86_64      2.7.5-88.el7                   base          96 k
 python-chardet                   noarch      2.2.1-3.el7                    base         227 k
 python-libs                      x86_64      2.7.5-88.el7                   base         5.6 M
 python-urlgrabber                noarch      3.10-10.el7                    base         108 k
 readline                         x86_64      6.2-11.el7                     base         193 k
 rpm                              x86_64      4.11.3-43.el7                  base         1.2 M
 rpm-build-libs                   x86_64      4.11.3-43.el7                  base         107 k
 rpm-libs                         x86_64      4.11.3-43.el7                  base         278 k
 rpm-python                       x86_64      4.11.3-43.el7                  base          84 k
 sed                              x86_64      4.2.2-6.el7                    base         231 k
 setup                            noarch      2.8.71-11.el7                  base         166 k
 shadow-utils                     x86_64      2:4.6-5.el7                    base         1.2 M
 shared-mime-info                 x86_64      1.8-5.el7                      base         312 k
 sqlite                           x86_64      3.7.17-8.el7_7.1               base         394 k
 sudo                             x86_64      1.8.23-9.el7                   base         842 k
 systemd                          x86_64      219-73.el7_8.9                 updates      5.1 M
 systemd-libs                     x86_64      219-73.el7_8.9                 updates      416 k
 tzdata                           noarch      2020a-1.el7                    updates      495 k
 util-linux                       x86_64      2.23.2-63.el7                  base         2.0 M
 vim-minimal                      x86_64      2:7.4.629-6.el7                base         443 k
 yum                              noarch      3.4.3-167.el7.centos           base         1.2 M
 yum-plugin-fastestmirror         noarch      1.1.31-54.el7_8                updates       34 k
 yum-plugin-ovl                   noarch      1.1.31-54.el7_8                updates       28 k
 yum-utils                        noarch      1.1.31-54.el7_8                updates      122 k

Transaction Summary
================================================================================================
Upgrade  94 Packages

Total download size: 92 M
Downloading packages:
Delta RPMs disabled because /usr/bin/applydeltarpm not installed.
(1/94): acl-2.2.51-15.el7.x86_64.rpm                                     |  81 kB  00:00:00
(2/94): audit-libs-2.8.5-4.el7.x86_64.rpm                                | 102 kB  00:00:00
(3/94): bash-4.2.46-34.el7.x86_64.rpm                                    | 1.0 MB  00:00:00
(4/94): bind-license-9.11.4-16.P2.el7_8.6.noarch.rpm                     |  90 kB  00:00:00
(5/94): centos-release-7-8.2003.0.el7.centos.x86_64.rpm                  |  26 kB  00:00:00
(6/94): ca-certificates-2020.2.41-70.0.el7_8.noarch.rpm                  | 382 kB  00:00:00
(7/94): cryptsetup-libs-2.0.3-6.el7.x86_64.rpm                           | 339 kB  00:00:00
(8/94): curl-7.29.0-57.el7_8.1.x86_64.rpm                                | 271 kB  00:00:00
(9/94): dbus-1.10.24-14.el7_8.x86_64.rpm                                 | 245 kB  00:00:00
(10/94): dbus-libs-1.10.24-14.el7_8.x86_64.rpm                           | 169 kB  00:00:00
(11/94): device-mapper-1.02.164-7.el7_8.2.x86_64.rpm                     | 295 kB  00:00:00
(12/94): device-mapper-libs-1.02.164-7.el7_8.2.x86_64.rpm                | 324 kB  00:00:00
(13/94): diffutils-3.3-5.el7.x86_64.rpm                                  | 322 kB  00:00:00
(14/94): dracut-033-568.el7.x86_64.rpm                                   | 329 kB  00:00:00
(15/94): elfutils-default-yama-scope-0.176-4.el7.noarch.rpm              |  33 kB  00:00:00
(16/94): binutils-2.27-43.base.el7_8.1.x86_64.rpm                        | 5.9 MB  00:00:00
(17/94): coreutils-8.22-24.el7.x86_64.rpm                                | 3.3 MB  00:00:00
(18/94): elfutils-libelf-0.176-4.el7.x86_64.rpm                          | 195 kB  00:00:00
(19/94): expat-2.1.0-11.el7.x86_64.rpm                                   |  81 kB  00:00:00
(20/94): elfutils-libs-0.176-4.el7.x86_64.rpm                            | 291 kB  00:00:00
(21/94): glib2-2.56.1-5.el7.x86_64.rpm                                   | 2.5 MB  00:00:00
(22/94): glibc-2.17-307.el7.1.x86_64.rpm                                 | 3.6 MB  00:00:00
(23/94): file-libs-5.11-36.el7.x86_64.rpm                                | 340 kB  00:00:00
(24/94): hostname-3.13-3.el7_7.1.x86_64.rpm                              |  17 kB  00:00:00
(25/94): initscripts-9.49.49-1.el7.x86_64.rpm                            | 440 kB  00:00:00
(26/94): iproute-4.11.0-25.el7_7.2.x86_64.rpm                            | 803 kB  00:00:00
(27/94): iptables-1.4.21-34.el7.x86_64.rpm                               | 432 kB  00:00:00
(28/94): kmod-20-28.el7.x86_64.rpm                                       | 123 kB  00:00:00
(29/94): glibc-common-2.17-307.el7.1.x86_64.rpm                          |  11 MB  00:00:00
(30/94): kmod-libs-20-28.el7.x86_64.rpm                                  |  51 kB  00:00:00
(31/94): kpartx-0.4.9-131.el7.x86_64.rpm                                 |  80 kB  00:00:00
(32/94): libacl-2.2.51-15.el7.x86_64.rpm                                 |  27 kB  00:00:00
(33/94): krb5-libs-1.15.1-46.el7.x86_64.rpm                              | 809 kB  00:00:00
(34/94): libblkid-2.23.2-63.el7.x86_64.rpm                               | 182 kB  00:00:00
(35/94): libcap-2.22-11.el7.x86_64.rpm                                   |  47 kB  00:00:00
(36/94): libcom_err-1.42.9-17.el7.x86_64.rpm                             |  42 kB  00:00:00
(37/94): libcurl-7.29.0-57.el7_8.1.x86_64.rpm                            | 223 kB  00:00:00
(38/94): libdb-utils-5.3.21-25.el7.x86_64.rpm                            | 132 kB  00:00:00
(39/94): libdb-5.3.21-25.el7.x86_64.rpm                                  | 720 kB  00:00:00
(40/94): libffi-3.0.13-19.el7.x86_64.rpm                                 |  30 kB  00:00:00
(41/94): libmount-2.23.2-63.el7.x86_64.rpm                               | 184 kB  00:00:00
(42/94): libgcc-4.8.5-39.el7.x86_64.rpm                                  | 102 kB  00:00:00
(43/94): libselinux-2.5-15.el7.x86_64.rpm                                | 162 kB  00:00:00
(44/94): libsmartcols-2.23.2-63.el7.x86_64.rpm                           | 142 kB  00:00:00
(45/94): libssh2-1.8.0-3.el7.x86_64.rpm                                  |  88 kB  00:00:00
(46/94): libstdc++-4.8.5-39.el7.x86_64.rpm                               | 305 kB  00:00:00
(47/94): libxml2-2.9.1-6.el7.4.x86_64.rpm                                | 668 kB  00:00:00
(48/94): libxml2-python-2.9.1-6.el7.4.x86_64.rpm                         | 247 kB  00:00:00
(49/94): lz4-1.7.5-3.el7.x86_64.rpm                                      |  99 kB  00:00:00
(50/94): mariadb-5.5.65-1.el7.x86_64.rpm                                 | 8.7 MB  00:00:00
(51/94): libuuid-2.23.2-63.el7.x86_64.rpm                                |  83 kB  00:00:00
(52/94): mariadb-libs-5.5.65-1.el7.x86_64.rpm                            | 759 kB  00:00:00
(53/94): nspr-4.21.0-1.el7.x86_64.rpm                                    | 127 kB  00:00:00
(54/94): nss-3.44.0-7.el7_7.x86_64.rpm                                   | 854 kB  00:00:00
(55/94): nss-pem-1.0.3-7.el7.x86_64.rpm                                  |  74 kB  00:00:00
(56/94): nss-softokn-3.44.0-8.el7_7.x86_64.rpm                           | 330 kB  00:00:00
(57/94): nss-softokn-freebl-3.44.0-8.el7_7.x86_64.rpm                    | 224 kB  00:00:00
(58/94): nss-sysinit-3.44.0-7.el7_7.x86_64.rpm                           |  65 kB  00:00:00
(59/94): mariadb-server-5.5.65-1.el7.x86_64.rpm                          |  11 MB  00:00:00
(60/94): nss-tools-3.44.0-7.el7_7.x86_64.rpm                             | 528 kB  00:00:00
(61/94): nss-util-3.44.0-4.el7_7.x86_64.rpm                              |  79 kB  00:00:00
(62/94): openssl-libs-1.0.2k-19.el7.x86_64.rpm                           | 1.2 MB  00:00:00
(63/94): passwd-0.79-6.el7.x86_64.rpm                                    | 106 kB  00:00:00
(64/94): pam-1.1.8-23.el7.x86_64.rpm                                     | 721 kB  00:00:00
(65/94): perl-Pod-Escapes-1.04-295.el7.noarch.rpm                        |  51 kB  00:00:00
(66/94): perl-Socket-2.010-5.el7.x86_64.rpm                              |  49 kB  00:00:00
(67/94): perl-libs-5.16.3-295.el7.x86_64.rpm                             | 689 kB  00:00:00
(68/94): perl-macros-5.16.3-295.el7.x86_64.rpm                           |  44 kB  00:00:00
(69/94): perl-5.16.3-295.el7.x86_64.rpm                                  | 8.0 MB  00:00:00
(70/94): python-2.7.5-88.el7.x86_64.rpm                                  |  96 kB  00:00:00
(71/94): procps-ng-3.3.10-27.el7.x86_64.rpm                              | 291 kB  00:00:00
(72/94): python-chardet-2.2.1-3.el7.noarch.rpm                           | 227 kB  00:00:00
(73/94): python-urlgrabber-3.10-10.el7.noarch.rpm                        | 108 kB  00:00:00
(74/94): readline-6.2-11.el7.x86_64.rpm                                  | 193 kB  00:00:00
(75/94): rpm-4.11.3-43.el7.x86_64.rpm                                    | 1.2 MB  00:00:00
(76/94): rpm-build-libs-4.11.3-43.el7.x86_64.rpm                         | 107 kB  00:00:00
(77/94): python-libs-2.7.5-88.el7.x86_64.rpm                             | 5.6 MB  00:00:00
(78/94): rpm-libs-4.11.3-43.el7.x86_64.rpm                               | 278 kB  00:00:00
(79/94): sed-4.2.2-6.el7.x86_64.rpm                                      | 231 kB  00:00:00
(80/94): rpm-python-4.11.3-43.el7.x86_64.rpm                             |  84 kB  00:00:00
(81/94): setup-2.8.71-11.el7.noarch.rpm                                  | 166 kB  00:00:00
(82/94): shared-mime-info-1.8-5.el7.x86_64.rpm                           | 312 kB  00:00:00
(83/94): shadow-utils-4.6-5.el7.x86_64.rpm                               | 1.2 MB  00:00:00
(84/94): sqlite-3.7.17-8.el7_7.1.x86_64.rpm                              | 394 kB  00:00:00
(85/94): sudo-1.8.23-9.el7.x86_64.rpm                                    | 842 kB  00:00:00
(86/94): systemd-219-73.el7_8.9.x86_64.rpm                               | 5.1 MB  00:00:00
(87/94): systemd-libs-219-73.el7_8.9.x86_64.rpm                          | 416 kB  00:00:00
(88/94): tzdata-2020a-1.el7.noarch.rpm                                   | 495 kB  00:00:00
(89/94): util-linux-2.23.2-63.el7.x86_64.rpm                             | 2.0 MB  00:00:00
(90/94): yum-plugin-fastestmirror-1.1.31-54.el7_8.noarch.rpm             |  34 kB  00:00:00
(91/94): yum-utils-1.1.31-54.el7_8.noarch.rpm                            | 122 kB  00:00:00
(92/94): yum-3.4.3-167.el7.centos.noarch.rpm                             | 1.2 MB  00:00:00
(93/94): vim-minimal-7.4.629-6.el7.x86_64.rpm                            | 443 kB  00:00:00
(94/94): yum-plugin-ovl-1.1.31-54.el7_8.noarch.rpm                       |  28 kB  00:00:00
------------------------------------------------------------------------------------------------
Total                                                            16 MB/s |  92 MB  00:00:05
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Updating   : libgcc-4.8.5-39.el7.x86_64                                                 1/188
  Updating   : centos-release-7-8.2003.0.el7.centos.x86_64                                2/188
  Updating   : setup-2.8.71-11.el7.noarch                                                 3/188
warning: /etc/shadow created as /etc/shadow.rpmnew
  Updating   : tzdata-2020a-1.el7.noarch                                                  4/188
  Updating   : bash-4.2.46-34.el7.x86_64                                                  5/188
  Updating   : glibc-common-2.17-307.el7.1.x86_64                                         6/188
  Updating   : nss-softokn-freebl-3.44.0-8.el7_7.x86_64                                   7/188
  Updating   : glibc-2.17-307.el7.1.x86_64                                                8/188
warning: /etc/nsswitch.conf created as /etc/nsswitch.conf.rpmnew
  Updating   : libselinux-2.5-15.el7.x86_64                                               9/188
  Updating   : nspr-4.21.0-1.el7.x86_64                                                  10/188
  Updating   : nss-util-3.44.0-4.el7_7.x86_64                                            11/188
  Updating   : audit-libs-2.8.5-4.el7.x86_64                                             12/188
  Updating   : libacl-2.2.51-15.el7.x86_64                                               13/188
  Updating   : libdb-5.3.21-25.el7.x86_64                                                14/188
  Updating   : libcap-2.22-11.el7.x86_64                                                 15/188
  Updating   : elfutils-libelf-0.176-4.el7.x86_64                                        16/188
  Updating   : sed-4.2.2-6.el7.x86_64                                                    17/188
install-info: No such file or directory for /usr/share/info/sed.info.gz
  Updating   : libuuid-2.23.2-63.el7.x86_64                                              18/188
  Updating   : libcom_err-1.42.9-17.el7.x86_64                                           19/188

  Updating   : diffutils-3.3-5.el7.x86_64                                                20/188
install-info: No such file or directory for /usr/share/info/diffutils.info
  Updating   : libstdc++-4.8.5-39.el7.x86_64                                             21/188
  Updating   : readline-6.2-11.el7.x86_64                                                22/188
  Updating   : sqlite-3.7.17-8.el7_7.1.x86_64                                            23/188
  Updating   : nss-softokn-3.44.0-8.el7_7.x86_64                                         24/188
  Updating   : lz4-1.7.5-3.el7.x86_64                                                    25/188
  Updating   : libxml2-2.9.1-6.el7.4.x86_64                                              26/188
  Updating   : file-libs-5.11-36.el7.x86_64                                              27/188
  Updating   : expat-2.1.0-11.el7.x86_64                                                 28/188
  Updating   : libffi-3.0.13-19.el7.x86_64                                               29/188
  Updating   : libdb-utils-5.3.21-25.el7.x86_64                                          30/188
  Updating   : acl-2.2.51-15.el7.x86_64                                                  31/188
  Updating   : 2:vim-minimal-7.4.629-6.el7.x86_64                                        32/188
  Updating   : 4:perl-macros-5.16.3-295.el7.x86_64                                       33/188
  Updating   : perl-Socket-2.010-5.el7.x86_64                                            34/188
  Updating   : 4:perl-libs-5.16.3-295.el7.x86_64                                         35/188
  Updating   : 4:perl-5.16.3-295.el7.x86_64                                              36/188
  Updating   : kmod-libs-20-28.el7.x86_64                                                37/188
  Updating   : libsmartcols-2.23.2-63.el7.x86_64                                         38/188
  Updating   : iptables-1.4.21-34.el7.x86_64                                             39/188
  Updating   : iproute-4.11.0-25.el7_7.2.x86_64                                          40/188
  Updating   : hostname-3.13-3.el7_7.1.x86_64                                            41/188
  Updating   : ca-certificates-2020.2.41-70.0.el7_8.noarch                               42/188
  Updating   : 1:openssl-libs-1.0.2k-19.el7.x86_64                                       43/188
  Updating   : coreutils-8.22-24.el7.x86_64                                              44/188
  Updating   : krb5-libs-1.15.1-46.el7.x86_64                                            45/188
  Updating   : pam-1.1.8-23.el7.x86_64                                                   46/188
  Updating   : 2:shadow-utils-4.6-5.el7.x86_64                                           47/188
  Updating   : libblkid-2.23.2-63.el7.x86_64                                             48/188
  Updating   : libmount-2.23.2-63.el7.x86_64                                             49/188
  Updating   : glib2-2.56.1-5.el7.x86_64                                                 50/188
  Updating   : shared-mime-info-1.8-5.el7.x86_64                                         51/188
  Updating   : python-libs-2.7.5-88.el7.x86_64                                           52/188
  Updating   : python-2.7.5-88.el7.x86_64                                                53/188
  Updating   : 1:mariadb-libs-5.5.65-1.el7.x86_64                                        54/188
  Updating   : libxml2-python-2.9.1-6.el7.4.x86_64                                       55/188
  Updating   : python-urlgrabber-3.10-10.el7.noarch                                      56/188
  Updating   : binutils-2.27-43.base.el7_8.1.x86_64                                      57/188
install-info: No such file or directory for /usr/share/info/as.info.gz
install-info: No such file or directory for /usr/share/info/binutils.info.gz
install-info: No such file or directory for /usr/share/info/gprof.info.gz
install-info: No such file or directory for /usr/share/info/ld.info.gz
install-info: No such file or directory for /usr/share/info/standards.info.gz
  Updating   : nss-pem-1.0.3-7.el7.x86_64                                                58/188
  Updating   : nss-3.44.0-7.el7_7.x86_64                                                 59/188
  Updating   : nss-sysinit-3.44.0-7.el7_7.x86_64                                         60/188
  Updating   : libssh2-1.8.0-3.el7.x86_64                                                61/188
  Updating   : libcurl-7.29.0-57.el7_8.1.x86_64                                          62/188
  Updating   : util-linux-2.23.2-63.el7.x86_64                                           63/188
  Updating   : procps-ng-3.3.10-27.el7.x86_64                                            64/188
  Updating   : kpartx-0.4.9-131.el7.x86_64                                               65/188
  Updating   : 7:device-mapper-1.02.164-7.el7_8.2.x86_64                                 66/188
  Updating   : 7:device-mapper-libs-1.02.164-7.el7_8.2.x86_64                            67/188
  Updating   : cryptsetup-libs-2.0.3-6.el7.x86_64                                        68/188
  Updating   : dracut-033-568.el7.x86_64                                                 69/188
  Updating   : kmod-20-28.el7.x86_64                                                     70/188
  Updating   : elfutils-libs-0.176-4.el7.x86_64                                          71/188
  Updating   : systemd-libs-219-73.el7_8.9.x86_64                                        72/188
  Updating   : 1:dbus-libs-1.10.24-14.el7_8.x86_64                                       73/188
  Updating   : systemd-219-73.el7_8.9.x86_64                                             74/188
  Updating   : elfutils-default-yama-scope-0.176-4.el7.noarch                            75/188
  Updating   : 1:dbus-1.10.24-14.el7_8.x86_64                                            76/188
  Updating   : 1:mariadb-5.5.65-1.el7.x86_64                                             77/188
  Updating   : curl-7.29.0-57.el7_8.1.x86_64                                             78/188
  Updating   : rpm-4.11.3-43.el7.x86_64                                                  79/188
  Updating   : rpm-libs-4.11.3-43.el7.x86_64                                             80/188
  Updating   : rpm-build-libs-4.11.3-43.el7.x86_64                                       81/188
  Updating   : rpm-python-4.11.3-43.el7.x86_64                                           82/188
  Updating   : yum-plugin-fastestmirror-1.1.31-54.el7_8.noarch                           83/188
  Updating   : yum-3.4.3-167.el7.centos.noarch                                           84/188
  Updating   : yum-plugin-ovl-1.1.31-54.el7_8.noarch                                     85/188
  Updating   : yum-utils-1.1.31-54.el7_8.noarch                                          86/188
  Updating   : 1:mariadb-server-5.5.65-1.el7.x86_64                                      87/188
  Updating   : initscripts-9.49.49-1.el7.x86_64                                          88/188
  Updating   : nss-tools-3.44.0-7.el7_7.x86_64                                           89/188
  Updating   : python-chardet-2.2.1-3.el7.noarch                                         90/188
  Updating   : passwd-0.79-6.el7.x86_64                                                  91/188
  Updating   : sudo-1.8.23-9.el7.x86_64                                                  92/188
  Updating   : 1:perl-Pod-Escapes-1.04-295.el7.noarch                                    93/188
  Updating   : 32:bind-license-9.11.4-16.P2.el7_8.6.noarch                               94/188
  Cleanup    : yum-utils-1.1.31-50.el7.noarch                                            95/188
  Cleanup    : 1:perl-Pod-Escapes-1.04-294.el7_6.noarch                                  96/188
  Cleanup    : yum-plugin-ovl-1.1.31-50.el7.noarch                                       97/188
  Cleanup    : yum-3.4.3-161.el7.centos.noarch                                           98/188
  Cleanup    : yum-plugin-fastestmirror-1.1.31-50.el7.noarch                             99/188
  Cleanup    : python-urlgrabber-3.10-9.el7.noarch                                      100/188
  Cleanup    : python-chardet-2.2.1-1.el7_1.noarch                                      101/188
  Cleanup    : rpm-python-4.11.3-35.el7.x86_64                                          102/188
  Cleanup    : rpm-build-libs-4.11.3-35.el7.x86_64                                      103/188
  Cleanup    : initscripts-9.49.47-1.el7.x86_64                                         104/188
  Cleanup    : 1:mariadb-server-5.5.64-1.el7.x86_64                                     105/188
  Cleanup    : rpm-libs-4.11.3-35.el7.x86_64                                            106/188
  Cleanup    : rpm-4.11.3-35.el7.x86_64                                                 107/188
  Cleanup    : 1:mariadb-5.5.64-1.el7.x86_64                                            108/188
  Cleanup    : 1:dbus-libs-1.10.24-13.el7_6.x86_64                                      109/188
  Cleanup    : procps-ng-3.3.10-23.el7.x86_64                                           110/188
  Cleanup    : util-linux-2.23.2-59.el7_6.1.x86_64                                      111/188
  Cleanup    : cryptsetup-libs-2.0.3-3.el7.x86_64                                       112/188
  Cleanup    : systemd-libs-219-62.el7_6.9.x86_64                                       113/188
  Cleanup    : kpartx-0.4.9-123.el7.x86_64                                              114/188
  Cleanup    : kmod-20-23.el7.x86_64                                                    115/188
  Cleanup    : dracut-033-554.el7.x86_64                                                116/188
  Cleanup    : elfutils-libs-0.172-2.el7.x86_64                                         117/188
  Cleanup    : elfutils-default-yama-scope-0.172-2.el7.noarch                           118/188
  Cleanup    : 7:device-mapper-libs-1.02.149-10.el7_6.8.x86_64                          119/188
  Cleanup    : 7:device-mapper-1.02.149-10.el7_6.8.x86_64                               120/188
  Cleanup    : 1:dbus-1.10.24-13.el7_6.x86_64                                           121/188
  Cleanup    : systemd-219-62.el7_6.9.x86_64                                            122/188
  Cleanup    : curl-7.29.0-51.el7_6.3.x86_64                                            123/188
  Cleanup    : libcurl-7.29.0-51.el7_6.3.x86_64                                         124/188
  Cleanup    : nss-tools-3.36.0-7.1.el7_6.x86_64                                        125/188
  Cleanup    : nss-sysinit-3.36.0-7.1.el7_6.x86_64                                      126/188
  Cleanup    : nss-3.36.0-7.1.el7_6.x86_64                                              127/188
  Cleanup    : nss-pem-1.0.3-5.el7_6.1.x86_64                                           128/188
  Cleanup    : nss-softokn-3.36.0-5.el7_5.x86_64                                        129/188
  Cleanup    : passwd-0.79-4.el7.x86_64                                                 130/188
  Cleanup    : 32:bind-license-9.9.4-74.el7_6.2.noarch                                  131/188
  Cleanup    : shared-mime-info-1.8-4.el7.x86_64                                        132/188
  Cleanup    : glib2-2.56.1-4.el7_6.x86_64                                              133/188
  Cleanup    : 2:shadow-utils-4.1.5.1-25.el7_6.1.x86_64                                 134/188
  Cleanup    : sudo-1.8.23-4.el7.x86_64                                                 135/188
  Cleanup    : pam-1.1.8-22.el7.x86_64                                                  136/188
  Cleanup    : perl-Socket-2.010-4.el7.x86_64                                           137/188
  Cleanup    : 4:perl-libs-5.16.3-294.el7_6.x86_64                                      138/188
  Cleanup    : 4:perl-macros-5.16.3-294.el7_6.x86_64                                    139/188
  Cleanup    : 4:perl-5.16.3-294.el7_6.x86_64                                           140/188
  Cleanup    : iproute-4.11.0-25.el7.x86_64                                             141/188
  Cleanup    : libxml2-python-2.9.1-6.el7_2.3.x86_64                                    142/188
  Cleanup    : libmount-2.23.2-59.el7_6.1.x86_64                                        143/188
  Cleanup    : libblkid-2.23.2-59.el7_6.1.x86_64                                        144/188
  Cleanup    : 1:mariadb-libs-5.5.64-1.el7.x86_64                                       145/188
  Cleanup    : python-2.7.5-80.el7_6.x86_64                                             146/188
  Cleanup    : python-libs-2.7.5-80.el7_6.x86_64                                        147/188
  Cleanup    : 2:vim-minimal-7.4.160-6.el7_6.x86_64                                     148/188
  Cleanup    : sqlite-3.7.17-8.el7.x86_64                                               149/188
  Cleanup    : libstdc++-4.8.5-36.el7_6.2.x86_64                                        150/188
  Cleanup    : libssh2-1.4.3-12.el7_6.3.x86_64                                          151/188
  Cleanup    : kmod-libs-20-23.el7.x86_64                                               152/188
  Cleanup    : binutils-2.27-34.base.el7.x86_64                                         153/188
  Cleanup    : libdb-utils-5.3.21-24.el7.x86_64                                         154/188
  Cleanup    : readline-6.2-10.el7.x86_64                                               155/188
  Cleanup    : iptables-1.4.21-33.el7.x86_64                                            156/188
  Cleanup    : acl-2.2.51-14.el7.x86_64                                                 157/188
  Cleanup    : diffutils-3.3-4.el7.x86_64                                               158/188
  Cleanup    : setup-2.8.71-10.el7.noarch                                               159/188
  Cleanup    : centos-release-7-6.1810.2.el7.centos.x86_64                              160/188
  Cleanup    : krb5-libs-1.15.1-37.el7_6.x86_64                                         161/188
  Cleanup    : coreutils-8.22-23.el7.x86_64                                             162/188
  Cleanup    : 1:openssl-libs-1.0.2k-16.el7_6.1.x86_64                                  163/188
  Cleanup    : sed-4.2.2-5.el7.x86_64                                                   164/188
  Cleanup    : ca-certificates-2018.2.22-70.0.el7_5.noarch                              165/188
  Cleanup    : libcom_err-1.42.9-13.el7.x86_64                                          166/188
  Cleanup    : libacl-2.2.51-14.el7.x86_64                                              167/188
  Cleanup    : libcap-2.22-9.el7.x86_64                                                 168/188
  Cleanup    : libdb-5.3.21-24.el7.x86_64                                               169/188
  Cleanup    : expat-2.1.0-10.el7_3.x86_64                                              170/188
  Cleanup    : libffi-3.0.13-18.el7.x86_64                                              171/188
  Cleanup    : libuuid-2.23.2-59.el7_6.1.x86_64                                         172/188
  Cleanup    : libxml2-2.9.1-6.el7_2.3.x86_64                                           173/188
  Cleanup    : audit-libs-2.8.4-4.el7.x86_64                                            174/188
  Cleanup    : elfutils-libelf-0.172-2.el7.x86_64                                       175/188
  Cleanup    : lz4-1.7.5-2.el7.x86_64                                                   176/188
  Cleanup    : libsmartcols-2.23.2-59.el7_6.1.x86_64                                    177/188
  Cleanup    : hostname-3.13-3.el7.x86_64                                               178/188
  Cleanup    : file-libs-5.11-35.el7.x86_64                                             179/188
  Cleanup    : libselinux-2.5-14.1.el7.x86_64                                           180/188
  Cleanup    : glibc-common-2.17-260.el7_6.6.x86_64                                     181/188
  Cleanup    : bash-4.2.46-31.el7.x86_64                                                182/188
  Cleanup    : nspr-4.19.0-1.el7_5.x86_64                                               183/188
  Cleanup    : nss-util-3.36.0-1.1.el7_6.x86_64                                         184/188
  Cleanup    : nss-softokn-freebl-3.36.0-5.el7_5.x86_64                                 185/188
  Cleanup    : glibc-2.17-260.el7_6.6.x86_64                                            186/188
  Cleanup    : tzdata-2019b-1.el7.noarch                                                187/188
  Cleanup    : libgcc-4.8.5-36.el7_6.2.x86_64                                           188/188
  Verifying  : acl-2.2.51-15.el7.x86_64                                                   1/188
  Verifying  : libacl-2.2.51-15.el7.x86_64                                                2/188
  Verifying  : kpartx-0.4.9-131.el7.x86_64                                                3/188
  Verifying  : centos-release-7-8.2003.0.el7.centos.x86_64                                4/188
  Verifying  : libcap-2.22-11.el7.x86_64                                                  5/188
  Verifying  : python-2.7.5-88.el7.x86_64                                                 6/188
  Verifying  : libxml2-python-2.9.1-6.el7.4.x86_64                                        7/188
  Verifying  : libmount-2.23.2-63.el7.x86_64                                              8/188
  Verifying  : 1:mariadb-5.5.65-1.el7.x86_64                                              9/188
  Verifying  : 1:openssl-libs-1.0.2k-19.el7.x86_64                                       10/188
  Verifying  : readline-6.2-11.el7.x86_64                                                11/188
  Verifying  : sqlite-3.7.17-8.el7_7.1.x86_64                                            12/188
  Verifying  : 4:perl-libs-5.16.3-295.el7.x86_64                                         13/188
  Verifying  : util-linux-2.23.2-63.el7.x86_64                                           14/188
  Verifying  : libgcc-4.8.5-39.el7.x86_64                                                15/188
  Verifying  : nss-pem-1.0.3-7.el7.x86_64                                                16/188
  Verifying  : 4:perl-macros-5.16.3-295.el7.x86_64                                       17/188
  Verifying  : sed-4.2.2-6.el7.x86_64                                                    18/188
  Verifying  : lz4-1.7.5-3.el7.x86_64                                                    19/188
  Verifying  : libselinux-2.5-15.el7.x86_64                                              20/188
  Verifying  : curl-7.29.0-57.el7_8.1.x86_64                                             21/188
  Verifying  : kmod-libs-20-28.el7.x86_64                                                22/188
  Verifying  : elfutils-libs-0.176-4.el7.x86_64                                          23/188
  Verifying  : python-chardet-2.2.1-3.el7.noarch                                         24/188
  Verifying  : libsmartcols-2.23.2-63.el7.x86_64                                         25/188
  Verifying  : nss-3.44.0-7.el7_7.x86_64                                                 26/188
  Verifying  : libssh2-1.8.0-3.el7.x86_64                                                27/188
  Verifying  : 1:mariadb-server-5.5.65-1.el7.x86_64                                      28/188
  Verifying  : setup-2.8.71-11.el7.noarch                                                29/188
  Verifying  : nss-tools-3.44.0-7.el7_7.x86_64                                           30/188
  Verifying  : coreutils-8.22-24.el7.x86_64                                              31/188
  Verifying  : pam-1.1.8-23.el7.x86_64                                                   32/188
  Verifying  : python-urlgrabber-3.10-10.el7.noarch                                      33/188
  Verifying  : yum-plugin-fastestmirror-1.1.31-54.el7_8.noarch                           34/188
  Verifying  : elfutils-default-yama-scope-0.176-4.el7.noarch                            35/188
  Verifying  : cryptsetup-libs-2.0.3-6.el7.x86_64                                        36/188
  Verifying  : iproute-4.11.0-25.el7_7.2.x86_64                                          37/188
  Verifying  : glib2-2.56.1-5.el7.x86_64                                                 38/188
  Verifying  : binutils-2.27-43.base.el7_8.1.x86_64                                      39/188
  Verifying  : yum-3.4.3-167.el7.centos.noarch                                           40/188
  Verifying  : 7:device-mapper-1.02.164-7.el7_8.2.x86_64                                 41/188
  Verifying  : initscripts-9.49.49-1.el7.x86_64                                          42/188
  Verifying  : python-libs-2.7.5-88.el7.x86_64                                           43/188
  Verifying  : 4:perl-5.16.3-295.el7.x86_64                                              44/188
  Verifying  : nss-sysinit-3.44.0-7.el7_7.x86_64                                         45/188
  Verifying  : yum-plugin-ovl-1.1.31-54.el7_8.noarch                                     46/188
  Verifying  : elfutils-libelf-0.176-4.el7.x86_64                                        47/188
  Verifying  : 7:device-mapper-libs-1.02.164-7.el7_8.2.x86_64                            48/188
  Verifying  : libxml2-2.9.1-6.el7.4.x86_64                                              49/188
  Verifying  : tzdata-2020a-1.el7.noarch                                                 50/188
  Verifying  : systemd-libs-219-73.el7_8.9.x86_64                                        51/188
  Verifying  : rpm-python-4.11.3-43.el7.x86_64                                           52/188
  Verifying  : bash-4.2.46-34.el7.x86_64                                                 53/188
  Verifying  : nss-softokn-freebl-3.44.0-8.el7_7.x86_64                                  54/188
  Verifying  : nss-softokn-3.44.0-8.el7_7.x86_64                                         55/188
  Verifying  : 2:shadow-utils-4.6-5.el7.x86_64                                           56/188
  Verifying  : libcom_err-1.42.9-17.el7.x86_64                                           57/188
  Verifying  : passwd-0.79-6.el7.x86_64                                                  58/188
  Verifying  : file-libs-5.11-36.el7.x86_64                                              59/188
  Verifying  : audit-libs-2.8.5-4.el7.x86_64                                             60/188
  Verifying  : procps-ng-3.3.10-27.el7.x86_64                                            61/188
  Verifying  : iptables-1.4.21-34.el7.x86_64                                             62/188
  Verifying  : glibc-common-2.17-307.el7.1.x86_64                                        63/188
  Verifying  : 1:dbus-1.10.24-14.el7_8.x86_64                                            64/188
  Verifying  : kmod-20-28.el7.x86_64                                                     65/188
  Verifying  : diffutils-3.3-5.el7.x86_64                                                66/188
  Verifying  : libblkid-2.23.2-63.el7.x86_64                                             67/188
  Verifying  : glibc-2.17-307.el7.1.x86_64                                               68/188
  Verifying  : ca-certificates-2020.2.41-70.0.el7_8.noarch                               69/188
  Verifying  : hostname-3.13-3.el7_7.1.x86_64                                            70/188
  Verifying  : rpm-4.11.3-43.el7.x86_64                                                  71/188
  Verifying  : libdb-5.3.21-25.el7.x86_64                                                72/188
  Verifying  : 1:perl-Pod-Escapes-1.04-295.el7.noarch                                    73/188
  Verifying  : libdb-utils-5.3.21-25.el7.x86_64                                          74/188
  Verifying  : systemd-219-73.el7_8.9.x86_64                                             75/188
  Verifying  : 2:vim-minimal-7.4.629-6.el7.x86_64                                        76/188
  Verifying  : 32:bind-license-9.11.4-16.P2.el7_8.6.noarch                               77/188
  Verifying  : 1:mariadb-libs-5.5.65-1.el7.x86_64                                        78/188
  Verifying  : libcurl-7.29.0-57.el7_8.1.x86_64                                          79/188
  Verifying  : rpm-libs-4.11.3-43.el7.x86_64                                             80/188
  Verifying  : 1:dbus-libs-1.10.24-14.el7_8.x86_64                                       81/188
  Verifying  : krb5-libs-1.15.1-46.el7.x86_64                                            82/188
  Verifying  : perl-Socket-2.010-5.el7.x86_64                                            83/188
  Verifying  : rpm-build-libs-4.11.3-43.el7.x86_64                                       84/188
  Verifying  : shared-mime-info-1.8-5.el7.x86_64                                         85/188
  Verifying  : libstdc++-4.8.5-39.el7.x86_64                                             86/188
  Verifying  : yum-utils-1.1.31-54.el7_8.noarch                                          87/188
  Verifying  : dracut-033-568.el7.x86_64                                                 88/188
  Verifying  : nspr-4.21.0-1.el7.x86_64                                                  89/188
  Verifying  : libuuid-2.23.2-63.el7.x86_64                                              90/188
  Verifying  : sudo-1.8.23-9.el7.x86_64                                                  91/188
  Verifying  : expat-2.1.0-11.el7.x86_64                                                 92/188
  Verifying  : nss-util-3.44.0-4.el7_7.x86_64                                            93/188
  Verifying  : libffi-3.0.13-19.el7.x86_64                                               94/188
  Verifying  : glib2-2.56.1-4.el7_6.x86_64                                               95/188
  Verifying  : rpm-python-4.11.3-35.el7.x86_64                                           96/188
  Verifying  : nss-pem-1.0.3-5.el7_6.1.x86_64                                            97/188
  Verifying  : libblkid-2.23.2-59.el7_6.1.x86_64                                         98/188
  Verifying  : initscripts-9.49.47-1.el7.x86_64                                          99/188
  Verifying  : glibc-2.17-260.el7_6.6.x86_64                                            100/188
  Verifying  : nss-sysinit-3.36.0-7.1.el7_6.x86_64                                      101/188
  Verifying  : acl-2.2.51-14.el7.x86_64                                                 102/188
  Verifying  : cryptsetup-libs-2.0.3-3.el7.x86_64                                       103/188
  Verifying  : 1:mariadb-5.5.64-1.el7.x86_64                                            104/188
  Verifying  : file-libs-5.11-35.el7.x86_64                                             105/188
  Verifying  : perl-Socket-2.010-4.el7.x86_64                                           106/188
  Verifying  : curl-7.29.0-51.el7_6.3.x86_64                                            107/188
  Verifying  : 1:openssl-libs-1.0.2k-16.el7_6.1.x86_64                                  108/188
  Verifying  : libffi-3.0.13-18.el7.x86_64                                              109/188
  Verifying  : 4:perl-macros-5.16.3-294.el7_6.x86_64                                    110/188
  Verifying  : sudo-1.8.23-4.el7.x86_64                                                 111/188
  Verifying  : 1:mariadb-server-5.5.64-1.el7.x86_64                                     112/188
  Verifying  : 2:vim-minimal-7.4.160-6.el7_6.x86_64                                     113/188
  Verifying  : sqlite-3.7.17-8.el7.x86_64                                               114/188
  Verifying  : nss-tools-3.36.0-7.1.el7_6.x86_64                                        115/188
  Verifying  : bash-4.2.46-31.el7.x86_64                                                116/188
  Verifying  : rpm-libs-4.11.3-35.el7.x86_64                                            117/188
  Verifying  : libmount-2.23.2-59.el7_6.1.x86_64                                        118/188
  Verifying  : iptables-1.4.21-33.el7.x86_64                                            119/188
  Verifying  : libstdc++-4.8.5-36.el7_6.2.x86_64                                        120/188
  Verifying  : krb5-libs-1.15.1-37.el7_6.x86_64                                         121/188
  Verifying  : 4:perl-libs-5.16.3-294.el7_6.x86_64                                      122/188
  Verifying  : 2:shadow-utils-4.1.5.1-25.el7_6.1.x86_64                                 123/188
  Verifying  : readline-6.2-10.el7.x86_64                                               124/188
  Verifying  : coreutils-8.22-23.el7.x86_64                                             125/188
  Verifying  : rpm-build-libs-4.11.3-35.el7.x86_64                                      126/188
  Verifying  : nss-3.36.0-7.1.el7_6.x86_64                                              127/188
  Verifying  : elfutils-libelf-0.172-2.el7.x86_64                                       128/188
  Verifying  : python-urlgrabber-3.10-9.el7.noarch                                      129/188
  Verifying  : libcap-2.22-9.el7.x86_64                                                 130/188
  Verifying  : lz4-1.7.5-2.el7.x86_64                                                   131/188
  Verifying  : iproute-4.11.0-25.el7.x86_64                                             132/188
  Verifying  : elfutils-libs-0.172-2.el7.x86_64                                         133/188
  Verifying  : nss-softokn-3.36.0-5.el7_5.x86_64                                        134/188
  Verifying  : ca-certificates-2018.2.22-70.0.el7_5.noarch                              135/188
  Verifying  : yum-utils-1.1.31-50.el7.noarch                                           136/188
  Verifying  : 32:bind-license-9.9.4-74.el7_6.2.noarch                                  137/188
  Verifying  : setup-2.8.71-10.el7.noarch                                               138/188
  Verifying  : shared-mime-info-1.8-4.el7.x86_64                                        139/188
  Verifying  : centos-release-7-6.1810.2.el7.centos.x86_64                              140/188
  Verifying  : libcom_err-1.42.9-13.el7.x86_64                                          141/188
  Verifying  : yum-3.4.3-161.el7.centos.noarch                                          142/188
  Verifying  : libselinux-2.5-14.1.el7.x86_64                                           143/188
  Verifying  : 7:device-mapper-libs-1.02.149-10.el7_6.8.x86_64                          144/188
  Verifying  : 1:mariadb-libs-5.5.64-1.el7.x86_64                                       145/188
  Verifying  : libdb-utils-5.3.21-24.el7.x86_64                                         146/188
  Verifying  : 1:perl-Pod-Escapes-1.04-294.el7_6.noarch                                 147/188
  Verifying  : dracut-033-554.el7.x86_64                                                148/188
  Verifying  : passwd-0.79-4.el7.x86_64                                                 149/188
  Verifying  : libxml2-2.9.1-6.el7_2.3.x86_64                                           150/188
  Verifying  : rpm-4.11.3-35.el7.x86_64                                                 151/188
  Verifying  : binutils-2.27-34.base.el7.x86_64                                         152/188
  Verifying  : 4:perl-5.16.3-294.el7_6.x86_64                                           153/188
  Verifying  : kmod-20-23.el7.x86_64                                                    154/188
  Verifying  : 1:dbus-libs-1.10.24-13.el7_6.x86_64                                      155/188
  Verifying  : elfutils-default-yama-scope-0.172-2.el7.noarch                           156/188
  Verifying  : libssh2-1.4.3-12.el7_6.3.x86_64                                          157/188
  Verifying  : 1:dbus-1.10.24-13.el7_6.x86_64                                           158/188
  Verifying  : libsmartcols-2.23.2-59.el7_6.1.x86_64                                    159/188
  Verifying  : hostname-3.13-3.el7.x86_64                                               160/188
  Verifying  : libuuid-2.23.2-59.el7_6.1.x86_64                                         161/188
  Verifying  : pam-1.1.8-22.el7.x86_64                                                  162/188
  Verifying  : nss-softokn-freebl-3.36.0-5.el7_5.x86_64                                 163/188
  Verifying  : nspr-4.19.0-1.el7_5.x86_64                                               164/188
  Verifying  : libcurl-7.29.0-51.el7_6.3.x86_64                                         165/188
  Verifying  : 7:device-mapper-1.02.149-10.el7_6.8.x86_64                               166/188
  Verifying  : expat-2.1.0-10.el7_3.x86_64                                              167/188
  Verifying  : kpartx-0.4.9-123.el7.x86_64                                              168/188
  Verifying  : libdb-5.3.21-24.el7.x86_64                                               169/188
  Verifying  : python-2.7.5-80.el7_6.x86_64                                             170/188
  Verifying  : util-linux-2.23.2-59.el7_6.1.x86_64                                      171/188
  Verifying  : procps-ng-3.3.10-23.el7.x86_64                                           172/188
  Verifying  : yum-plugin-ovl-1.1.31-50.el7.noarch                                      173/188
  Verifying  : nss-util-3.36.0-1.1.el7_6.x86_64                                         174/188
  Verifying  : audit-libs-2.8.4-4.el7.x86_64                                            175/188
  Verifying  : kmod-libs-20-23.el7.x86_64                                               176/188
  Verifying  : yum-plugin-fastestmirror-1.1.31-50.el7.noarch                            177/188
  Verifying  : libgcc-4.8.5-36.el7_6.2.x86_64                                           178/188
  Verifying  : libxml2-python-2.9.1-6.el7_2.3.x86_64                                    179/188
  Verifying  : libacl-2.2.51-14.el7.x86_64                                              180/188
  Verifying  : systemd-219-62.el7_6.9.x86_64                                            181/188
  Verifying  : systemd-libs-219-62.el7_6.9.x86_64                                       182/188
  Verifying  : sed-4.2.2-5.el7.x86_64                                                   183/188
  Verifying  : python-libs-2.7.5-80.el7_6.x86_64                                        184/188
  Verifying  : python-chardet-2.2.1-1.el7_1.noarch                                      185/188
  Verifying  : glibc-common-2.17-260.el7_6.6.x86_64                                     186/188
  Verifying  : tzdata-2019b-1.el7.noarch                                                187/188
  Verifying  : diffutils-3.3-4.el7.x86_64                                               188/188

Updated:
  acl.x86_64 0:2.2.51-15.el7
  audit-libs.x86_64 0:2.8.5-4.el7
  bash.x86_64 0:4.2.46-34.el7
  bind-license.noarch 32:9.11.4-16.P2.el7_8.6
  binutils.x86_64 0:2.27-43.base.el7_8.1
  ca-certificates.noarch 0:2020.2.41-70.0.el7_8
  centos-release.x86_64 0:7-8.2003.0.el7.centos
  coreutils.x86_64 0:8.22-24.el7
  cryptsetup-libs.x86_64 0:2.0.3-6.el7
  curl.x86_64 0:7.29.0-57.el7_8.1
  dbus.x86_64 1:1.10.24-14.el7_8
  dbus-libs.x86_64 1:1.10.24-14.el7_8
  device-mapper.x86_64 7:1.02.164-7.el7_8.2
  device-mapper-libs.x86_64 7:1.02.164-7.el7_8.2
  diffutils.x86_64 0:3.3-5.el7
  dracut.x86_64 0:033-568.el7
  elfutils-default-yama-scope.noarch 0:0.176-4.el7
  elfutils-libelf.x86_64 0:0.176-4.el7
  elfutils-libs.x86_64 0:0.176-4.el7
  expat.x86_64 0:2.1.0-11.el7
  file-libs.x86_64 0:5.11-36.el7
  glib2.x86_64 0:2.56.1-5.el7
  glibc.x86_64 0:2.17-307.el7.1
  glibc-common.x86_64 0:2.17-307.el7.1
  hostname.x86_64 0:3.13-3.el7_7.1
  initscripts.x86_64 0:9.49.49-1.el7
  iproute.x86_64 0:4.11.0-25.el7_7.2
  iptables.x86_64 0:1.4.21-34.el7
  kmod.x86_64 0:20-28.el7
  kmod-libs.x86_64 0:20-28.el7
  kpartx.x86_64 0:0.4.9-131.el7
  krb5-libs.x86_64 0:1.15.1-46.el7
  libacl.x86_64 0:2.2.51-15.el7
  libblkid.x86_64 0:2.23.2-63.el7
  libcap.x86_64 0:2.22-11.el7
  libcom_err.x86_64 0:1.42.9-17.el7
  libcurl.x86_64 0:7.29.0-57.el7_8.1
  libdb.x86_64 0:5.3.21-25.el7
  libdb-utils.x86_64 0:5.3.21-25.el7
  libffi.x86_64 0:3.0.13-19.el7
  libgcc.x86_64 0:4.8.5-39.el7
  libmount.x86_64 0:2.23.2-63.el7
  libselinux.x86_64 0:2.5-15.el7
  libsmartcols.x86_64 0:2.23.2-63.el7
  libssh2.x86_64 0:1.8.0-3.el7
  libstdc++.x86_64 0:4.8.5-39.el7
  libuuid.x86_64 0:2.23.2-63.el7
  libxml2.x86_64 0:2.9.1-6.el7.4
  libxml2-python.x86_64 0:2.9.1-6.el7.4
  lz4.x86_64 0:1.7.5-3.el7
  mariadb.x86_64 1:5.5.65-1.el7
  mariadb-libs.x86_64 1:5.5.65-1.el7
  mariadb-server.x86_64 1:5.5.65-1.el7
  nspr.x86_64 0:4.21.0-1.el7
  nss.x86_64 0:3.44.0-7.el7_7
  nss-pem.x86_64 0:1.0.3-7.el7
  nss-softokn.x86_64 0:3.44.0-8.el7_7
  nss-softokn-freebl.x86_64 0:3.44.0-8.el7_7
  nss-sysinit.x86_64 0:3.44.0-7.el7_7
  nss-tools.x86_64 0:3.44.0-7.el7_7
  nss-util.x86_64 0:3.44.0-4.el7_7
  openssl-libs.x86_64 1:1.0.2k-19.el7
  pam.x86_64 0:1.1.8-23.el7
  passwd.x86_64 0:0.79-6.el7
  perl.x86_64 4:5.16.3-295.el7
  perl-Pod-Escapes.noarch 1:1.04-295.el7
  perl-Socket.x86_64 0:2.010-5.el7
  perl-libs.x86_64 4:5.16.3-295.el7
  perl-macros.x86_64 4:5.16.3-295.el7
  procps-ng.x86_64 0:3.3.10-27.el7
  python.x86_64 0:2.7.5-88.el7
  python-chardet.noarch 0:2.2.1-3.el7
  python-libs.x86_64 0:2.7.5-88.el7
  python-urlgrabber.noarch 0:3.10-10.el7
  readline.x86_64 0:6.2-11.el7
  rpm.x86_64 0:4.11.3-43.el7
  rpm-build-libs.x86_64 0:4.11.3-43.el7
  rpm-libs.x86_64 0:4.11.3-43.el7
  rpm-python.x86_64 0:4.11.3-43.el7
  sed.x86_64 0:4.2.2-6.el7
  setup.noarch 0:2.8.71-11.el7
  shadow-utils.x86_64 2:4.6-5.el7
  shared-mime-info.x86_64 0:1.8-5.el7
  sqlite.x86_64 0:3.7.17-8.el7_7.1
  sudo.x86_64 0:1.8.23-9.el7
  systemd.x86_64 0:219-73.el7_8.9
  systemd-libs.x86_64 0:219-73.el7_8.9
  tzdata.noarch 0:2020a-1.el7
  util-linux.x86_64 0:2.23.2-63.el7
  vim-minimal.x86_64 2:7.4.629-6.el7
  yum.noarch 0:3.4.3-167.el7.centos
  yum-plugin-fastestmirror.noarch 0:1.1.31-54.el7_8
  yum-plugin-ovl.noarch 0:1.1.31-54.el7_8
  yum-utils.noarch 0:1.1.31-54.el7_8

Complete!
[root@stdb01 lib]#
[root@stdb01 lib]#
[root@stdb01 lib]# cd /var/run/
[root@stdb01 run]#
[root@stdb01 run]# ll
total 12
drwxr-xr-x  2 root  root   40 Oct 27 06:45 blkid
drwxr-xr-x  2 root  root   40 Apr  1  2020 console
drwx------  2 root  root   40 Oct 27 06:42 cryptsetup
drwxr-xr-x  2 root  root   60 Oct 27 06:42 dbus
drwxr-xr-x  2 root  root   40 Apr  1  2020 faillock
drwxr-xr-x  4 root  root   80 Oct 27 06:42 lock
drwxr-xr-x  3 root  root   60 Oct 27 06:42 log
drwxr-xr-x  2 mysql mysql  40 Apr  2  2020 mariadb
drwxr-xr-x  2 root  root   40 Oct 27 06:42 mount
drwxrwxr-x  2 root  root   40 Apr  1  2020 netreport
-rw-r--r--  1 root  root   40 Oct 27 06:42 nologin
drwxr-xr-x  2 root  root   40 Apr  1  2020 sepermit
drwxr-xr-x  2 root  root   40 Oct 27 06:42 setrans
-rw-r--r--  1 root  root    3 Oct 27 06:42 sshd.pid
drwx--x--x  3 root  root   60 Oct 27 06:42 sudo
drwxr-xr-x 15 root  root  420 Oct 27 06:46 systemd
drwxr-xr-x  3 root  root   80 Oct 27 06:46 udev
drwxr-xr-x  3 root  root   60 Oct 27 06:43 user
-rw-rw-r--  1 root  utmp  384 Oct 27 06:46 utmp
[root@stdb01 run]#
[root@stdb01 run]# systemctl start mariadb
[root@stdb01 run]# systemctl status mariadb
● mariadb.service - MariaDB database server
   Loaded: loaded (/usr/lib/systemd/system/mariadb.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2020-10-27 06:47:35 UTC; 9s ago
  Process: 728 ExecStartPost=/usr/libexec/mariadb-wait-ready $MAINPID (code=exited, status=0/SUCCESS)
  Process: 646 ExecStartPre=/usr/libexec/mariadb-prepare-db-dir %n (code=exited, status=0/SUCCESS)
 Main PID: 727 (mysqld_safe)
   CGroup: /docker/4ce047d2124ffe999fc4d8f4faa1829c3fd3aa877e6e5101e9df46bb4ea1be77/system.slice/mariadb.service
           ├─727 /bin/sh /usr/bin/mysqld_safe --basedir=/usr
           └─888 /usr/libexec/mysqld --basedir=/usr --datadir=/var/lib/mysql --plugin-dir=/us...

Oct 27 06:47:32 stdb01 systemd[1]: Starting MariaDB database server...
Oct 27 06:47:32 stdb01 mariadb-prepare-db-dir[646]: Initializing MariaDB database
Oct 27 06:47:33 stdb01 mariadb-prepare-db-dir[646]: 201027  6:47:33 [Note] /usr/libexec/mys.....
Oct 27 06:47:33 stdb01 mariadb-prepare-db-dir[646]: 201027  6:47:33 [Note] /usr/libexec/mys.....
Oct 27 06:47:33 stdb01 mariadb-prepare-db-dir[646]: PLEASE REMEMBER TO SET A PASSWORD FOR T... !
Oct 27 06:47:33 stdb01 mysqld_safe[727]: 201027 06:47:33 mysqld_safe Logging to '/var/log/...g'.
Oct 27 06:47:33 stdb01 mysqld_safe[727]: 201027 06:47:33 mysqld_safe Starting mysqld daemo...sql
Oct 27 06:47:35 stdb01 systemd[1]: Started MariaDB database server.
Hint: Some lines were ellipsized, use -l to show in full.
[root@stdb01 run]#
[root@stdb01 run]# Connection to host01 closed by remote host.
Connection to host01 closed.