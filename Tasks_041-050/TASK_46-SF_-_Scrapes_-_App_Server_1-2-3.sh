thor@jump_host /$
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
[root@stapp01 ~]# yum install openssh-clients -y

Loaded plugins: fastestmirror, ovl
Determining fastest mirrors
 * base: mirror.alpix.eu
 * extras: mirror.checkdomain.de
 * updates: mirror.checkdomain.de
base                                      | 3.6 kB  00:00:00
extras                                      | 2.9 kB  00:00:00
updates                                      | 2.9 kB  00:00:00
(1/4): base/7/x86_64/group_gz                                      | 153 kB  00:00:00
(2/4): extras/7/x86_64/primary_db                                      | 206 kB  00:00:00
(3/4): updates/7/x86_64/primary_db                                      | 4.5 MB  00:00:00
(4/4): base/7/x86_64/primary_db                                      | 6.1 MB  00:00:00
Resolving Dependencies
--> Running transaction check
---> Package openssh-clients.x86_64 0:7.4p1-21.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================================
 Package                     Arch               Version                  Repository        Size
================================================================================================
Installing:
 openssh-clients             x86_64             7.4p1-21.el7             base             655 k

Transaction Summary
================================================================================================
Install  1 Package

Total download size: 655 k
Installed size: 2.5 M
Downloading packages:
openssh-clients-7.4p1-21.el7.x86_64.rpm                                  | 655 kB  00:00:00
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : openssh-clients-7.4p1-21.el7.x86_64                                          1/1
  Verifying  : openssh-clients-7.4p1-21.el7.x86_64                                          1/1

Installed:
  openssh-clients.x86_64 0:7.4p1-21.el7

Complete!
[root@stapp01 ~]# sudo yum install -y httpd
Loaded plugins: fastestmirror, ovl
Loading mirror speeds from cached hostfile
 * base: mirror.alpix.eu
 * extras: mirror.checkdomain.de
 * updates: mirror.checkdomain.de
Resolving Dependencies
--> Running transaction check
---> Package httpd.x86_64 0:2.4.6-93.el7.centos will be installed
--> Processing Dependency: httpd-tools = 2.4.6-93.el7.centos for package: httpd-2.4.6-93.el7.centos.x86_64
--> Processing Dependency: system-logos >= 7.92.1-1 for package: httpd-2.4.6-93.el7.centos.x86_64
--> Processing Dependency: /etc/mime.types for package: httpd-2.4.6-93.el7.centos.x86_64
--> Processing Dependency: libaprutil-1.so.0()(64bit) for package: httpd-2.4.6-93.el7.centos.x86_64
--> Processing Dependency: libapr-1.so.0()(64bit) for package: httpd-2.4.6-93.el7.centos.x86_64
--> Running transaction check
---> Package apr.x86_64 0:1.4.8-5.el7 will be installed
---> Package apr-util.x86_64 0:1.5.2-6.el7 will be installed
---> Package centos-logos.noarch 0:70.0.6-3.el7.centos will be installed
---> Package httpd-tools.x86_64 0:2.4.6-93.el7.centos will be installed
---> Package mailcap.noarch 0:2.1.41-2.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================================
 Package                 Arch              Version                        Repository       Size
================================================================================================
Installing:
 httpd                   x86_64            2.4.6-93.el7.centos            base            2.7 M
Installing for dependencies:
 apr                     x86_64            1.4.8-5.el7                    base            103 k
 apr-util                x86_64            1.5.2-6.el7                    base             92 k
 centos-logos            noarch            70.0.6-3.el7.centos            base             21 M
 httpd-tools             x86_64            2.4.6-93.el7.centos            base             92 k
 mailcap                 noarch            2.1.41-2.el7                   base             31 k

Transaction Summary
================================================================================================
Install  1 Package (+5 Dependent packages)

Total download size: 24 M
Installed size: 32 M
Downloading packages:
(1/6): apr-util-1.5.2-6.el7.x86_64.rpm                                   |  92 kB  00:00:00
(2/6): apr-1.4.8-5.el7.x86_64.rpm                                        | 103 kB  00:00:00
(3/6): httpd-2.4.6-93.el7.centos.x86_64.rpm                              | 2.7 MB  00:00:00
(4/6): httpd-tools-2.4.6-93.el7.centos.x86_64.rpm                        |  92 kB  00:00:00
(5/6): mailcap-2.1.41-2.el7.noarch.rpm                                   |  31 kB  00:00:00
(6/6): centos-logos-70.0.6-3.el7.centos.noarch.rpm                       |  21 MB  00:00:00
------------------------------------------------------------------------------------------------
Total                                                            55 MB/s |  24 MB  00:00:00
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : apr-1.4.8-5.el7.x86_64                                                       1/6
  Installing : apr-util-1.5.2-6.el7.x86_64                                                  2/6
  Installing : httpd-tools-2.4.6-93.el7.centos.x86_64                                       3/6
  Installing : centos-logos-70.0.6-3.el7.centos.noarch                                      4/6
  Installing : mailcap-2.1.41-2.el7.noarch                                                  5/6
  Installing : httpd-2.4.6-93.el7.centos.x86_64                                             6/6
  Verifying  : mailcap-2.1.41-2.el7.noarch                                                  1/6
  Verifying  : apr-util-1.5.2-6.el7.x86_64                                                  2/6
  Verifying  : httpd-2.4.6-93.el7.centos.x86_64                                             3/6
  Verifying  : apr-1.4.8-5.el7.x86_64                                                       4/6
  Verifying  : httpd-tools-2.4.6-93.el7.centos.x86_64                                       5/6
  Verifying  : centos-logos-70.0.6-3.el7.centos.noarch                                      6/6

Installed:
  httpd.x86_64 0:2.4.6-93.el7.centos

Dependency Installed:
  apr.x86_64 0:1.4.8-5.el7                        apr-util.x86_64 0:1.5.2-6.el7
  centos-logos.noarch 0:70.0.6-3.el7.centos       httpd-tools.x86_64 0:2.4.6-93.el7.centos
  mailcap.noarch 0:2.1.41-2.el7

Complete!
[root@stapp01 ~]# systemctl enable httpd && systemctl start httpd && systemctl status httpd
Created symlink from /etc/systemd/system/multi-user.target.wants/httpd.service to /usr/lib/systemd/system/httpd.service.
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor preset: disabled)
   Active: active (running) since Wed 2020-11-04 08:23:48 UTC; 6ms ago
     Docs: man:httpd(8)
           man:apachectl(8)
 Main PID: 385 (httpd)
   Status: "Processing requests..."
   CGroup: /docker/50a160812513d914d8f1193f53f92dc96ed011d61881bbd0b20d506d820e61f8/system.slice/httpd.service
           ├─385 /usr/sbin/httpd -DFOREGROUND
           ├─387 /usr/sbin/httpd -DFOREGROUND
           ├─388 /usr/sbin/httpd -DFOREGROUND
           ├─389 /usr/sbin/httpd -DFOREGROUND
           ├─390 /usr/sbin/httpd -DFOREGROUND
           └─391 /usr/sbin/httpd -DFOREGROUND

Nov 04 08:23:48 stapp01 systemd[1]: Starting The Apache HTTP Server...
Nov 04 08:23:48 stapp01 httpd[385]: AH00558: httpd: Could not reliably determine the serve...age
Nov 04 08:23:48 stapp01 systemd[1]: Started The Apache HTTP Server.
Hint: Some lines were ellipsized, use -l to show in full.
[root@stapp01 ~]#
[root@stapp01 ~]#
[root@stapp01 ~]# cd /etc/httpd/conf
[root@stapp01 conf]# grep -n -i listen httpd.conf
34:# Listen: Allows you to bind Apache to specific IP addresses and/or
38:# Change this to Listen on specific IP addresses as shown below to
41:#Listen 12.34.56.78:80
42:Listen 80
[root@stapp01 conf]# sed -i 42s/80/8080/ httpd.conf
[root@stapp01 conf]# grep -n -i listen httpd.conf
34:# Listen: Allows you to bind Apache to specific IP addresses and/or
38:# Change this to Listen on specific IP addresses as shown below to
41:#Listen 12.34.56.78:80
42:Listen 8080
[root@stapp01 conf]# systemctl reload httpd && systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor preset: disabled)
   Active: active (running) since Wed 2020-11-04 08:23:48 UTC; 44s ago
     Docs: man:httpd(8)
           man:apachectl(8)
  Process: 398 ExecReload=/usr/sbin/httpd $OPTIONS -k graceful (code=exited, status=0/SUCCESS)
 Main PID: 385 (httpd)
   Status: "Total requests: 0; Current requests/sec: 0; Current traffic:   0 B/sec"
   CGroup: /docker/50a160812513d914d8f1193f53f92dc96ed011d61881bbd0b20d506d820e61f8/system.slice/httpd.service
           ├─385 /usr/sbin/httpd -DFOREGROUND
           ├─399 /usr/sbin/httpd -DFOREGROUND
           ├─400 /usr/sbin/httpd -DFOREGROUND
           ├─401 /usr/sbin/httpd -DFOREGROUND
           ├─402 /usr/sbin/httpd -DFOREGROUND
           └─403 /usr/sbin/httpd -DFOREGROUND

Nov 04 08:23:48 stapp01 systemd[1]: Starting The Apache HTTP Server...
Nov 04 08:23:48 stapp01 httpd[385]: AH00558: httpd: Could not reliably determine the serve...age
Nov 04 08:23:48 stapp01 systemd[1]: Started The Apache HTTP Server.
Nov 04 08:24:32 stapp01 systemd[1]: Reloading The Apache HTTP Server.
Nov 04 08:24:32 stapp01 httpd[398]: AH00558: httpd: Could not reliably determine the serve...age
Nov 04 08:24:32 stapp01 systemd[1]: Reloaded The Apache HTTP Server.
Hint: Some lines were ellipsized, use -l to show in full.

-----------------------------------------------------------------------------------------------------------------

# SUPPORTING FILE 

# This is a supporting file for the Task of the same name.
# This may contain configurations/config file.
# Basically, any file that is edited/created/modified through the 'vi' or 'nano' command will appear here.
# Note that there may be more than one supporting files for the Task at hand.

-----------------------------------------------------------------------------------------------------------------

TASK 46 - SF - Scrapes - App Server 1-2-3.sh

[root@stapp01 conf]# ll /var/www/html
total 0
[root@stapp01 conf]# ll /tmp
total 16
drwxr-xr-x  2 tony tony 4096 Nov  4 08:26 apps
-rwx------ 50 root root  836 Aug  1  2019 ks-script-rnBCJB
drwxr-xr-x  2 tony tony 4096 Nov  4 08:26 media
drwx------  3 root root 4096 Nov  4 08:23 systemd-private-8bcf295c866340ce8036bc794378964d-httpd.service-hfSlt9
-rw------- 50 root root    0 Aug  1  2019 yum.log
[root@stapp01 conf]# mv /tmp/media /tmp/apps /var/www/html
[root@stapp01 conf]# ll /var/www/html
total 8
drwxr-xr-x 2 tony tony 4096 Nov  4 08:26 apps
drwxr-xr-x 2 tony tony 4096 Nov  4 08:26 media
[root@stapp01 conf]#
[root@stapp01 conf]# curl -4 http://stapp01:8080/media/
<!DOCTYPE html>
<html>
<body>

<h1>KodeKloud</h1>

<p>This is a sample page for our media website</p>

</body>
</html>[root@stapp01 conf]# curl -4 http://stapp01:8080/apps/
<!DOCTYPE html>
<html>
<body>

<h1>KodeKloud</h1>

<p>This is a sample page for our apps website</p>

</body>
[root@stapp01 conf]# Connection to host01 closed by remote host.
Connection to host01 closed.