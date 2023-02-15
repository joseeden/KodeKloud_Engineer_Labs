
-----------------------------------------------------------------------------------------------------------------

# SUPPORTING FILE 

# This is a supporting file for the Task of the same name.
# This may contain configurations/config file.
# Basically, any file that is edited/created/modified through the 'vi' or 'nano' command will appear here.
# Note that there may be more than one supporting files for the Task at hand.

-----------------------------------------------------------------------------------------------------------------

TASK 38 - SupportFile - Install And Configure SFTP


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
[root@stapp01 ~]# useradd -d /var/www/webdata -s /sbin/nologin yousufuseradd: cannot create directory /var/www/webdata
[root@stapp01 ~]# passwd yousuf
Changing password for user yousuf.
New password:
Retype new password:
passwd: all authentication tokens updated successfully.
[root@stapp01 ~]#
[root@stapp01 ~]# mkdir -p /var/www/webdata
[root@stapp01 ~]# chown yousuf:yousuf /var/www/webdata
[root@stapp01 ~]# chown root:root /var/www/webdata
[root@stapp01 ~]# chmod 755 /var/www/webdata
[root@stapp01 ~]#
[root@stapp01 ~]# vi /etc/ssh/sshd_config
[root@stapp01 ~]#
[root@stapp01 ~]#
[root@stapp01 ~]# systemctl restart sshd
Job for sshd.service failed because the control process exited with error code. See "systemctl status sshd.service" and "journalctl -xe" for details.
[root@stapp01 ~]# systemctl status sshd
● sshd.service - OpenSSH server daemon
   Loaded: loaded (/usr/lib/systemd/system/sshd.service; enabled; vendor preset: enabled)
   Active: activating (auto-restart) (Result: exit-code) since Fri 2020-09-11 08:34:12 UTC; 9ms ago
     Docs: man:sshd(8)
           man:sshd_config(5)
  Process: 177 ExecStart=/usr/sbin/sshd -D $OPTIONS (code=exited, status=255)
 Main PID: 177 (code=exited, status=255)
   CGroup: /docker/f71fdf3ab52a471a395149eb026075185359d7f3aa130c03f6cab26257df373f/system.slice/sshd.service
           ├─124 sshd: tony [priv]
           ├─126 sshd: tony@pts/0
           └─127 -bash

Sep 11 08:34:12 stapp01 sshd[177]: /etc/ssh/sshd_config line 149: Directive 'Subsystem' is not allowed within a Match block
Sep 11 08:34:12 stapp01 systemd[1]: Converting job sshd.service/restart -> sshd.service/start
Sep 11 08:34:12 stapp01 systemd[1]: About to execute: /usr/sbin/sshd -D $OPTIONS
Sep 11 08:34:12 stapp01 systemd[1]: Forked /usr/sbin/sshd as 177
Sep 11 08:34:12 stapp01 systemd[1]: sshd.service changed dead -> start
Sep 11 08:34:12 stapp01 systemd[1]: Starting OpenSSH server daemon...
[root@stapp01 ~]#
[root@stapp01 ~]# vi /etc/ssh/sshd_config
[root@stapp01 ~]#
[root@stapp01 ~]# systemctl status sshd
● sshd.service - OpenSSH server daemon
   Loaded: loaded (/usr/lib/systemd/system/sshd.service; enabled; vendor preset: enabled)
   Active: activating (auto-restart) (Result: exit-code) since Fri 2020-09-11 08:34:54 UTC; 29s ago
     Docs: man:sshd(8)
           man:sshd_config(5)
  Process: 180 ExecStart=/usr/sbin/sshd -D $OPTIONS (code=exited, status=255)
 Main PID: 180 (code=exited, status=255)
   CGroup: /docker/f71fdf3ab52a471a395149eb026075185359d7f3aa130c03f6cab26257df373f/system.slice/sshd.service
           ├─124 sshd: tony [priv]
           ├─126 sshd: tony@pts/0
           └─127 -bash

Sep 11 08:34:54 stapp01 sshd[180]: /etc/ssh/sshd_config line 149: Directive 'Subsystem' is not allowed within a Match block
Sep 11 08:34:54 stapp01 systemd[1]: Child 180 belongs to sshd.service
Sep 11 08:34:54 stapp01 systemd[1]: sshd.service: main process exited, code=exited, status=255/n/a
Sep 11 08:34:54 stapp01 systemd[1]: sshd.service changed start -> failed
Sep 11 08:34:54 stapp01 systemd[1]: Job sshd.service/start finished, result=failed
Sep 11 08:34:54 stapp01 systemd[1]: Failed to start OpenSSH server daemon.
Sep 11 08:34:54 stapp01 systemd[1]: Unit sshd.service entered failed state.
Sep 11 08:34:54 stapp01 systemd[1]: sshd.service failed.
Sep 11 08:34:54 stapp01 systemd[1]: sshd.service changed failed -> auto-restart
[root@stapp01 ~]#
[root@stapp01 ~]# systemctl restart sshd
[root@stapp01 ~]#
[root@stapp01 ~]# systemctl status sshd
● sshd.service - OpenSSH server daemon
   Loaded: loaded (/usr/lib/systemd/system/sshd.service; enabled; vendor preset: enabled)
   Active: active (running) since Fri 2020-09-11 08:35:29 UTC; 3s ago
     Docs: man:sshd(8)
           man:sshd_config(5)
 Main PID: 185 (sshd)
   CGroup: /docker/f71fdf3ab52a471a395149eb026075185359d7f3aa130c03f6cab26257df373f/system.slice/sshd.service
           ├─124 sshd: tony [priv]
           ├─126 sshd: tony@pts/0
           ├─127 -bash
           └─185 /usr/sbin/sshd -D

Sep 11 08:35:29 stapp01 sshd[185]: WARNING: 'UsePAM no' is not supported in Red Hat Enterprise Linux and may cause several problems.
Sep 11 08:35:29 stapp01 sshd[185]: Server listening on 0.0.0.0 port 22.
Sep 11 08:35:29 stapp01 sshd[185]: Server listening on :: port 22.
Sep 11 08:35:29 stapp01 systemd[185]: Executing: /usr/sbin/sshd -D
Sep 11 08:35:29 stapp01 systemd[1]: Got notification message for unit sshd.service
Sep 11 08:35:29 stapp01 systemd[1]: sshd.service: Got notification message from PID 185 (READY=1)
Sep 11 08:35:29 stapp01 systemd[1]: sshd.service: got READY=1
Sep 11 08:35:29 stapp01 systemd[1]: sshd.service changed start -> running
Sep 11 08:35:29 stapp01 systemd[1]: Job sshd.service/start finished, result=done
Sep 11 08:35:29 stapp01 systemd[1]: Started OpenSSH server daemon.
[root@stapp01 ~]#
[root@stapp01 ~]# Connection to host01 closed by remote host.
Connection to host01 closed.

The environment has expired.

Please refresh to get a new environment.

thor@jump_host /$
thor@jump_host /$ sftp yousuf@172.16.238.10
yousuf@172.16.238.10's password:
Connected to 172.16.238.10.
sftp>
sftp> pwd
Remote working directory: /
sftp>
sftp>
[1]+  Stopped                 sftp yousuf@172.16.238.10
thor@jump_host /$
thor@jump_host /$
thor@jump_host /$ ssh yousuf@172.16.238.10
yousuf@172.16.238.10's password:
This service allows sftp connections only.
Connection to 172.16.238.10 closed.
thor@jump_host /$
thor@jump_host /$ Connection to host01 closed by remote host.
Connection to host01 closed.

The environment has expired.

Please refresh to get a new environment.

