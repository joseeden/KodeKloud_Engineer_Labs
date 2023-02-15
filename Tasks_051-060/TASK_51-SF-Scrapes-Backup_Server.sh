
-----------------------------------------------------------------------------------------------------------------

# SUPPORTING FILE 

# This is a supporting file for the Task of the same name.
# This may contain configurations/config file.
# Basically, any file that is edited/created/modified through the 'vi' or 'nano' command will appear here.
# Note that there may be more than one supporting files for the Task at hand.

-----------------------------------------------------------------------------------------------------------------

TASK_51-SF-Scrapes-Backup_Server.sh

thor@jump_host /$ sshpass -p '******' ssh -o StrictHostKeyChecking=no  clint@172.16.238.16Warning: Permanently added '172.16.238.16' (ECDSA) to the list of known hosts.
sudo su -
******[clint@stbkp01 ~]$ sudo su -

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for clint:
[root@stbkp01 ~]#
[root@stbkp01 ~]# sudo firewall-cmd --zone=public --list-all
public
  target: default  icmp-block-inversion: no
  interfaces:
  sources:
  services: dhcpv6-client ssh
  ports:
  protocols:
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:

[root@stbkp01 ~]# sudo firewall-cmd --zone=public --permanent --add-port=8084/tcp
success
[root@stbkp01 ~]# firewall-cmd --help | grep reload
  --reload             Reload firewall and keep state information
  --complete-reload    Reload firewall and lose state information
[root@stbkp01 ~]#
[root@stbkp01 ~]# sudo firewall-cmd --reload
success
[root@stbkp01 ~]# sudo firewall-cmd --zone=public --list-all
public
  target: default
  icmp-block-inversion: no
  interfaces:
  sources:
  services: dhcpv6-client ssh
  ports: 8084/tcp
  protocols:
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:

[root@stbkp01 ~]#
[root@stbkp01 ~]#
[root@stbkp01 ~]# grep Listen /etc/httpd/conf/httpd.conf
# Listen: Allows you to bind Apache to specific IP addresses and/or
# Change this to Listen on specific IP addresses as shown below to
#Listen 12.34.56.78:80
Listen 8084
[root@stbkp01 ~]#
[root@stbkp01 ~]# Connection to host01 closed by remote host.
Connection to host01 closed.

The environment has expired.

Please refresh to get a new environment.