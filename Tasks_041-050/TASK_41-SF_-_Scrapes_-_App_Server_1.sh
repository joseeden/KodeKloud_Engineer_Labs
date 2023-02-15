
-----------------------------------------------------------------------------------------------------------------

# SUPPORTING FILE 

# This is a supporting file for the Task of the same name.
# This may contain configurations/config file.
# Basically, any file that is edited/created/modified through the 'vi' or 'nano' command will appear here.
# Note that there may be more than one supporting files for the Task at hand.

-----------------------------------------------------------------------------------------------------------------

TASK 41 - SF - Scrapes - App Server 1.sh


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
[root@stapp01 ~]# systemctl enable httpd
Created symlink from /etc/systemd/system/multi-user.target.wants/httpd.service to /usr/lib/systemd/system/httpd.service.
[root@stapp01 ~]# systemctl start httpd
Job for httpd.service failed because the control process exited with error code. See "systemctl status httpd.service" and "journalctl -xe" for details.
[root@stapp01 ~]# systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor preset: disabled)
   Active: failed (Result: exit-code) since Mon 2020-09-14 17:08:53 UTC; 7ms ago
     Docs: man:httpd(8)
           man:apachectl(8)
  Process: 384 ExecStop=/bin/kill -WINCH ${MAINPID} (code=exited, status=1/FAILURE)
  Process: 383 ExecStart=/usr/sbin/httpd $OPTIONS -DFOREGROUND (code=exited, status=1/FAILURE)
 Main PID: 383 (code=exited, status=1/FAILURE)

Sep 14 17:08:53 stapp01 httpd[383]: AH00558: httpd: Could not reliably determine the server's fully...ssage
Sep 14 17:08:53 stapp01 httpd[383]: (98)Address already in use: AH00072: make_sock: could not bind ...:5003
Sep 14 17:08:53 stapp01 httpd[383]: no listening sockets available, shutting down
Sep 14 17:08:53 stapp01 httpd[383]: AH00015: Unable to open logs
Sep 14 17:08:53 stapp01 systemd[1]: httpd.service: main process exited, code=exited, status=1/FAILURE
Sep 14 17:08:53 stapp01 kill[384]: kill: cannot find process ""
Sep 14 17:08:53 stapp01 systemd[1]: httpd.service: control process exited, code=exited status=1
Sep 14 17:08:53 stapp01 systemd[1]: Failed to start The Apache HTTP Server.
Sep 14 17:08:53 stapp01 systemd[1]: Unit httpd.service entered failed state.
Sep 14 17:08:53 stapp01 systemd[1]: httpd.service failed.
Hint: Some lines were ellipsized, use -l to show in full.
[root@stapp01 ~]#
[root@stapp01 ~]#
[root@stapp01 ~]# netstat -tulpn
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 127.0.0.1:5003          0.0.0.0:*               LISTEN      291/sendmail: accep
tcp        0      0 127.0.0.11:39500        0.0.0.0:*               LISTEN      -
tcp        0      0 0.0.0.0:111             0.0.0.0:*               LISTEN      1/init
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      109/sshd
tcp6       0      0 :::111                  :::*                    LISTEN      62/rpcbind
tcp6       0      0 :::22                   :::*                    LISTEN      109/sshd
udp        0      0 127.0.0.11:32871        0.0.0.0:*                           -
udp        0      0 0.0.0.0:111             0.0.0.0:*                           1/init
udp        0      0 0.0.0.0:656             0.0.0.0:*                           62/rpcbind
udp6       0      0 :::111                  :::*                                62/rpcbind
udp6       0      0 :::656                  :::*                                62/rpcbind
[root@stapp01 ~]# netstat -tulpn | grep 5003
tcp        0      0 127.0.0.1:5003          0.0.0.0:*               LISTEN      291/sendmail: accep
[root@stapp01 ~]#
[root@stapp01 ~]# sudo kill -9 291
[root@stapp01 ~]#
[root@stapp01 ~]# systemctl enable httpd
[root@stapp01 ~]# systemctl start httpd
[root@stapp01 ~]# systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor preset: disabled)
   Active: active (running) since Mon 2020-09-14 17:09:19 UTC; 8ms ago
     Docs: man:httpd(8)
           man:apachectl(8)
 Main PID: 410 (httpd)
   Status: "Processing requests..."
   CGroup: /docker/de1b5afb5aa3c5be59a17ebd135a8ea6bfb8d02f087c4387b0beb66b4d68c34a/system.slice/httpd.service
           ├─410 /usr/sbin/httpd -DFOREGROUND
           ├─412 /usr/sbin/httpd -DFOREGROUND
           └─413 /usr/sbin/httpd -DFOREGROUND

Sep 14 17:09:19 stapp01 systemd[1]: Starting The Apache HTTP Server...
Sep 14 17:09:19 stapp01 httpd[410]: AH00558: httpd: Could not reliably determine the server's fully...ssage
Sep 14 17:09:19 stapp01 systemd[1]: Started The Apache HTTP Server.
Hint: Some lines were ellipsized, use -l to show in full.
[root@stapp01 ~]#
[root@stapp01 ~]# systemctl enable iptables
Created symlink from /etc/systemd/system/basic.target.wants/iptables.service to /usr/lib/systemd/system/iptables.service.
[root@stapp01 ~]# systemctl start iptables
[root@stapp01 ~]# systemctl status iptables
● iptables.service - IPv4 firewall with iptables
   Loaded: loaded (/usr/lib/systemd/system/iptables.service; enabled; vendor preset: disabled)
   Active: active (exited) since Mon 2020-09-14 17:08:36 UTC; 52s ago
 Main PID: 318 (code=exited, status=0/SUCCESS)
   CGroup: /docker/de1b5afb5aa3c5be59a17ebd135a8ea6bfb8d02f087c4387b0beb66b4d68c34a/system.slice/iptables.service

Sep 14 17:08:36 stapp01 systemd[1]: Starting IPv4 firewall with iptables...
Sep 14 17:08:36 stapp01 iptables.init[318]: iptables: Applying firewall rules: [  OK  ]
Sep 14 17:08:36 stapp01 systemd[1]: Started IPv4 firewall with iptables.
[root@stapp01 ~]#
[root@stapp01 ~]# iptables -L
Chain INPUT (policy ACCEPT)
target     prot opt source               destination
ACCEPT     all  --  anywhere             anywhere             state RELATED,ESTABLISHED
ACCEPT     icmp --  anywhere             anywhere
ACCEPT     all  --  anywhere             anywhere
ACCEPT     tcp  --  anywhere             anywhere             state NEW tcp dpt:ssh
REJECT     all  --  anywhere             anywhere             reject-with icmp-host-prohibited

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination
REJECT     all  --  anywhere             anywhere             reject-with icmp-host-prohibited

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination
[root@stapp01 ~]# iptables -L INPUT -nv
Chain INPUT (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination
  240 16095 ACCEPT     all  --  *      *       0.0.0.0/0            0.0.0.0/0            state RELATED,ESTABLISHED
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0
    4   323 ACCEPT     all  --  lo     *       0.0.0.0/0            0.0.0.0/0
    1    60 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            state NEW tcp dpt:22
   41  2460 REJECT     all  --  *      *       0.0.0.0/0            0.0.0.0/0            reject-with icmp-host-prohibited
[root@stapp01 ~]#
[root@stapp01 ~]# iptables -IINPUT -p tcp --destination-port 5003 -j ACCEPT
[root@stapp01 ~]#
[root@stapp01 ~]# iptables -L
Chain INPUT (policy ACCEPT)
target     prot opt source               destination
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:fmpro-internal
ACCEPT     all  --  anywhere             anywhere             state RELATED,ESTABLISHED
ACCEPT     icmp --  anywhere             anywhere
ACCEPT     all  --  anywhere             anywhere
ACCEPT     tcp  --  anywhere             anywhere             state NEW tcp dpt:ssh
REJECT     all  --  anywhere             anywhere             reject-with icmp-host-prohibited

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination
REJECT     all  --  anywhere             anywhere             reject-with icmp-host-prohibited

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination
[root@stapp01 ~]# iptables -L INPUT -nv
Chain INPUT (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination
    0     0 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp dpt:5003
  344 21807 ACCEPT     all  --  *      *       0.0.0.0/0            0.0.0.0/0            state RELATED,ESTABLISHED
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0
    4   323 ACCEPT     all  --  lo     *       0.0.0.0/0            0.0.0.0/0
    1    60 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            state NEW tcp dpt:22
   74  4440 REJECT     all  --  *      *       0.0.0.0/0            0.0.0.0/0            reject-with icmp-host-prohibited
[root@stapp01 ~]#
[root@stapp01 ~]# service iptables save
iptables: Saving firewall rules to /etc/sysconfig/iptables:[  OK  ]
[root@stapp01 ~]#
[root@stapp01 ~]# iptables save
Bad argument `save'
Try `iptables -h' or 'iptables --help' for more information.
[root@stapp01 ~]#
[root@stapp01 ~]# systemctl enable iptables
[root@stapp01 ~]# systemctl start iptables
[root@stapp01 ~]# systemctl status iptables
● iptables.service - IPv4 firewall with iptables
   Loaded: loaded (/usr/lib/systemd/system/iptables.service; enabled; vendor preset: disabled)
   Active: active (exited) since Mon 2020-09-14 17:08:36 UTC; 2min 19s ago
 Main PID: 318 (code=exited, status=0/SUCCESS)
   CGroup: /docker/de1b5afb5aa3c5be59a17ebd135a8ea6bfb8d02f087c4387b0beb66b4d68c34a/system.slice/iptables.service

Sep 14 17:08:36 stapp01 systemd[1]: Starting IPv4 firewall with iptables...
Sep 14 17:08:36 stapp01 iptables.init[318]: iptables: Applying firewall rules: [  OK  ]
Sep 14 17:08:36 stapp01 systemd[1]: Started IPv4 firewall with iptables.
[root@stapp01 ~]#
[root@stapp01 ~]# Connection to host01 closed by remote host.
Connection to host01 closed.

The environment has expired.

Please refresh to get a new environment.