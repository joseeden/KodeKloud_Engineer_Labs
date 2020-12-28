

thor@jump_host /$ sudo su -
We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for thor:
Sorry, try again.
[sudo] password for thor:
Sorry, try again.
[sudo] password for thor:
[root@jump_host ~]#[root@jump_host ~]# yum info openssh-clients
Loaded plugins: fastestmirror, ovl

Repodata is over 2 weeks old. Install yum-cron? Or run: yum makecache fast
Determining fastest mirrors
 * base: mirror.softaculous.com
 * epel: d2lzkl7pfhq30w.cloudfront.net
 * extras: mirror2.hs-esslingen.de
 * updates: mirror.netcologne.de
Installed Packages
Name        : openssh-clients
Arch        : x86_64
Version     : 7.4p1
Release     : 21.el7
Size        : 2.5 M
Repo        : installed
From repo   : base
Summary     : An open source SSH client applications
URL         : http://www.openssh.com/portable.html
License     : BSD
Description : OpenSSH is a free version of SSH (Secure SHell), a program for logging
            : into and executing commands on a remote machine. This package includes
            : the clients necessary to make encrypted connections to SSH servers.

[root@jump_host ~]# sudo yum install -y openssh-clients
Loaded plugins: fastestmirror, ovl
Loading mirror speeds from cached hostfile
epel/x86_64/metalink                                                                                                                  |  15 kB  00:00:00
 * base: mirror.softaculous.com
 * epel: mirrors.n-ix.net
 * extras: mirror2.hs-esslingen.de
 * updates: mirror.netcologne.de
base                                                                     | 3.6 kB  00:00:00
epel                                                                     | 4.7 kB  00:00:00
extras                                                                   | 2.9 kB  00:00:00
updates                                                                  | 2.9 kB  00:00:00
(1/5): extras/7/x86_64/primary_db                                        | 206 kB  00:00:00
(2/5): epel/x86_64/updateinfo                                            | 1.0 MB  00:00:00
(3/5): epel/x86_64/group_gz                                              |  95 kB  00:00:00
(4/5): updates/7/x86_64/primary_db                                       | 4.5 MB  00:00:00
(5/5): epel/x86_64/primary_db                                            | 6.9 MB  00:00:00
Package openssh-clients-7.4p1-21.el7.x86_64 already installed and latest version
Nothing to do
[root@jump_host ~]#
[root@jump_host ~]# sudo scp -r /tmp/index.html natasha@172.16.238.15:/tmp
The authenticity of host '172.16.238.15 (172.16.238.15)' can't be established.
ECDSA key fingerprint is SHA256:YgD6FCVadIeGhbhs+WXBkEj2YwTTaS1PSSxbTtlTsrw.
ECDSA key fingerprint is MD5:50:05:d4:8e:27:af:b7:fe:2d:c6:ea:28:b4:c2:15:83.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '172.16.238.15' (ECDSA) to the list of known hosts.
natasha@172.16.238.15's password:
index.html                           100%    0     0.0KB/s   00:00
[root@jump_host ~]# Connection to host01 closed by remote host.
Connection to host01 closed.

The environment has expired.

Please refresh to get a new environment.
