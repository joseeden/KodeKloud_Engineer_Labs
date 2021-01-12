
-----------------------------------------------------------------------------------------------------------------

Start			2020-08-04 || 06:33 AM
Finished		2020-08-04 || 02:08 PM

-----------------------------------------------------------------------------------------------------------------

TASK 29 - Application Security

REQUIREMENTS:

We have a backup management application UI hosted on Nautilus backup server in Stratos DC. That backup management application code is deployed under Apache on the backup server itself, and Nginx is running as a reverse proxy on the same server. Apache and Nginx ports are 5003 and 8096, respectively. We have iptables firewall installed on this server. Make the appropriate changes to fulfill the requirements mentioned below:

We want to open all incoming connections to Nginx port and block all incoming connections to Apache port. Also make sure rules are permanent.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://community.kodekloud.com/t/iptables-task-application-security/3930/7
https://community.kodekloud.com/t/iptables-task-application-security/3930
https://community.kodekloud.com/t/task-application-security/5989
https://community.kodekloud.com/t/application-security/1164/10
https://community.kodekloud.com/t/application-security-task/5202/3

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

#	1.	Connect to the backup server via SSH, switch to root user, and check iptables
#	2.	Run a command that will add the rules for rejecting and allowing traffic from certain ports.
#	3.	Make sure iptables is save permanently and restarted.
#	4.	Verify iptables -- from the jumphost and from the backup server.

-----------------------------------------------------------------------------------------------------------------

III.	COMMANDS USED

#	1.	Connect to the backup server via SSH, switch to root user, and check iptables

#			So I actually just spent a small time doing searching in the KKC articles and doing the actual lab.
#			I was on-duty at work and occupied wwith some things when I performed this lab.
#			So as much as I want to read and learn more about iptables and securing application, I didn't have the
#			mental energy to do that so I just instead went though the KKC artice/s and fortunately i got all the steps
#			I need from first 2 articles. I skimmed some 3 more articles but the first one was concrete, although it did not
#			explain the concept behind securing application -- for that, I need to seek Mr. Google.
#			But I'll probably do that next time I encounter a similar task or if I have some spare time.

			sshpass -p '******' ssh -o StrictHostKeyChecking=no  clint@172.16.238.16
			sudo su - 
			
#			Again, it's always best to check the directory and file that I need during the lab.
			
			ls -l /etc/sysconfig/iptables	
			cat /etc/sysconfig/iptables

#	2.	Run a command that will add the rules for rejecting and allowing traffic from certain ports.

#			So for this was, I didn't really read about this line, but I'll try to look it up in the internet when I have time.
#			I have to note here that I almost got it wrong because the question was arranged in a tricky manner that I almost
#			rejected and accepted the incorrect ports.
#			Luckily, I went back to the instructions and read it for a second time. The ports was mentioned in reverse order.
#			So I just switched the port numbers.
			
			sudo iptables -A INPUT -p tcp --dport 8096  -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
			sudo iptables -A INPUT -p tcp --dport 5003 -m conntrack --ctstate NEW -j REJECT

#	3.	Make sure iptables is save permanently and restarted.

#			For this one, there were different method/s to permnently save the iptables as some of the guys who did the lab
#			failed because the changes they made were not permanentlyy saved and did not reflect when the service was
#			restarted.
#			I followed one suggestion and tried it during my first attempt. Everything worked up to the testing part so
#			I just restarted the lab and did all the steps within 10 minutes --- this is so I can get the 150 points bonus.

			yum install iptables-services -y
			service iptables save 						# save the current iptables rules in /etc/sysconfig/iptables
			service iptables restart 					# optional, if needed to reload

#	4.	Verify iptables -- from the jumphost and from the backup server.

#			The lab can be tested from the backup server and from the jumphost.
#			From the backup server, run the two commands. This should return descriptive tables.

			iptables -L 
			iptables -nvL 
			
#			Return to the jump host and curl the backup server's IP using the two different ports.
#			One should return a detailed output while the other should return a 'Connection refused' message.

#			For the first curl command, this is going through the nginx port 4096 -- all incoming traffic are allowed here.
#			So this should return a detailed output.

			curl -I 172.16.238.16:8096
			
				HTTP/1.1 403 Forbidden
				Server: nginx/1.16.1
				Date: Mon, 03 Aug 2020 23:42:20 GMT
				Content-Type: text/html
				Content-Length: 153
				Connection: keep-alive

#			For the second curl command, this is going through the apache port 5003 -- all incoming traffic are rejected here.
#			So this should return a 'Connection refused' message.
			
			curl -I 172.16.238.16:5003 
				
				curl: (7) Failed connect to 172.16.238.16:5003; Connection refused
			
-----------------------------------------------------------------------------------------------------------------

IV.	STEPS - BREAKDOWN


thor@jump_host /$ sshpass -p '******' ssh -o StrictHostKeyChecking=no  clint@172.16.238.16Warning: Permanently added '172.16.238.16' (ECDSA) to the list of known hosts.
[clint@stbkp01 ~]$[clint@stbkp01 ~]$ sudo su -

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for clint:
[root@stbkp01 ~]#[root@stbkp01 ~]# ls -l /etc/sysconfig
total 64-rw-r--r-- 29 root root  102 Aug  1  2019 anaconda
drwxr-xr-x  2 root root 4096 Oct 15  2019 cbq
drwxr-xr-x  2 root root 4096 Aug  8  2019 console
-rw-r--r--  1 root root  348 Aug  6  2019 htcacheclean
-rw-r--r--  1 root root  802 Aug  6  2019 httpd
-rw-r--r-- 21 root root  798 Aug  8  2019 init
-rw-------  1 root root  635 Aug  8  2019 ip6tables
-rw------- 21 root root 2134 Aug  8  2019 ip6tables-config
-rw-------  1 root root  550 Aug  8  2019 iptables
-rw------- 21 root root 2116 Aug  8  2019 iptables-config
drwxr-xr-x  2 root root 4096 Aug  8  2019 modules
-rw-r--r-- 21 root root  634 Aug  8  2019 netconsole
drwxr-xr-x  2 root root 4096 Oct 15  2019 network-scripts
-rw-r--r-- 29 root root   15 Aug  4  2017 rdisc
-rw-r--r-- 21 root root  905 Aug  8  2019 readonly-root
-rw-r----- 20 root root  506 Aug  9  2019 sshd
[root@stbkp01 ~]#
[root@stbkp01 ~]# cat /etc/sysconfig/iptables
# sample configuration for iptables service
# you can edit this manually or use system-config-firewall
# please do not ask us to add additional ports/services to this default configuration
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
-A INPUT -p icmp -j ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT
-A INPUT -j REJECT --reject-with icmp-host-prohibited
-A FORWARD -j REJECT --reject-with icmp-host-prohibited
COMMIT
[root@stbkp01 ~]#
[root@stbkp01 ~]# yum install iptables-services -y
Loaded plugins: fastestmirror, ovl
Determining fastest mirrors
epel/x86_64/metalink                                                     |  33 kB  00:00:00
 * base: centosmirror.netcup.net
 * epel: mirrors.n-ix.net
 * extras: linux.darkpenguin.net
 * updates: centosmirror.netcup.net
base                                                                     | 3.6 kB  00:00:00
epel                                                                     | 4.7 kB  00:00:00
extras                                                                   | 2.9 kB  00:00:00
updates                                                                  | 2.9 kB  00:00:00
(1/7): base/7/x86_64/group_gz                                            | 153 kB  00:00:00
(2/7): extras/7/x86_64/primary_db                                        | 205 kB  00:00:00
(3/7): epel/x86_64/primary_db                                            | 6.9 MB  00:00:00
(4/7): epel/x86_64/updateinfo                                            | 1.0 MB  00:00:00
(5/7): epel/x86_64/group_gz                                              |  95 kB  00:00:00
(6/7): updates/7/x86_64/primary_db                                       | 3.7 MB  00:00:00
(7/7): base/7/x86_64/primary_db                                          | 6.1 MB  00:00:00
Resolving Dependencies
--> Running transaction check
---> Package iptables-services.x86_64 0:1.4.21-33.el7 will be updated
---> Package iptables-services.x86_64 0:1.4.21-34.el7 will be an update
--> Processing Dependency: iptables = 1.4.21-34.el7 for package: iptables-services-1.4.21-34.el7.x86_64
--> Running transaction check
---> Package iptables.x86_64 0:1.4.21-33.el7 will be updated
---> Package iptables.x86_64 0:1.4.21-34.el7 will be an update
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================================
 Package                      Arch              Version                   Repository       Size
================================================================================================
Updating:
 iptables-services            x86_64            1.4.21-34.el7             base             52 k
Updating for dependencies:
 iptables                     x86_64            1.4.21-34.el7             base            432 k

Transaction Summary
================================================================================================
Upgrade  1 Package (+1 Dependent package)

Total download size: 485 k
Downloading packages:
Delta RPMs disabled because /usr/bin/applydeltarpm not installed.
(1/2): iptables-services-1.4.21-34.el7.x86_64.rpm                        |  52 kB  00:00:00
(2/2): iptables-1.4.21-34.el7.x86_64.rpm                                 | 432 kB  00:00:00
------------------------------------------------------------------------------------------------
Total                                                           3.5 MB/s | 485 kB  00:00:00
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Updating   : iptables-1.4.21-34.el7.x86_64                                                1/4
  Updating   : iptables-services-1.4.21-34.el7.x86_64                                       2/4
  Cleanup    : iptables-services-1.4.21-33.el7.x86_64                                       3/4
  Cleanup    : iptables-1.4.21-33.el7.x86_64                                                4/4
  Verifying  : iptables-services-1.4.21-34.el7.x86_64                                       1/4
  Verifying  : iptables-1.4.21-34.el7.x86_64                                                2/4
  Verifying  : iptables-services-1.4.21-33.el7.x86_64                                       3/4
  Verifying  : iptables-1.4.21-33.el7.x86_64                                                4/4

Updated:
  iptables-services.x86_64 0:1.4.21-34.el7

Dependency Updated:
  iptables.x86_64 0:1.4.21-34.el7

Complete!
[root@stbkp01 ~]# service iptables save
iptables: Saving firewall rules to /etc/sysconfig/iptables:[  OK  ]
[root@stbkp01 ~]# service iptables restart
Redirecting to /bin/systemctl restart iptables.service
[root@stbkp01 ~]#
[root@stbkp01 ~]# sudo iptables -A INPUT -p tcp --dport 8096  -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
[root@stbkp01 ~]#
[root@stbkp01 ~]# sudo iptables -A INPUT -p tcp --dport 5003 -m conntrack --ctstate NEW -j REJECT
[root@stbkp01 ~]#
[root@stbkp01 ~]# service iptables save
iptables: Saving firewall rules to /etc/sysconfig/iptables:[  OK  ]
[root@stbkp01 ~]# service iptables restart
Redirecting to /bin/systemctl restart iptables.service
[root@stbkp01 ~]#
[root@stbkp01 ~]# ls -l /etc/sysconfig
total 68
-rw-r--r-- 29 root root  102 Aug  1  2019 anaconda
drwxr-xr-x  2 root root 4096 Oct 15  2019 cbq
drwxr-xr-x  2 root root 4096 Aug  8  2019 console
-rw-r--r--  1 root root  348 Aug  6  2019 htcacheclean
-rw-r--r--  1 root root  802 Aug  6  2019 httpd
-rw-r--r-- 21 root root  798 Aug  8  2019 init
-rw-------  1 root root  635 Apr  2 15:57 ip6tables
-rw-------  1 root root 2134 Apr  2 15:57 ip6tables-config
-rw-------  1 root root 1127 Aug  3 23:39 iptables
-rw-------  1 root root 2116 Apr  2 15:57 iptables-config
-rw-------  1 root root  960 Aug  3 23:39 iptables.save
drwxr-xr-x  2 root root 4096 Aug  8  2019 modules
-rw-r--r-- 21 root root  634 Aug  8  2019 netconsole
drwxr-xr-x  2 root root 4096 Oct 15  2019 network-scripts
-rw-r--r-- 29 root root   15 Aug  4  2017 rdisc
-rw-r--r-- 21 root root  905 Aug  8  2019 readonly-root
-rw-r----- 20 root root  506 Aug  9  2019 sshd
[root@stbkp01 ~]#
[root@stbkp01 ~]# cat /etc/sysconfig/iptables
# Generated by iptables-save v1.4.21 on Mon Aug  3 23:39:25 2020
*nat
:PREROUTING ACCEPT [0:0]
:INPUT ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
:POSTROUTING ACCEPT [0:0]
:DOCKER_OUTPUT - [0:0]
:DOCKER_POSTROUTING - [0:0]
-A OUTPUT -d 127.0.0.11/32 -j DOCKER_OUTPUT
-A POSTROUTING -d 127.0.0.11/32 -j DOCKER_POSTROUTING
-A DOCKER_OUTPUT -d 127.0.0.11/32 -p tcp -m tcp --dport 53 -j DNAT --to-destination 127.0.0.11:43773
-A DOCKER_OUTPUT -d 127.0.0.11/32 -p udp -m udp --dport 53 -j DNAT --to-destination 127.0.0.11:42330
-A DOCKER_POSTROUTING -s 127.0.0.11/32 -p tcp -m tcp --sport 43773 -j SNAT --to-source :53
-A DOCKER_POSTROUTING -s 127.0.0.11/32 -p udp -m udp --sport 42330 -j SNAT --to-source :53
COMMIT
# Completed on Mon Aug  3 23:39:25 2020
# Generated by iptables-save v1.4.21 on Mon Aug  3 23:39:25 2020
*filter
:INPUT ACCEPT [24:1368]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [22:2096]
-A INPUT -p tcp -m tcp --dport 8096 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
-A INPUT -p tcp -m tcp --dport 5003 -m conntrack --ctstate NEW -j REJECT --reject-with icmp-port-unreachable
COMMIT
# Completed on Mon Aug  3 23:39:25 2020
[root@stbkp01 ~]#
[root@stbkp01 ~]# iptable -L
-bash: iptable: command not found
[root@stbkp01 ~]#
[root@stbkp01 ~]# iptable -nvL
-bash: iptable: command not found
[root@stbkp01 ~]#
[root@stbkp01 ~]# iptable -h
-bash: iptable: command not found
[root@stbkp01 ~]#
[root@stbkp01 ~]# iptable --help
-bash: iptable: command not found
[root@stbkp01 ~]#
[root@stbkp01 ~]# ip -h
Usage: ip [ OPTIONS ] OBJECT { COMMAND | help }
       ip [ -force ] -batch filename
where  OBJECT := { link | address | addrlabel | route | rule | neigh | ntable |
                   tunnel | tuntap | maddress | mroute | mrule | monitor | xfrm |
                   netns | l2tp | fou | macsec | tcp_metrics | token | netconf | ila |
                   vrf }
       OPTIONS := { -V[ersion] | -s[tatistics] | -d[etails] | -r[esolve] |
                    -h[uman-readable] | -iec |
                    -f[amily] { inet | inet6 | ipx | dnet | mpls | bridge | link } |
                    -4 | -6 | -I | -D | -B | -0 |
                    -l[oops] { maximum-addr-flush-attempts } | -br[ief] |
                    -o[neline] | -t[imestamp] | -ts[hort] | -b[atch] [filename] |
                    -rc[vbuf] [size] | -n[etns] name | -a[ll] | -c[olor]}
[root@stbkp01 ~]#
[root@stbkp01 ~]# iptables -L
Chain INPUT (policy ACCEPT)
target     prot opt source               destination
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:8096 ctstate NEW,ESTABLISHED
REJECT     tcp  --  anywhere             anywhere             tcp dpt:fmpro-internal ctstate NEW reject-with icmp-port-unreachable

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination
[root@stbkp01 ~]#
[root@stbkp01 ~]#
[root@stbkp01 ~]# iptables -nvL
Chain INPUT (policy ACCEPT 224 packets, 13644 bytes)
 pkts bytes target     prot opt in     out     source               destination
    0     0 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp dpt:8096 ctstate NEW,ESTABLISHED
    0     0 REJECT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp dpt:5003 ctstate NEW reject-with icmp-port-unreachable

Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination

Chain OUTPUT (policy ACCEPT 171 packets, 19536 bytes)
 pkts bytes target     prot opt in     out     source               destination
[root@stbkp01 ~]#
[root@stbkp01 ~]# service iptables save
iptables: Saving firewall rules to /etc/sysconfig/iptables:[  OK  ]
[root@stbkp01 ~]# service iptables restart
Redirecting to /bin/systemctl restart iptables.service
[root@stbkp01 ~]#
[root@stbkp01 ~]# exit
logout
[clint@stbkp01 ~]$
[clint@stbkp01 ~]$ exit
logout
Connection to 172.16.238.16 closed.
thor@jump_host /$
thor@jump_host /$ curl -I 172.16.238.16:8096
HTTP/1.1 403 Forbidden
Server: nginx/1.16.1
Date: Mon, 03 Aug 2020 23:42:20 GMT
Content-Type: text/html
Content-Length: 153
Connection: keep-alive

thor@jump_host /$
thor@jump_host /$ curl -I 172.16.238.16:5003
curl: (7) Failed connect to 172.16.238.16:5003; Connection refused
thor@jump_host /$
thor@jump_host /$


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


