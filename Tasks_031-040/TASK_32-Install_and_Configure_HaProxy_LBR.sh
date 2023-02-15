
-----------------------------------------------------------------------------------------------------------------

Start			  2020-08-09 || 04:04 AM
Finished		2020-08-09 || 10:13 AM

-----------------------------------------------------------------------------------------------------------------

TASK 32 - Install and Configure HaProxy LBR

REQUIREMENTS:

There is a static website of Nautilus project running in Stratos Datacenter. Based on the infrastructure, they have already configured app servers and code is already deployed there. To make it work properly, they need to configure LBR server. There are number of options for that, but team has decided to go with HAproxy.

a. So install and configure HAproxy on LBR server using yum only and make sure all app servers are added to HAproxy load balancer. HAproxy must serve on default http port (Note: Please do not remove stats socket /var/lib/haproxy/stats entry from haproxy default config.).

b. You can access the website on LBR link—to do so click on the + button on top of your terminal, select option Select port to view on Host 1, and after adding port 80 click on Display Port.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

# Copied this and added as supporting file
https://community.kodekloud.com/t/hints-on-haproxy-lbr-task/8830  

# This one has complete steps
https://community.kodekloud.com/t/install-and-configure-haproxy-lbr-failed/6411

# Other sources
https://community.kodekloud.com/t/why-install-and-configure-haproxy-lbr-failed/2336/10
https://community.kodekloud.com/t/install-and-configure-haproxy-lbr/2363/18

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

#	1.	Connect via SSH to each App server and take note of the port where the Apache is listening to.
#		  Ensure httpd is running on all App Server.
#	2.	Proceed to LBR Server and install HAproxy through yum only. Enable, start, and then verify status.
#	3.	Modify the HAproxy config file so that HAproxy must server to the default http port - port 80.
#		  Also make sure that the App server are added to the Backend section. Restart HAproxy.
#	4.	Return to the jumphost and curl the ip address of each App server - use the port initially noted.

-----------------------------------------------------------------------------------------------------------------

III.	COMMANDS USED

#	1.	Connect via SSH to each App server and take note of the port where the Apache is listening to.
#		Ensure httpd is running on all App Server.

		# I found that it's much  easier to run commands when you switch to root user upon connecting to the 
		# App server/s. So for each one, I just run the three lines and i'll be immediately switched to root
		# without entering any password.
		
			sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
			sudo su -
			******
			
			sshpass -p  '******' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
			sudo su -
			******
			
			sshpass -p  '******' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
			sudo su -
			******

		# Note that the following steps are done on EACH APP SERVER - thus all steps from this point onward is 
		# done after connecting via SSH to each App server.
		# Once connected to the App Server, verify the port that the Apache is listening to.
		
			ps -aux | grep httpd	# Not sure if this was helpful but found this in one of the articles in KKC
		
		# The port number can be verified through the httpd.conf file.
		
			ls -l /etc/httpd/conf/
			cat /etc/httpd/conf/httpd.conf | grep Listen
			
		# So far, all three App server have port '6100'
		
				Listen 6100
		
		# Verify that httpd is running and enabled.
		
			systemctl status httpd
			systemctl enable httpd
			systemctl status httpd
					
#	2.	Proceed to LBR Server and install HAproxy through yum only. Enable, start, and then verify status.
		
			sshpass -p '******' ssh -o StrictHostKeyChecking=no  loki@172.16.238.14
			sudo su -
			******
		
		# Install HAproxy through YUM then start and enable afterwards.
		
			sudo yum install -y haproxy
			systemctl status haproxy
			systemctl start haproxy
			systemctl enable haproxy
			systemctl status haproxy
			
#	3.	Modify the HAproxy config file so that HAproxy must server to the default http port - port 80.

		# As always, it's best practice to check first the content of the required file.
		# Another best practice is to create a backup file in case you mess up the config file.
		# Since this was a lab, I did not bother to create a backup. But that should always be a must!
		
			ls -l /etc/haproxy/
			cd /etc/haproxy/
			cat haproxy.cfg
		
		# Once config file is checked, modify it according to th erequirement.
		# Make sure that the App server are added to the Backend section. Restart HAproxy.
		# I added a SupportFIle which contains the updated haproxy.cfg
			
			vi haproxy.cfg
			
		# For the changes to take effect, restart the HAproxy service.
		
			systemctl status haproxy
			systemctl restart haproxy
			systemctl enable haproxy
			systemctl status haproxy
			
		# After restarting and verifying HAproxy is up and running, I got stuck at solving the wrong problem.
		# I kept doing the curl in the LBR server.
		# I was not also able to access the website on LBR link through the + button on the terminal during my
		# my first attempt.
		
		# I was so focused on this two lines that I didn't notice that I was actually doing the correct steps.
		# I was just doing the incorrect way of verifying it.
		
			haproxy -db -f /etc/haproxy/haproxy.cfg
			curl http://localhost:80
			
		# After some tries, I decided to take a break and go out to do some errands in the market.
		# I went back after a few hours and did the lab again but this time check other articles in KKC.
		# And somehow by some miracle, after two attempts, I was able to open the website through the LBR link.
		# But before I did that, I first returned to the jumphost and curl the IP addresses.

#	4.	Return to the jumphost and curl the ip address of each App server - use the port initially noted.

			curl http://172.16.238.14:80
			curl http://172.16.238.10:6100
			curl http://172.16.238.11:6100
			curl http://172.16.238.12:6100
			
		# All of this curl commands shuld return this output:
		
				Welcome to xFusionCorp Industries !

-----------------------------------------------------------------------------------------------------------------

IV.	STEPS - BREAKDOWN

thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10Warning: Permanently added '172.16.238.10' (ECDSA) to the list of known hosts.
sudo su -
******[tony@stapp01 ~]$ sudo su -

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for tony:
[root@stapp01 ~]#
[root@stapp01 ~]# ps -aux | grep httpdroot       492  0.7  1.0 388540 21120 ?        Ss   01:30   0:00 /usr/sbin/httpd -DFOREGROUND
apache     493  0.0  0.6 388676 12820 ?        S    01:30   0:00 /usr/sbin/httpd -DFOREGROUND
apache     494  0.0  0.6 388676 12820 ?        S    01:30   0:00 /usr/sbin/httpd -DFOREGROUND
apache     495  0.0  0.6 388676 12820 ?        S    01:30   0:00 /usr/sbin/httpd -DFOREGROUND
apache     496  0.0  0.6 388676 12820 ?        S    01:30   0:00 /usr/sbin/httpd -DFOREGROUND
apache     497  0.0  0.6 388676 12820 ?        S    01:30   0:00 /usr/sbin/httpd -DFOREGROUND
root       499  0.0  0.1  12528  2176 pts/0    S+   01:30   0:00 grep --color=auto httpd
[root@stapp01 ~]#
[root@stapp01 ~]# ls -l /etc/httpd/conf/
total 28
-rw-r--r--  1 root root 11755 Aug  9 01:30 httpd.conf
-rw-r--r-- 15 root root 13077 Aug  8  2019 magic
[root@stapp01 ~]#
[root@stapp01 ~]# cat /etc/httpd/conf/httpd.conf | grep Listen
# Listen: Allows you to bind Apache to specific IP addresses and/or
# Change this to Listen on specific IP addresses as shown below to
#Listen 12.34.56.78:80
Listen 6100
[root@stapp01 ~]#
[root@stapp01 ~]# systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: active (running) since Sun 2020-08-09 01:30:08 UTC; 37s ago
     Docs: man:httpd(8)
           man:apachectl(8)
 Main PID: 492 (httpd)
   Status: "Total requests: 0; Current requests/sec: 0; Current traffic:   0 B/sec"
   CGroup: /docker/e82a4a7e35b159a61d289eccc8264be697569e14b869d897eae9c57e9a9605c7/system.slice/httpd.service
           ├─492 /usr/sbin/httpd -DFOREGROUND
           ├─493 /usr/sbin/httpd -DFOREGROUND
           ├─494 /usr/sbin/httpd -DFOREGROUND
           ├─495 /usr/sbin/httpd -DFOREGROUND
           ├─496 /usr/sbin/httpd -DFOREGROUND
           └─497 /usr/sbin/httpd -DFOREGROUND

Aug 09 01:30:08 stapp01 systemd[1]: Starting The Apache HTTP Server...
Aug 09 01:30:08 stapp01 httpd[492]: AH00558: httpd: Could not reliably determine the serve...age
Aug 09 01:30:08 stapp01 systemd[1]: Started The Apache HTTP Server.
Hint: Some lines were ellipsized, use -l to show in full.
[root@stapp01 ~]#
[root@stapp01 ~]# systemctl enable httpd
Created symlink from /etc/systemd/system/multi-user.target.wants/httpd.service to /usr/lib/systemd/system/httpd.service.
[root@stapp01 ~]#
[root@stapp01 ~]# systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor preset: disabled)
   Active: active (running) since Sun 2020-08-09 01:30:08 UTC; 37s ago
     Docs: man:httpd(8)
           man:apachectl(8)
 Main PID: 492 (httpd)
   Status: "Total requests: 0; Current requests/sec: 0; Current traffic:   0 B/sec"
   CGroup: /docker/e82a4a7e35b159a61d289eccc8264be697569e14b869d897eae9c57e9a9605c7/system.slice/httpd.service
           ├─492 /usr/sbin/httpd -DFOREGROUND
           ├─493 /usr/sbin/httpd -DFOREGROUND
           ├─494 /usr/sbin/httpd -DFOREGROUND
           ├─495 /usr/sbin/httpd -DFOREGROUND
           ├─496 /usr/sbin/httpd -DFOREGROUND
           └─497 /usr/sbin/httpd -DFOREGROUND

Aug 09 01:30:08 stapp01 systemd[1]: Starting The Apache HTTP Server...
Aug 09 01:30:08 stapp01 httpd[492]: AH00558: httpd: Could not reliably determine the serve...age
Aug 09 01:30:08 stapp01 systemd[1]: Started The Apache HTTP Server.
Hint: Some lines were ellipsized, use -l to show in full.
[root@stapp01 ~]#
[root@stapp01 ~]#
[root@stapp01 ~]#
[root@stapp01 ~]#
[root@stapp01 ~]#
[root@stapp01 ~]# exit
logout
[tony@stapp01 ~]$ exit
logout
Connection to 172.16.238.10 closed.
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
[root@stapp02 ~]# ps -aux | grep httpd
root       457  0.1  1.0 388540 20964 ?        Ss   01:30   0:00 /usr/sbin/httpd -DFOREGROUND
apache     458  0.0  0.6 388676 12852 ?        S    01:30   0:00 /usr/sbin/httpd -DFOREGROUND
apache     459  0.0  0.6 388676 12852 ?        S    01:30   0:00 /usr/sbin/httpd -DFOREGROUND
apache     460  0.0  0.6 388676 12852 ?        S    01:30   0:00 /usr/sbin/httpd -DFOREGROUND
apache     461  0.0  0.6 388676 12852 ?        S    01:30   0:00 /usr/sbin/httpd -DFOREGROUND
apache     462  0.0  0.6 388676 12852 ?        S    01:30   0:00 /usr/sbin/httpd -DFOREGROUND
root       501  0.0  0.1  12528  2184 pts/0    S+   01:31   0:00 grep --color=auto httpd
[root@stapp02 ~]#
[root@stapp02 ~]# ls -l /etc/httpd/conf/
total 28
-rw-r--r--  1 root root 11755 Aug  9 01:30 httpd.conf
-rw-r--r-- 15 root root 13077 Aug  8  2019 magic
[root@stapp02 ~]#
[root@stapp02 ~]# cat /etc/httpd/conf/httpd.conf | grep Listen
# Listen: Allows you to bind Apache to specific IP addresses and/or
# Change this to Listen on specific IP addresses as shown below to
#Listen 12.34.56.78:80
Listen 6100
[root@stapp02 ~]#
[root@stapp02 ~]# systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: active (running) since Sun 2020-08-09 01:30:09 UTC; 1min 29s ago
     Docs: man:httpd(8)
           man:apachectl(8)
 Main PID: 457 (httpd)
   Status: "Total requests: 0; Current requests/sec: 0; Current traffic:   0 B/sec"
   CGroup: /docker/4e2ed5282d12045adead2a33f05d7f862e18cc09f798f1ce4f6c20747e40a3fe/system.slice/httpd.service
           ├─457 /usr/sbin/httpd -DFOREGROUND
           ├─458 /usr/sbin/httpd -DFOREGROUND
           ├─459 /usr/sbin/httpd -DFOREGROUND
           ├─460 /usr/sbin/httpd -DFOREGROUND
           ├─461 /usr/sbin/httpd -DFOREGROUND
           └─462 /usr/sbin/httpd -DFOREGROUND

Aug 09 01:30:08 stapp02 systemd[1]: Starting The Apache HTTP Server...
Aug 09 01:30:08 stapp02 httpd[457]: AH00558: httpd: Could not reliably determine the serve...age
Aug 09 01:30:09 stapp02 systemd[1]: Started The Apache HTTP Server.
Hint: Some lines were ellipsized, use -l to show in full.
[root@stapp02 ~]#
[root@stapp02 ~]# systemctl enable httpd
Created symlink from /etc/systemd/system/multi-user.target.wants/httpd.service to /usr/lib/systemd/system/httpd.service.
[root@stapp02 ~]#
[root@stapp02 ~]# systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor preset: disabled)
   Active: active (running) since Sun 2020-08-09 01:30:09 UTC; 1min 29s ago
     Docs: man:httpd(8)
           man:apachectl(8)
 Main PID: 457 (httpd)
   Status: "Total requests: 0; Current requests/sec: 0; Current traffic:   0 B/sec"
   CGroup: /docker/4e2ed5282d12045adead2a33f05d7f862e18cc09f798f1ce4f6c20747e40a3fe/system.slice/httpd.service
           ├─457 /usr/sbin/httpd -DFOREGROUND
           ├─458 /usr/sbin/httpd -DFOREGROUND
           ├─459 /usr/sbin/httpd -DFOREGROUND
           ├─460 /usr/sbin/httpd -DFOREGROUND
           ├─461 /usr/sbin/httpd -DFOREGROUND
           └─462 /usr/sbin/httpd -DFOREGROUND

Aug 09 01:30:08 stapp02 systemd[1]: Starting The Apache HTTP Server...
Aug 09 01:30:08 stapp02 httpd[457]: AH00558: httpd: Could not reliably determine the serve...age
Aug 09 01:30:09 stapp02 systemd[1]: Started The Apache HTTP Server.
Hint: Some lines were ellipsized, use -l to show in full.
[root@stapp02 ~]#
[root@stapp02 ~]#
[root@stapp02 ~]# exit
logout
[steve@stapp02 ~]$ exit
logout
Connection to 172.16.238.11 closed.
thor@jump_host /$
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
[root@stapp03 ~]#
[root@stapp03 ~]# ps -aux | grep httpd
root       462  0.0  1.0 388540 21184 ?        Ss   01:30   0:00 /usr/sbin/httpd -DFOREGROUND
apache     463  0.0  0.6 388676 12940 ?        S    01:30   0:00 /usr/sbin/httpd -DFOREGROUND
apache     464  0.0  0.6 388676 12940 ?        S    01:30   0:00 /usr/sbin/httpd -DFOREGROUND
apache     465  0.0  0.6 388676 12940 ?        S    01:30   0:00 /usr/sbin/httpd -DFOREGROUND
apache     466  0.0  0.6 388676 12940 ?        S    01:30   0:00 /usr/sbin/httpd -DFOREGROUND
apache     467  0.0  0.6 388676 12940 ?        S    01:30   0:00 /usr/sbin/httpd -DFOREGROUND
root       506  0.0  0.1  12528  2300 pts/0    S+   01:32   0:00 grep --color=auto httpd
[root@stapp03 ~]#
[root@stapp03 ~]# ls -l /etc/httpd/conf/
total 28
-rw-r--r--  1 root root 11755 Aug  9 01:30 httpd.conf
-rw-r--r-- 15 root root 13077 Aug  8  2019 magic
[root@stapp03 ~]#
[root@stapp03 ~]# cat /etc/httpd/conf/httpd.conf | grep Listen
# Listen: Allows you to bind Apache to specific IP addresses and/or
# Change this to Listen on specific IP addresses as shown below to
#Listen 12.34.56.78:80
Listen 6100
[root@stapp03 ~]#
[root@stapp03 ~]#
[root@stapp03 ~]# exit
logout
[banner@stapp03 ~]$ exit
logout
Connection to 172.16.238.12 closed.
thor@jump_host /$
thor@jump_host /$ sshpass -p '******' ssh -o StrictHostKeyChecking=no  loki@172.16.238.14
Warning: Permanently added '172.16.238.14' (ECDSA) to the list of known hosts.
sudo su -
******
[loki@stlb01 ~]$ sudo su -

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for loki:
[root@stlb01 ~]#
[root@stlb01 ~]# sudo yum install -y haproxy
Loaded plugins: fastestmirror, ovl
Loading mirror speeds from cached hostfile
 * base: mirror.plustech.de
 * extras: mirror.plustech.de
 * updates: mirror.checkdomain.de
Resolving Dependencies
--> Running transaction check
---> Package haproxy.x86_64 0:1.5.18-9.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================================
 Package               Arch                 Version                    Repository          Size
================================================================================================
Installing:
 haproxy               x86_64               1.5.18-9.el7               base               834 k

Transaction Summary
================================================================================================
Install  1 Package

Total download size: 834 k
Installed size: 2.6 M
Downloading packages:
haproxy-1.5.18-9.el7.x86_64.rpm                                          | 834 kB  00:00:00
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction

  Installing : haproxy-1.5.18-9.el7.x86_64                                                  1/1
  Verifying  : haproxy-1.5.18-9.el7.x86_64                                                  1/1

Installed:
  haproxy.x86_64 0:1.5.18-9.el7

Complete!
[root@stlb01 ~]#
[root@stlb01 ~]# systemctl status haproxy
● haproxy.service - HAProxy Load Balancer
   Loaded: loaded (/usr/lib/systemd/system/haproxy.service; disabled; vendor preset: disabled)
   Active: inactive (dead)

Aug 09 01:32:33 stlb01 systemd[1]: Collecting haproxy.service
[root@stlb01 ~]#
[root@stlb01 ~]# systemctl start haproxy
[root@stlb01 ~]#
[root@stlb01 ~]# systemctl enable haproxy
Created symlink from /etc/systemd/system/multi-user.target.wants/haproxy.service to /usr/lib/systemd/system/haproxy.service.
[root@stlb01 ~]#
[root@stlb01 ~]# systemctl status haproxy
● haproxy.service - HAProxy Load Balancer
   Loaded: loaded (/usr/lib/systemd/system/haproxy.service; enabled; vendor preset: disabled)
   Active: active (running) since Sun 2020-08-09 01:32:33 UTC; 59ms ago
 Main PID: 193 (haproxy-systemd)
   CGroup: /docker/74d415fdddbba9f1bc97f967b3320eda7eb764e31f10353ef7957b35188cd1b4/system.slice/haproxy.service
           ├─193 /usr/sbin/haproxy-systemd-wrapper -f /etc/haproxy/haproxy.cfg -p /run/haprox...
           ├─194 /usr/sbin/haproxy -f /etc/haproxy/haproxy.cfg -p /run/haproxy.pid -Ds
           └─196 /usr/sbin/haproxy -f /etc/haproxy/haproxy.cfg -p /run/haproxy.pid -Ds

Aug 09 01:32:33 stlb01 systemd[1]: Collecting haproxy.service
Aug 09 01:32:33 stlb01 systemd[1]: Trying to enqueue job haproxy.service/start/replace
Aug 09 01:32:33 stlb01 systemd[1]: Installed new job haproxy.service/start as 128
Aug 09 01:32:33 stlb01 systemd[1]: Enqueued job haproxy.service/start as 128
Aug 09 01:32:33 stlb01 systemd[1]: About to execute: /usr/sbin/haproxy-systemd-wrapper -f...IONS
Aug 09 01:32:33 stlb01 systemd[1]: Forked /usr/sbin/haproxy-systemd-wrapper as 193
Aug 09 01:32:33 stlb01 systemd[1]: haproxy.service changed dead -> running
Aug 09 01:32:33 stlb01 systemd[1]: Job haproxy.service/start finished, result=done
Aug 09 01:32:33 stlb01 systemd[1]: Started HAProxy Load Balancer.
Aug 09 01:32:33 stlb01 systemd[193]: Executing: /usr/sbin/haproxy-systemd-wrapper -f /etc/...pid
Hint: Some lines were ellipsized, use -l to show in full.
[root@stlb01 ~]#
[root@stlb01 ~]#
[root@stlb01 ~]# ls -l /etc/haproxy/
total 4
-rw-r--r-- 1 root root 3142 Aug  6  2019 haproxy.cfg
[root@stlb01 ~]# cd /etc/haproxy/
[root@stlb01 haproxy]# cat haproxy.cfg
#---------------------------------------------------------------------
# Example configuration for a possible web application.  See the
# full configuration options online.
#
#   http://haproxy.1wt.eu/download/1.4/doc/configuration.txt
#
#---------------------------------------------------------------------

#---------------------------------------------------------------------
# Global settings
#---------------------------------------------------------------------
global
    # to have these messages end up in /var/log/haproxy.log you will
    # need to:
    #
    # 1) configure syslog to accept network log events.  This is done
    #    by adding the '-r' option to the SYSLOGD_OPTIONS in
    #    /etc/sysconfig/syslog
    #
    # 2) configure local2 events to go to the /var/log/haproxy.log
    #   file. A line like the following can be added to
    #   /etc/sysconfig/syslog
    #
    #    local2.*                       /var/log/haproxy.log
    #
    log         127.0.0.1 local2

    chroot      /var/lib/haproxy
    pidfile     /var/run/haproxy.pid
    maxconn     4000
    user        haproxy
    group       haproxy
    daemon

    # turn on stats unix socket
    stats socket /var/lib/haproxy/stats

#---------------------------------------------------------------------
# common defaults that all the 'listen' and 'backend' sections will
# use if not designated in their block
#---------------------------------------------------------------------
defaults
    mode                    http
    log                     global
    option                  httplog
    option                  dontlognull
    option http-server-close
    option forwardfor       except 127.0.0.0/8
    option                  redispatch
    retries                 3
    timeout http-request    10s
    timeout queue           1m
    timeout connect         10s
    timeout client          1m
    timeout server          1m
    timeout http-keep-alive 10s
    timeout check           10s
    maxconn                 3000

#---------------------------------------------------------------------
# main frontend which proxys to the backends
#---------------------------------------------------------------------
frontend  main *:5000
    acl url_static       path_beg       -i /static /images /javascript /stylesheets
    acl url_static       path_end       -i .jpg .gif .png .css .js

    use_backend static          if url_static
    default_backend             app

#---------------------------------------------------------------------
# static backend for serving up images, stylesheets and such
#---------------------------------------------------------------------
backend static
    balance     roundrobin
    server      static 127.0.0.1:4331 check

#---------------------------------------------------------------------
# round robin balancing between the various backends
#---------------------------------------------------------------------
backend app
    balance     roundrobin
    server  app1 127.0.0.1:5001 check
    server  app2 127.0.0.1:5002 check
    server  app3 127.0.0.1:5003 check
    server  app4 127.0.0.1:5004 check

[root@stlb01 haproxy]#
[root@stlb01 haproxy]# vi haproxy.cfg
[root@stlb01 haproxy]#
[root@stlb01 haproxy]# vi haproxy.cfg
[root@stlb01 haproxy]#
[root@stlb01 haproxy]# haproxy -db -f /etc/haproxy/haproxy.cfg
[WARNING] 221/013536 (213) : Server static/static is DOWN, reason: Layer4 connection problem, info: "Connection refused", check duration: 0ms. 0 active and 0 backup servers left. 0 sessions active, 0 requeued, 0 remaining in queue.
[ALERT] 221/013536 (213) : backend 'static' has no server available!

^Z
[1]+  Stopped                 haproxy -db -f /etc/haproxy/haproxy.cfg
[root@stlb01 haproxy]#
[root@stlb01 haproxy]# curl http://localhost:80
^Z
[2]+  Stopped                 curl http://localhost:80
[root@stlb01 haproxy]#
[root@stlb01 haproxy]# vi haproxy.cfg
[root@stlb01 haproxy]# systemctl status haproxy
● haproxy.service - HAProxy Load Balancer
   Loaded: loaded (/usr/lib/systemd/system/haproxy.service; enabled; vendor preset: disabled)
   Active: active (running) since Sun 2020-08-09 01:32:33 UTC; 4min 1s ago
 Main PID: 193 (haproxy-systemd)
   CGroup: /docker/74d415fdddbba9f1bc97f967b3320eda7eb764e31f10353ef7957b35188cd1b4/system.slice/haproxy.service
           ├─193 /usr/sbin/haproxy-systemd-wrapper -f /etc/haproxy/haproxy.cfg -p /run/haprox...
           ├─194 /usr/sbin/haproxy -f /etc/haproxy/haproxy.cfg -p /run/haproxy.pid -Ds
           └─196 /usr/sbin/haproxy -f /etc/haproxy/haproxy.cfg -p /run/haproxy.pid -Ds

Aug 09 01:32:33 stlb01 systemd[1]: Collecting haproxy.service
Aug 09 01:32:33 stlb01 systemd[1]: Trying to enqueue job haproxy.service/start/replace
Aug 09 01:32:33 stlb01 systemd[1]: Installed new job haproxy.service/start as 128
Aug 09 01:32:33 stlb01 systemd[1]: Enqueued job haproxy.service/start as 128
Aug 09 01:32:33 stlb01 systemd[1]: About to execute: /usr/sbin/haproxy-systemd-wrapper -f...IONS
Aug 09 01:32:33 stlb01 systemd[1]: Forked /usr/sbin/haproxy-systemd-wrapper as 193
Aug 09 01:32:33 stlb01 systemd[1]: haproxy.service changed dead -> running
Aug 09 01:32:33 stlb01 systemd[1]: Job haproxy.service/start finished, result=done
Aug 09 01:32:33 stlb01 systemd[1]: Started HAProxy Load Balancer.
Aug 09 01:32:33 stlb01 systemd[193]: Executing: /usr/sbin/haproxy-systemd-wrapper -f /etc/...pid
Hint: Some lines were ellipsized, use -l to show in full.
[root@stlb01 haproxy]#
[root@stlb01 haproxy]# systemctl restart haproxy
[root@stlb01 haproxy]#
[root@stlb01 haproxy]# systemctl enable haproxy
[root@stlb01 haproxy]#
[root@stlb01 haproxy]# systemctl status haproxy
● haproxy.service - HAProxy Load Balancer
   Loaded: loaded (/usr/lib/systemd/system/haproxy.service; enabled; vendor preset: disabled)
   Active: active (running) since Sun 2020-08-09 01:36:34 UTC; 436ms ago
 Main PID: 221 (haproxy-systemd)
   CGroup: /docker/74d415fdddbba9f1bc97f967b3320eda7eb764e31f10353ef7957b35188cd1b4/system.slice/haproxy.service
           ├─221 /usr/sbin/haproxy-systemd-wrapper -f /etc/haproxy/haproxy.cfg -p /run/haprox...
           ├─224 /usr/sbin/haproxy -f /etc/haproxy/haproxy.cfg -p /run/haproxy.pid -Ds
           └─226 /usr/sbin/haproxy -f /etc/haproxy/haproxy.cfg -p /run/haproxy.pid -Ds

Aug 09 01:36:34 stlb01 systemd[1]: Stopped HAProxy Load Balancer.
Aug 09 01:36:34 stlb01 systemd[1]: Converting job haproxy.service/restart -> haproxy.serv...tart
Aug 09 01:36:34 stlb01 systemd[1]: haproxy.service: cgroup is empty
Aug 09 01:36:34 stlb01 systemd[1]: About to execute: /usr/sbin/haproxy-systemd-wrapper -f...IONS
Aug 09 01:36:34 stlb01 systemd[1]: Forked /usr/sbin/haproxy-systemd-wrapper as 221
Aug 09 01:36:34 stlb01 systemd[1]: haproxy.service changed dead -> running
Aug 09 01:36:34 stlb01 systemd[1]: Job haproxy.service/start finished, result=done
Aug 09 01:36:34 stlb01 systemd[1]: Started HAProxy Load Balancer.
Aug 09 01:36:34 stlb01 haproxy-systemd-wrapper[221]: haproxy-systemd-wrapper: executing /us...Ds
Aug 09 01:36:34 stlb01 systemd[221]: Executing: /usr/sbin/haproxy-systemd-wrapper -f /etc/...pid
Hint: Some lines were ellipsized, use -l to show in full.
[root@stlb01 haproxy]#
[root@stlb01 haproxy]# curl http://localhost:80

z

^Z
[3]+  Stopped                 curl http://localhost:80
[root@stlb01 haproxy]#
[root@stlb01 haproxy]# curl http://localhost:6100
curl: (7) Failed to connect to ::1: Cannot assign requested address
[root@stlb01 haproxy]#
[root@stlb01 haproxy]#
[root@stlb01 haproxy]# exit
logout
There are stopped jobs.
[root@stlb01 haproxy]# exit
logout
[loki@stlb01 ~]$
[loki@stlb01 ~]$ exit
logout
Connection to 172.16.238.14 closed.
thor@jump_host /$ curl http://172.16.238.14:80
Welcome to xFusionCorp Industries !
thor@jump_host /$
thor@jump_host /$ curl http://172.16.238.14:6100
curl: (7) Failed connect to 172.16.238.14:6100; Connection refused
thor@jump_host /$
thor@jump_host /$ curl http://172.16.238.14:80
Welcome to xFusionCorp Industries !
thor@jump_host /$
thor@jump_host /$ curl http://172.16.238.10:80
curl: (7) Failed connect to 172.16.238.10:80; Connection refused
thor@jump_host /$
thor@jump_host /$ curl http://172.16.238.11:80
curl: (7) Failed connect to 172.16.238.11:80; Connection refused
thor@jump_host /$
thor@jump_host /$ curl http://172.16.238.12:80
curl: (7) Failed connect to 172.16.238.12:80; Connection refused
thor@jump_host /$
thor@jump_host /$ curl http://172.16.238.12:6199
curl: (7) Failed connect to 172.16.238.12:6199; Connection refused
thor@jump_host /$
thor@jump_host /$ curl http://172.16.238.12:6100
Welcome to xFusionCorp Industries !
thor@jump_host /$
thor@jump_host /$ curl http://172.16.238.11:6100
Welcome to xFusionCorp Industries !
thor@jump_host /$
thor@jump_host /$ curl http://172.16.238.10:6100
Welcome to xFusionCorp Industries !
thor@jump_host /$
thor@jump_host /$ Connection to host01 closed by remote host.
Connection to host01 closed.

The environment has expired.

Please refresh to get a new environment.

-----------------------------------------------------------------------------------------------------------------


############################################################################################################

    #######      ###   ###		#######		 #######	#########	  #######	   #######		###	  ###	
   #### ####	 ###   ###	   #### ####	#### ####	#########	 #### ####	  #### ####		###	  ###
   ###	 ###	 ###   ###	   ###	 ###	###	  ###	###			 ###   ###	  ###   ###		###	  ###
   ###			 ###   ###	   ###			###			###			 ###		  ###			###	  ###
    #######		 ###   ###	   ###   		###			########	  #######	   #######		###	  ###
     #######     ###   ###	   ###			###			########	   #######	    #######		###	  ###
		 ###     ###   ###	   ###			###			###				   ###			###		###	  ###
   ###	 ###     ###   ###	   ###	 ###	###	  ###	###			 ###   ###	  ###   ###
   #########     #########	   #### ####	#### ####	#########	 #########	  #########		###	  ###
	#######       #######		#######		 #######	#########	  #######	   #######		###	  ###
			
############################################################################################################

