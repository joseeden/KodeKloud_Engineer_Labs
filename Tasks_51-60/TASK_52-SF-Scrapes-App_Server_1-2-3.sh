
-----------------------------------------------------------------------------------------------------------------

# SUPPORTING FILE 

# This is a supporting file for the Task of the same name.
# This may contain configurations/config file.
# Basically, any file that is edited/created/modified through the 'vi' or 'nano' command will appear here.
# Note that there may be more than one supporting files for the Task at hand.

-----------------------------------------------------------------------------------------------------------------

TASK_52-SF-Scrapes-App_erver 1-2-3.sh


thor@jump_host /$
thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
Warning: Permanently added '172.16.238.12' (ECDSA) to the list of known hosts.
sudo su -
******[banner@stapp03 ~]$ sudo su -

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for banner:
[root@stapp03 ~]#
[root@stapp03 ~]# sudo yum install httpd -y
Loaded plugins: fastestmirror, ovl


Determining fastest mirrors
epel/x86_64/metalink                                                         |  16 kB  00:00:00
 * base: ftp.plusline.net
 * epel: ftp.plusline.net
 * extras: mirror.checkdomain.de
 * remi-php72: mirror.dogado.de
 * remi-safe: mirror.dogado.de
 * updates: mirror.softaculous.com
base                                                                                                                                  | 3.6 kB  00:00:00
epel                                                                                                                                  | 4.7 kB  00:00:00
extras                                                                                                                                | 2.9 kB  00:00:00
remi-php72                                                                                                                            | 3.0 kB  00:00:00
remi-safe                                                                                                                             | 3.0 kB  00:00:00
updates                                                                                                                               | 2.9 kB  00:00:00
(1/9): base/7/x86_64/group_gz                                                                                                         | 153 kB  00:00:00
(2/9): epel/x86_64/group_gz                                                                                                           |  95 kB  00:00:00
(3/9): extras/7/x86_64/primary_db                                                                                                     | 222 kB  00:00:00
(4/9): epel/x86_64/primary_db                                                                                                         | 6.9 MB  00:00:00
(5/9): remi-safe/primary_db                                                                                                           | 1.8 MB  00:00:00
(6/9): remi-php72/primary_db                                                                                                          | 241 kB  00:00:00
(7/9): base/7/x86_64/primary_db                                                                                                       | 6.1 MB  00:00:00
(8/9): epel/x86_64/updateinfo                                                                                                         | 1.0 MB  00:00:00
(9/9): updates/7/x86_64/primary_db                                                                                                    | 3.7 MB  00:00:00
Resolving Dependencies
--> Running transaction check
---> Package httpd.x86_64 0:2.4.6-90.el7.centos will be updated
---> Package httpd.x86_64 0:2.4.6-97.el7.centos will be an update
--> Processing Dependency: httpd-tools = 2.4.6-97.el7.centos for package: httpd-2.4.6-97.el7.centos.x86_64
--> Running transaction check
---> Package httpd-tools.x86_64 0:2.4.6-90.el7.centos will be updated
---> Package httpd-tools.x86_64 0:2.4.6-97.el7.centos will be an update
--> Finished Dependency Resolution

Dependencies Resolved

=============================================================================================================================================================
 Package                              Arch                            Version                                         Repository                        Size
=============================================================================================================================================================
Updating:
 httpd                                x86_64                          2.4.6-97.el7.centos                             updates                          2.7 M
Updating for dependencies:
 httpd-tools                          x86_64                          2.4.6-97.el7.centos                             updates                           93 k

Transaction Summary
=============================================================================================================================================================
Upgrade  1 Package (+1 Dependent package)

Total download size: 2.8 M
Downloading packages:
Delta RPMs disabled because /usr/bin/applydeltarpm not installed.
(1/2): httpd-tools-2.4.6-97.el7.centos.x86_64.rpm                                                                                     |  93 kB  00:00:00
(2/2): httpd-2.4.6-97.el7.centos.x86_64.rpm                                                                                           | 2.7 MB  00:00:00
-------------------------------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                                        6.6 MB/s | 2.8 MB  00:00:00
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Updating   : httpd-tools-2.4.6-97.el7.centos.x86_64                                                                                                    1/4
  Updating   : httpd-2.4.6-97.el7.centos.x86_64                                                                                                          2/4
  Cleanup    : httpd-2.4.6-90.el7.centos.x86_64                                                         3/4
  Cleanup    : httpd-tools-2.4.6-90.el7.centos.x86_64                                                         4/4
  Verifying  : httpd-2.4.6-97.el7.centos.x86_64                                             1/4
  Verifying  : httpd-tools-2.4.6-97.el7.centos.x86_64                                       2/4
  Verifying  : httpd-tools-2.4.6-90.el7.centos.x86_64                                       3/4
  Verifying  : httpd-2.4.6-90.el7.centos.x86_64                                             4/4

Updated:
  httpd.x86_64 0:2.4.6-97.el7.centos

Dependency Updated:
  httpd-tools.x86_64 0:2.4.6-97.el7.centos

Complete!
[root@stapp03 ~]# sudo systemctl restart httpd
[root@stapp03 ~]# systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: active (running) since Wed 2020-11-25 14:01:11 UTC; 85ms ago
     Docs: man:httpd(8)
           man:apachectl(8)
 Main PID: 441 (httpd)
   Status: "Processing requests..."
   CGroup: /docker/80471e30d7e9a686d6ec9de7d5029dcec0d170674636827540555e3b944e1969/system.slice/httpd.service
           ├─441 /usr/sbin/httpd -DFOREGROUND
           ├─442 /usr/sbin/httpd -DFOREGROUND
           ├─444 /usr/sbin/httpd -DFOREGROUND
           ├─445 /usr/sbin/httpd -DFOREGROUND
           ├─446 /usr/sbin/httpd -DFOREGROUND
           └─447 /usr/sbin/httpd -DFOREGROUND

Nov 25 14:01:11 stapp03 systemd[1]: Starting The Apache HTTP Server...
Nov 25 14:01:11 stapp03 httpd[441]: AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.16.238.12. ...is message
Nov 25 14:01:11 stapp03 systemd[1]: Started The Apache HTTP Server.
Hint: Some lines were ellipsized, use -l to show in full.
[root@stapp03 ~]#
[root@stapp03 ~]#
[root@stapp03 ~]# sudo vi /etc/httpd/conf/httpd.conf
[root@stapp03 ~]# sudo systemctl restart httpd
[root@stapp03 ~]# systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: active (running) since Wed 2020-11-25 14:05:50 UTC; 2s ago
     Docs: man:httpd(8)
           man:apachectl(8)
  Process: 469 ExecStop=/bin/kill -WINCH ${MAINPID} (code=exited, status=0/SUCCESS)
 Main PID: 472 (httpd)
   Status: "Processing requests..."
   CGroup: /docker/80471e30d7e9a686d6ec9de7d5029dcec0d170674636827540555e3b944e1969/system.slice/httpd.service
           ├─472 /usr/sbin/httpd -DFOREGROUND
           ├─473 /usr/sbin/httpd -DFOREGROUND
           ├─474 /usr/sbin/httpd -DFOREGROUND
           ├─475 /usr/sbin/httpd -DFOREGROUND
           ├─476 /usr/sbin/httpd -DFOREGROUND
           └─477 /usr/sbin/httpd -DFOREGROUND

Nov 25 14:05:50 stapp03 systemd[1]: Starting The Apache HTTP Server...
Nov 25 14:05:50 stapp03 systemd[1]: Started The Apache HTTP Server.
[root@stapp03 ~]# Connection to host01 closed by remote host.
Connection to host01 closed.

The environment has expired.

Please refresh to get a new environment.