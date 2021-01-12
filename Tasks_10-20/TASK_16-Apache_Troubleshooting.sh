
-----------------------------------------------------------------------------------------------------------------

Start		  2020-07-16 || 01:53 AM
Finished	2020-07-16 || 03:06 AM

-----------------------------------------------------------------------------------------------------------------

TASK 16 - Apache Troubleshooting

REQUIREMENT:

xFusionCorp Industries utilizes monitoring tools to check the status of every service, application, etc. running on the systems. The monitoring system identified that Apache service is not running on some of the Nautilus Application Servers in Stratos Datacenter.

Identify the faulty Nautilus Application Servers and fix the issue. Also, make sure Apache service is up and running on all Nautilus Application Servers. Do not try to stop any kind of firewall that is already running.

Apache is running on 8087 port on all Nautilus Application Servers and its document root must be /var/www/html on all app servers.
  
Finally you can test from jump host using curl command to access Apache on all app servers and it should work fine. E.g. curl http://172.16.238.10:6400/

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://community.kodekloud.com/t/apache-troubleshooting/1657/8
https://community.kodekloud.com/t/apache-troubleshooting-failed-test/2050/26
https://www.cyberciti.biz/faq/unix-linux-check-if-port-is-in-use-command/

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

	1.	Connect via SSH to each App Server.
	2.	Check httspd status. (I knew all httpd in all app servers were not working so I proceeded to step 3))
	3.	Remove https and then reinstall it again on each app server.
	4.	Edit the /etc/httpd/conf/httpd.conf file.
	5.	Restart httpd and check status.
	6.	Go back to jump server and test curl to each App server.

-----------------------------------------------------------------------------------------------------------------

III.	COMMANDS USED

sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sshpass -p  '******' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
sshpass -p  '******' ssh -o StrictHostKeyChecking=no banner@172.16.238.12

sudo yum remove httpd -y

sudo yum install httpd -y
sudo vi /etc/httpd/conf/httpd.conf

172.16.238.10:8087
172.16.238.11:8087
172.16.238.12:8087

sudo systemctl restart httpd
systemctl status httpd
exit

curl http://172.16.238.10:8087/
curl http://172.16.238.11:8087/
curl http://172.16.238.12:8087/

-----------------------------------------------------------------------------------------------------------------

IV.	STEPS - BREAKDOWN

#	So this one's mildly difficult. On my first attempt, I first checked all App servers and see if httpd is working.
#	Httpd was not working so I went in to seach KKC on how to resolve this.
#	Found two useful articles which gave me hints on how to deal with the issue, and also with the commands to use.
#	Though I still did one modification on th ehttpd.conf file which was not suggested in any of the articles.
#	When I tried adding the appservers ip address:port number and the curl test from the jump server still did not
#	worked, I went back to the httpd.conf file and read some parts of it.
#	I found one section that suggests about adding the port where the app server should listen to.
#	It was my 2nd attempt and tried changin the 'Listen <port number>', restarted httpd, checked status, and then went 
#	back to the jump server to do the curl test.
#	And whatdoyaknow, it worked!

#	So at this point in time, I repeated the lab with a defined list of steps to be done and the target is to
#	reconfigure and make sure all app servers working in under 10 mins.

thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10Warning: Permanently added '172.16.238.10' (ECDSA) to the list of known hosts.
[tony@stapp01 ~]$ sudo yum remove httpd -y

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for tony:
Loaded plugins: fastestmirror, ovl
Resolving Dependencies
--> Running transaction check---> Package httpd.x86_64 0:2.4.6-90.el7.centos will be erased
--> Processing Dependency: httpd-mmn = 20120211x8664 for package: php-7.2.26-1.el7.remi.x86_64
--> Running transaction check
---> Package php.x86_64 0:7.2.26-1.el7.remi will be erased
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================================
 Package          Arch              Version                        Repository              Size
================================================================================================
Removing:
 httpd            x86_64            2.4.6-90.el7.centos            @base                  9.4 M
Removing for dependencies:
 php              x86_64            7.2.26-1.el7.remi              @remi-php72             10 M

Transaction Summary
================================================================================================
Remove  1 Package (+1 Dependent package)

Installed size: 19 M
Downloading packages:
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Erasing    : php-7.2.26-1.el7.remi.x86_64                                                 1/2
  Erasing    : httpd-2.4.6-90.el7.centos.x86_64                                             2/2
warning: directory /var/www/html: remove failed: Device or resource busy
warning: /etc/httpd/conf/httpd.conf saved as /etc/httpd/conf/httpd.conf.rpmsave
  Verifying  : php-7.2.26-1.el7.remi.x86_64                                                 1/2
  Verifying  : httpd-2.4.6-90.el7.centos.x86_64                                             2/2

Removed:
  httpd.x86_64 0:2.4.6-90.el7.centos

Dependency Removed:
  php.x86_64 0:7.2.26-1.el7.remi

Complete!
[tony@stapp01 ~]$ sudo yum install httpd -y
Loaded plugins: fastestmirror, ovl
Determining fastest mirrors
epel/x86_64/metalink                                                     |  30 kB  00:00:00

 * base: centosmirror.netcup.net
 * epel: mirrors.n-ix.net
 * extras: mirror.ratiokontakt.de
 * remi-php72: mirror.23media.com
 * remi-safe: mirror.23media.com
 * updates: centosmirror.netcup.net
base                                                                     | 3.6 kB  00:00:00
epel                                                                     | 4.7 kB  00:00:00
extras                                                                   | 2.9 kB  00:00:00
remi-php72                                                               | 3.0 kB  00:00:00
remi-safe                                                                | 3.0 kB  00:00:00
updates                                                                  | 2.9 kB  00:00:00
(1/9): base/7/x86_64/group_gz                                            | 153 kB  00:00:00
(2/9): epel/x86_64/updateinfo                                            | 1.0 MB  00:00:00
(3/9): base/7/x86_64/primary_db                                          | 6.1 MB  00:00:00
(4/9): extras/7/x86_64/primary_db                                        | 205 kB  00:00:00
(5/9): epel/x86_64/group_gz                                              |  95 kB  00:00:00
(6/9): updates/7/x86_64/primary_db                                       | 3.0 MB  00:00:00
(7/9): epel/x86_64/primary_db                                            | 6.8 MB  00:00:01
(8/9): remi-php72/primary_db                                             | 240 kB  00:00:01
(9/9): remi-safe/primary_db                                              | 1.7 MB  00:00:01
Resolving Dependencies
--> Running transaction check
---> Package httpd.x86_64 0:2.4.6-93.el7.centos will be installed
--> Processing Dependency: httpd-tools = 2.4.6-93.el7.centos for package: httpd-2.4.6-93.el7.centos.x86_64
--> Running transaction check
---> Package httpd-tools.x86_64 0:2.4.6-90.el7.centos will be updated
---> Package httpd-tools.x86_64 0:2.4.6-93.el7.centos will be an update
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================================
 Package                Arch              Version                         Repository       Size
================================================================================================
Installing:
 httpd                  x86_64            2.4.6-93.el7.centos             base            2.7 M
Updating for dependencies:
 httpd-tools            x86_64            2.4.6-93.el7.centos             base             92 k

Transaction Summary
================================================================================================
Install  1 Package
Upgrade             ( 1 Dependent package)

Total download size: 2.8 M
Downloading packages:
Delta RPMs disabled because /usr/bin/applydeltarpm not installed.
(1/2): httpd-tools-2.4.6-93.el7.centos.x86_64.rpm                        |  92 kB  00:00:00
(2/2): httpd-2.4.6-93.el7.centos.x86_64.rpm                              | 2.7 MB  00:00:00
------------------------------------------------------------------------------------------------
Total                                                            12 MB/s | 2.8 MB  00:00:00
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Updating   : httpd-tools-2.4.6-93.el7.centos.x86_64                                       1/3
  Installing : httpd-2.4.6-93.el7.centos.x86_64                                             2/3
  Cleanup    : httpd-tools-2.4.6-90.el7.centos.x86_64                                       3/3
  Verifying  : httpd-tools-2.4.6-93.el7.centos.x86_64                                       1/3
  Verifying  : httpd-2.4.6-93.el7.centos.x86_64                                             2/3
  Verifying  : httpd-tools-2.4.6-90.el7.centos.x86_64                                       3/3

Installed:
  httpd.x86_64 0:2.4.6-93.el7.centos

Dependency Updated:
  httpd-tools.x86_64 0:2.4.6-93.el7.centos

Complete!
[tony@stapp01 ~]$ sudo vi /etc/httpd/conf/httpd.conf
[tony@stapp01 ~]$ sudo systemctl restart httpd
[tony@stapp01 ~]$ systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: active (running) since Wed 2020-07-15 18:45:28 UTC; 1s ago
     Docs: man:httpd(8)
           man:apachectl(8)
 Main PID: 474 (httpd)
   Status: "Processing requests..."
   CGroup: /docker/e3a6b43144718f1a7ed26d04f868146184e0f9ce34e4b0f9ad5af1d83af3050c/system.slice/httpd.service
           ├─474 /usr/sbin/httpd -DFOREGROUND
           ├─475 /usr/sbin/httpd -DFOREGROUND
           ├─476 /usr/sbin/httpd -DFOREGROUND
           ├─477 /usr/sbin/httpd -DFOREGROUND
           ├─478 /usr/sbin/httpd -DFOREGROUND
           └─479 /usr/sbin/httpd -DFOREGROUND

Jul 15 18:45:28 stapp01 systemd[1]: Starting The Apache HTTP Server...
Jul 15 18:45:28 stapp01 systemd[1]: Started The Apache HTTP Server.
[tony@stapp01 ~]$ exit
logout
Connection to 172.16.238.10 closed.
thor@jump_host /$ curl http://172.16.238.10:8087/
Welcome to xFusionCorp Industries !
thor@jump_host /$
thor@jump_host /$
thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
Warning: Permanently added '172.16.238.11' (ECDSA) to the list of known hosts.
[steve@stapp02 ~]$ sudo yum remove httpd -y

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for steve:
Sorry, try again.
[sudo] password for steve:
Loaded plugins: fastestmirror, ovl
Resolving Dependencies
--> Running transaction check
---> Package httpd.x86_64 0:2.4.6-90.el7.centos will be erased
--> Processing Dependency: httpd-mmn = 20120211x8664 for package: php-7.2.26-1.el7.remi.x86_64
--> Running transaction check
---> Package php.x86_64 0:7.2.26-1.el7.remi will be erased
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================================
 Package          Arch              Version                        Repository              Size
================================================================================================
Removing:
 httpd            x86_64            2.4.6-90.el7.centos            @base                  9.4 M
Removing for dependencies:
 php              x86_64            7.2.26-1.el7.remi              @remi-php72             10 M

Transaction Summary
================================================================================================
Remove  1 Package (+1 Dependent package)

Installed size: 19 M
Downloading packages:
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Erasing    : php-7.2.26-1.el7.remi.x86_64                                                 1/2
  Erasing    : httpd-2.4.6-90.el7.centos.x86_64                                             2/2
warning: directory /var/www/html: remove failed: Device or resource busy
warning: /etc/httpd/conf/httpd.conf saved as /etc/httpd/conf/httpd.conf.rpmsave
  Verifying  : php-7.2.26-1.el7.remi.x86_64                                                 1/2
  Verifying  : httpd-2.4.6-90.el7.centos.x86_64                                             2/2

Removed:
  httpd.x86_64 0:2.4.6-90.el7.centos

Dependency Removed:
  php.x86_64 0:7.2.26-1.el7.remi

Complete!
[steve@stapp02 ~]$ sudo yum install httpd -y
Loaded plugins: fastestmirror, ovl
Determining fastest mirrors

epel/x86_64/metalink                                                     |  30 kB  00:00:00
 * base: mirror.softaculous.com
 * epel: mirror.de.leaseweb.net
 * extras: ftp.rz.uni-frankfurt.de
 * remi-php72: mirror.23media.com
 * remi-safe: mirror.23media.com
 * updates: centosmirror.netcup.net
base                                                                     | 3.6 kB  00:00:00
epel                                                                     | 4.7 kB  00:00:00
extras                                                                   | 2.9 kB  00:00:00
remi-php72                                                               | 3.0 kB  00:00:00
remi-safe                                                                | 3.0 kB  00:00:00
updates                                                                  | 2.9 kB  00:00:00
(1/9): base/7/x86_64/group_gz                                            | 153 kB  00:00:00
(2/9): epel/x86_64/group_gz                                              |  95 kB  00:00:00
(3/9): extras/7/x86_64/primary_db                                        | 205 kB  00:00:00
(4/9): base/7/x86_64/primary_db                                          | 6.1 MB  00:00:00
(5/9): epel/x86_64/updateinfo                                            | 1.0 MB  00:00:00
(6/9): epel/x86_64/primary_db                                            | 6.8 MB  00:00:00
(7/9): updates/7/x86_64/primary_db                                       | 3.0 MB  00:00:00
(8/9): remi-php72/primary_db                                             | 240 kB  00:00:00
(9/9): remi-safe/primary_db                                              | 1.7 MB  00:00:01

Resolving Dependencies
--> Running transaction check
---> Package httpd.x86_64 0:2.4.6-93.el7.centos will be installed
--> Processing Dependency: httpd-tools = 2.4.6-93.el7.centos for package: httpd-2.4.6-93.el7.centos.x86_64
--> Running transaction check
---> Package httpd-tools.x86_64 0:2.4.6-90.el7.centos will be updated
---> Package httpd-tools.x86_64 0:2.4.6-93.el7.centos will be an update
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================================
 Package                Arch              Version                         Repository       Size
================================================================================================
Installing:
 httpd                  x86_64            2.4.6-93.el7.centos             base            2.7 M
Updating for dependencies:
 httpd-tools            x86_64            2.4.6-93.el7.centos             base             92 k

Transaction Summary
================================================================================================
Install  1 Package
Upgrade             ( 1 Dependent package)

Total download size: 2.8 M
Downloading packages:
Delta RPMs disabled because /usr/bin/applydeltarpm not installed.
(1/2): httpd-tools-2.4.6-93.el7.centos.x86_64.rpm                        |  92 kB  00:00:00
(2/2): httpd-2.4.6-93.el7.centos.x86_64.rpm                              | 2.7 MB  00:00:00
------------------------------------------------------------------------------------------------
Total                                                            13 MB/s | 2.8 MB  00:00:00
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Updating   : httpd-tools-2.4.6-93.el7.centos.x86_64                                       1/3
  Installing : httpd-2.4.6-93.el7.centos.x86_64                                             2/3
  Cleanup    : httpd-tools-2.4.6-90.el7.centos.x86_64                                       3/3
  Verifying  : httpd-tools-2.4.6-93.el7.centos.x86_64                                       1/3
  Verifying  : httpd-2.4.6-93.el7.centos.x86_64                                             2/3
  Verifying  : httpd-tools-2.4.6-90.el7.centos.x86_64                                       3/3

Installed:
  httpd.x86_64 0:2.4.6-93.el7.centos

Dependency Updated:
  httpd-tools.x86_64 0:2.4.6-93.el7.centos

Complete!
[steve@stapp02 ~]$ sudo vi /etc/httpd/conf/httpd.conf
[steve@stapp02 ~]$ sudo systemctl restart httpd
[steve@stapp02 ~]$ systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: active (running) since Wed 2020-07-15 18:48:09 UTC; 734ms ago
     Docs: man:httpd(8)
           man:apachectl(8)
 Main PID: 468 (httpd)
   Status: "Processing requests..."
   CGroup: /docker/bb5cc0accc09d8702a3e34a009c1f62159d85ee67cdcae9066c330828ccf2ee6/system.slice/httpd.service
           ├─468 /usr/sbin/httpd -DFOREGROUND
           ├─469 /usr/sbin/httpd -DFOREGROUND
           ├─470 /usr/sbin/httpd -DFOREGROUND
           ├─471 /usr/sbin/httpd -DFOREGROUND
           ├─472 /usr/sbin/httpd -DFOREGROUND
           └─473 /usr/sbin/httpd -DFOREGROUND

Jul 15 18:48:09 stapp02 systemd[1]: Starting The Apache HTTP Server...
Jul 15 18:48:09 stapp02 systemd[1]: Started The Apache HTTP Server.
[steve@stapp02 ~]$
[steve@stapp02 ~]$ exit
logout
Connection to 172.16.238.11 closed.
thor@jump_host /$
thor@jump_host /$ curl http://172.16.238.11:8087/
Welcome to xFusionCorp Industries !
thor@jump_host /$
thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
Warning: Permanently added '172.16.238.12' (ECDSA) to the list of known hosts.
[banner@stapp03 ~]$ sudo yum remove httpd -y

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for banner:
Loaded plugins: fastestmirror, ovl
Resolving Dependencies
--> Running transaction check
---> Package httpd.x86_64 0:2.4.6-90.el7.centos will be erased
--> Processing Dependency: httpd-mmn = 20120211x8664 for package: php-7.2.26-1.el7.remi.x86_64
--> Running transaction check
---> Package php.x86_64 0:7.2.26-1.el7.remi will be erased
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================================
 Package          Arch              Version                        Repository              Size
================================================================================================
Removing:
 httpd            x86_64            2.4.6-90.el7.centos            @base                  9.4 M
Removing for dependencies:
 php              x86_64            7.2.26-1.el7.remi              @remi-php72             10 M

Transaction Summary
================================================================================================
Remove  1 Package (+1 Dependent package)

Installed size: 19 M
Downloading packages:
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Erasing    : php-7.2.26-1.el7.remi.x86_64                                                 1/2
  Erasing    : httpd-2.4.6-90.el7.centos.x86_64                                             2/2
warning: directory /var/www/html: remove failed: Device or resource busy
warning: /etc/httpd/conf/httpd.conf saved as /etc/httpd/conf/httpd.conf.rpmsave
  Verifying  : php-7.2.26-1.el7.remi.x86_64                                                 1/2
  Verifying  : httpd-2.4.6-90.el7.centos.x86_64                                             2/2

Removed:
  httpd.x86_64 0:2.4.6-90.el7.centos

Dependency Removed:
  php.x86_64 0:7.2.26-1.el7.remi

Complete!
[banner@stapp03 ~]$ sudo yum install httpd -y
Loaded plugins: fastestmirror, ovl
Determining fastest mirrors

epel/x86_64/metalink                                                     |  30 kB  00:00:00
 * base: mirror.softaculous.com
 * epel: mirrors.n-ix.net
 * extras: mirror.ratiokontakt.de
 * remi-php72: mirror.23media.com
 * remi-safe: mirror.23media.com
 * updates: centosmirror.netcup.net
base                                                                     | 3.6 kB  00:00:00
epel                                                                     | 4.7 kB  00:00:00
extras                                                                   | 2.9 kB  00:00:00
remi-php72                                                               | 3.0 kB  00:00:00
remi-safe                                                                | 3.0 kB  00:00:00
updates                                                                  | 2.9 kB  00:00:00
(1/9): base/7/x86_64/group_gz                                            | 153 kB  00:00:00
(2/9): epel/x86_64/primary_db                                            | 6.8 MB  00:00:00
(3/9): extras/7/x86_64/primary_db                                        | 205 kB  00:00:00
(4/9): epel/x86_64/group_gz                                              |  95 kB  00:00:00
(5/9): epel/x86_64/updateinfo                                            | 1.0 MB  00:00:00
(6/9): base/7/x86_64/primary_db                                          | 6.1 MB  00:00:00
(7/9): updates/7/x86_64/primary_db                                       | 3.0 MB  00:00:00
(8/9): remi-php72/primary_db                                             | 240 kB  00:00:00
(9/9): remi-safe/primary_db                                              | 1.7 MB  00:00:01
Resolving Dependencies
--> Running transaction check
---> Package httpd.x86_64 0:2.4.6-93.el7.centos will be installed
--> Processing Dependency: httpd-tools = 2.4.6-93.el7.centos for package: httpd-2.4.6-93.el7.centos.x86_64
--> Running transaction check
---> Package httpd-tools.x86_64 0:2.4.6-90.el7.centos will be updated
---> Package httpd-tools.x86_64 0:2.4.6-93.el7.centos will be an update
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================================
 Package                Arch              Version                         Repository       Size
================================================================================================
Installing:
 httpd                  x86_64            2.4.6-93.el7.centos             base            2.7 M
Updating for dependencies:
 httpd-tools            x86_64            2.4.6-93.el7.centos             base             92 k

Transaction Summary
================================================================================================
Install  1 Package
Upgrade             ( 1 Dependent package)

Total download size: 2.8 M
Downloading packages:
Delta RPMs disabled because /usr/bin/applydeltarpm not installed.
(1/2): httpd-tools-2.4.6-93.el7.centos.x86_64.rpm                        |  92 kB  00:00:00
(2/2): httpd-2.4.6-93.el7.centos.x86_64.rpm                              | 2.7 MB  00:00:00
------------------------------------------------------------------------------------------------
Total                                                            10 MB/s | 2.8 MB  00:00:00
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Updating   : httpd-tools-2.4.6-93.el7.centos.x86_64                                       1/3
  Installing : httpd-2.4.6-93.el7.centos.x86_64                                             2/3
  Cleanup    : httpd-tools-2.4.6-90.el7.centos.x86_64                                       3/3
  Verifying  : httpd-tools-2.4.6-93.el7.centos.x86_64                                       1/3
  Verifying  : httpd-2.4.6-93.el7.centos.x86_64                                             2/3
  Verifying  : httpd-tools-2.4.6-90.el7.centos.x86_64                                       3/3

Installed:
  httpd.x86_64 0:2.4.6-93.el7.centos

Dependency Updated:
  httpd-tools.x86_64 0:2.4.6-93.el7.centos

Complete!
[banner@stapp03 ~]$ sudo vi /etc/httpd/conf/httpd.conf
[banner@stapp03 ~]$
[banner@stapp03 ~]$ sudo systemctl restart httpd
[banner@stapp03 ~]$ systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: active (running) since Wed 2020-07-15 18:50:34 UTC; 15ms ago
     Docs: man:httpd(8)
           man:apachectl(8)
 Main PID: 497 (httpd)
   Status: "Processing requests..."
   CGroup: /docker/b0d4a12de9a777b23a8acff71070c86cf150f86c13c4b9731445a20766a8215d/system.slice/httpd.service
           ├─497 /usr/sbin/httpd -DFOREGROUND
           ├─498 /usr/sbin/httpd -DFOREGROUND
           ├─499 /usr/sbin/httpd -DFOREGROUND
           ├─501 /usr/sbin/httpd -DFOREGROUND
           ├─502 /usr/sbin/httpd -DFOREGROUND
           └─503 /usr/sbin/httpd -DFOREGROUND

Jul 15 18:50:34 stapp03 systemd[1]: Starting The Apache HTTP Server...
Jul 15 18:50:34 stapp03 systemd[1]: Started The Apache HTTP Server.
[banner@stapp03 ~]$ exit
logout
Connection to 172.16.238.12 closed.
thor@jump_host /$
thor@jump_host /$ curl http://172.16.238.10:8087/
Welcome to xFusionCorp Industries !
thor@jump_host /$ curl http://172.16.238.11:8087/
Welcome to xFusionCorp Industries !
thor@jump_host /$ curl http://172.16.238.12:8087/
Welcome to xFusionCorp Industries !
thor@jump_host /$
thor@jump_host /$
thor@jump_host /$
thor@jump_host /$
thor@jump_host /$
thor@jump_host /$ Connection to host01 closed by remote host.
Connection to host01 closed.

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

