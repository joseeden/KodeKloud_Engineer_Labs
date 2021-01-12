
-----------------------------------------------------------------------------------------------------------------

# SUPPORTING FILE 

# This is a supporting file for the Task of the same name.
# This may contain configurations/config file.
# Basically, any file that is edited/created/modified through the 'vi' or 'nano' command will appear here.
# Note that there may be more than one supporting files for the Task at hand.

-----------------------------------------------------------------------------------------------------------------

TASK 37 - SupportFile - Linux Process Troubleshooting 


thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
Warning: Permanently added '172.16.238.10' (ECDSA) to the list of known hosts.
sudo su -
******
[tony@stapp01 ~]$ sudo su -

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for tony:
[root@stapp01 ~]#[root@stapp01 ~]# systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: inactive (dead)
     Docs: man:httpd(8)
           man:apachectl(8)
[root@stapp01 ~]#
[root@stapp01 ~]# httpd -t
AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.16.238.10. Set the 'ServerName' directive globally to suppress this message
Syntax OK
[root@stapp01 ~]# systemctl enable httpd
Created symlink from /etc/systemd/system/multi-user.target.wants/httpd.service to /usr/lib/systemd/system/httpd.service.
[root@stapp01 ~]#
[root@stapp01 ~]# systemctl start httpd
Job for httpd.service failed because the control process exited with error code. See "systemctl status httpd.service" and"journalctl -xe" for details.
[root@stapp01 ~]#
[root@stapp01 ~]# systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor preset: disabled)
   Active: failed (Result: exit-code) since Wed 2020-09-09 20:02:33 UTC; 394ms ago
     Docs: man:httpd(8)
           man:apachectl(8)
  Process: 366 ExecStop=/bin/kill -WINCH ${MAINPID} (code=exited, status=1/FAILURE)
  Process: 365 ExecStart=/usr/sbin/httpd $OPTIONS -DFOREGROUND (code=exited, status=1/FAILURE)
 Main PID: 365 (code=exited, status=1/FAILURE)

Sep 09 20:02:33 stapp01 httpd[365]: AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.16.238.10. Set the 'ServerName' directive global...s this message
Sep 09 20:02:33 stapp01 httpd[365]: (98)Address already in use: AH00072: make_sock: could not bind to address 0.0.0.0:6100
Sep 09 20:02:33 stapp01 httpd[365]: no listening sockets available, shutting down
Sep 09 20:02:33 stapp01 httpd[365]: AH00015: Unable to open logs
Sep 09 20:02:33 stapp01 systemd[1]: httpd.service: main process exited, code=exited, status=1/FAILURE
Sep 09 20:02:33 stapp01 kill[366]: kill: cannot find process ""
Sep 09 20:02:33 stapp01 systemd[1]: httpd.service: control process exited, code=exited status=1
Sep 09 20:02:33 stapp01 systemd[1]: Failed to start The Apache HTTP Server.
Sep 09 20:02:33 stapp01 systemd[1]: Unit httpd.service entered failed state.
Sep 09 20:02:33 stapp01 systemd[1]: httpd.service failed.
Hint: Some lines were ellipsized, use -l to show in full.
[root@stapp01 ~]#
[root@stapp01 ~]# httpd -t
AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.16.238.10. Set the 'ServerName' directive globally to suppress this message
Syntax OK
[root@stapp01 ~]#
[root@stapp01 ~]# cat /etc/httpd/conf/httpd.conf | grep Listen
# Listen: Allows you to bind Apache to specific IP addresses and/or
# Change this to Listen on specific IP addresses as shown below to
#Listen 12.34.56.78:80
Listen 6100
[root@stapp01 ~]#
[root@stapp01 ~]# yum install -y net-tools
Loaded plugins: fastestmirror, ovl
Determining fastest mirrors
epel/x86_64/metalink                                                     |  30 kB  00:00:00
 * base: mirror.plustech.de
 * epel: mirrors.n-ix.net
 * extras: mirror.checkdomain.de
 * remi-php72: mirror.23media.com
 * remi-safe: mirror.23media.com
 * updates: mirror.alpix.eu
base                                                     | 3.6 kB  00:00:00
epel                                                     | 4.7 kB  00:00:00
extras                                                     | 2.9 kB  00:00:00
remi-php72                                                     | 3.0 kB  00:00:00
remi-safe                                                     | 3.0 kB  00:00:00
updates                                                     | 2.9 kB  00:00:00
(1/9): base/7/x86_64/primary_db                                                     | 6.1 MB  00:00:00
(2/9): extras/7/x86_64/primary_db                                                     | 206 kB  00:00:00
(3/9): epel/x86_64/group_gz                                                     |  95 kB  00:00:00
(4/9): epel/x86_64/updateinfo                                                     | 1.0 MB  00:00:00
(5/9): epel/x86_64/primary_db                                                     | 6.9 MB  00:00:00
(7/9): remi-php72/primary_db                                                         68% [================================(6/9): remi-php72/primary_db                                                     | 239 kB  00:00:00
(7/9): base/7/x86_64/group_gz                                                     | 153 kB  00:00:00
(8/9): updates/7/x86_64/primary_db                                                     | 4.5 MB  00:00:00
(9/9): remi-safe/primary_db                                                     | 1.8 MB  00:00:00
Package net-tools-2.0-0.25.20131004git.el7.x86_64 already installed and latest version
Nothing to do
[root@stapp01 ~]# netstat -tulpen
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       User       Inode      PID/Program name
tcp        0      0 127.0.0.11:33124        0.0.0.0:*               LISTEN      0          31297      -
tcp        0      0 0.0.0.0:111             0.0.0.0:*               LISTEN      0          40233      1/init
tcp        0      0 127.0.0.1:6100          0.0.0.0:*               LISTEN      0          47386      333/sendmail: accep
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      0          42114      213/sshd
tcp6       0      0 :::111                  :::*                    LISTEN      0          39596      170/rpcbind
tcp6       0      0 :::22                   :::*                    LISTEN      0          42116      213/sshd
udp        0      0 0.0.0.0:111             0.0.0.0:*                           0          40234      1/init
udp        0      0 127.0.0.11:38146        0.0.0.0:*                           0          31296      -
udp        0      0 0.0.0.0:756             0.0.0.0:*                           0          39592      170/rpcbind
udp6       0      0 :::111                  :::*                                0          39593      170/rpcbind
udp6       0      0 :::756                  :::*                                0          39595      170/rpcbind
[root@stapp01 ~]#
[root@stapp01 ~]# netstat -tulpen | grep 6100
tcp        0      0 127.0.0.1:6100          0.0.0.0:*               LISTEN      0          47386      333/sendmail: accep
[root@stapp01 ~]#
[root@stapp01 ~]# sudo kill -9 333
[root@stapp01 ~]#
[root@stapp01 ~]# systemctl enable httpd
[root@stapp01 ~]#
[root@stapp01 ~]# systemctl start httpd
[root@stapp01 ~]#
[root@stapp01 ~]# systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor preset: disabled)
   Active: active (running) since Wed 2020-09-09 20:03:34 UTC; 9ms ago
     Docs: man:httpd(8)
           man:apachectl(8)
 Main PID: 580 (httpd)
   Status: "Processing requests..."
   CGroup: /docker/ba06aa3cc3429ad046e8ee0b2671637432a5ecb7c732eb0bcac8ed31f281bde9/system.slice/httpd.service
           ├─580 /usr/sbin/httpd -DFOREGROUND
           ├─581 /usr/sbin/httpd -DFOREGROUND
           ├─583 /usr/sbin/httpd -DFOREGROUND
           ├─584 /usr/sbin/httpd -DFOREGROUND
           ├─585 /usr/sbin/httpd -DFOREGROUND
           └─586 /usr/sbin/httpd -DFOREGROUND

Sep 09 20:03:34 stapp01 systemd[1]: Starting The Apache HTTP Server...
Sep 09 20:03:34 stapp01 httpd[580]: AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.16.238.10. Set the 'ServerName' directive global...s this message
Sep 09 20:03:34 stapp01 systemd[1]: Started The Apache HTTP Server.
Hint: Some lines were ellipsized, use -l to show in full.
[root@stapp01 ~]#
[root@stapp01 ~]# Connection to host01 closed by remote host.
Connection to host01 closed.

The environment has expired.

Please refresh to get a new environment.