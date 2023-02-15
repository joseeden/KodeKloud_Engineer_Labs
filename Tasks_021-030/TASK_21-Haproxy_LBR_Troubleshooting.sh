
-----------------------------------------------------------------------------------------------------------------

Start		2020-07-22 || 11:41 PM	
Finished	2020-07-23 || 01:07 AM

-----------------------------------------------------------------------------------------------------------------

TASK 21 - Haproxy LBR Troubleshooting 

REQUIREMENTS:

xFusionCorp Industries has an application running on Nautlitus infrastructure in Stratos Datacenter. The monitoring tool recognised that there is an issue with the haproxy service on LBR server. That needs to fixed to make the application work properly.

Troubleshoot and fix the issue, and make sure haproxy service is running on Nautilus LBR server.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://community.kodekloud.com/t/haproxy-lbr-troubleshooting/1703/12						#	very useful
https://www.haproxy.com/blog/the-four-essential-sections-of-an-haproxy-configuration/
https://community.kodekloud.com/t/haproxy-lbr-troubleshooting/1703
https://community.kodekloud.com/t/haproxy-lbr-troubleshooting-please-help/4307/17			#	same case as my 2nd 

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

	1.	Connect to the LBR server
	2.	Check status of haproxy service. Verify also if config file is valid.
	3.	Modify config file - change any incorrect part.
	4.	Restart service and then verify.

-----------------------------------------------------------------------------------------------------------------

III.	COMMANDS USED

#	these were the commands I used during troubleshooting
sshpass -p '******' ssh -o StrictHostKeyChecking=no  loki@172.16.238.14
systemctl status haproxy
ls -l /usr/lib/systemd/system | grep haprox
sudo systemctl restart haproxy
cat /usr/lib/systemd/system/haproxy.service
sudo vi /usr/lib/systemd/system/haproxy.service
systemctl daemon-reload
haproxy -c -f /etc/haproxy/haproxy.cfg


#	these were the commands I used to finish the lab
#	1.	Connect to the LBR server
#		This was actually the first time that I connected to this server.

sshpass -p '******' ssh -o StrictHostKeyChecking=no  loki@172.16.238.14

#	2.	Check status of haproxy service. Verify also if config file is valid.
#		Status shows 'dead' so I restarted it and checked status again.
#		Status shows more information after restarting service.

systemctl status haproxy
sudo systemctl restart haproxy
systemctl status haproxy

#		So as an additional step, I checked the content for the haproxy.service file
#		before I checked the haproxy.cfg config file.

cat /usr/lib/systemd/system/haproxy.service
cat /etc/haproxy/haproxy.cfg

#		Then I verified if config file is valid. 
#		Now this one, I don't really have a clue of this.
#		I just found this on one article from KKC.
#		I read the whole forum of course, but this is definitely the first time I
#		saw this kind of issue and ofcourse, this command.

haproxy -c -f /etc/haproxy/haproxy.cfg						#	checks config file

#	3.	Modify config file - change any incorrect part.
#		Now this is the part where it all gets tricky. As one KKC article suggests,
#		there's just a typo error on the config file. The article suggests finding the 
#		'checking' and then changing it to 'check'
#		I found that, changed it, resarted the service and then verified it's working.
#		Believing this was the final solution, I hit 'Try again' and redo the steps again 
#		up to config file.
#		And voila, there was no typo error and 'check' was in there.
#		So I t-shooted for a bit and returned to the config file and read it again.
#		Issued again this command to see if it will show another information

haproxy -c -f /etc/haproxy/haproxy.cfg

#		And lo and behold, it says it can't find the backend app or something.
#		So I went back to the config file, found the section, and indeed the line that 
#		should describe the app was COMMENTED.
#		So I removed the comment.

sudo vi /etc/haproxy/haproxy.cfg

#	4.	Restart service and then verify.
#		After uncommenting that particular line, I restarted the service and checked the status,
#		And yes, it's now showing as 'RUNNING'

sudo systemctl restart haproxy
systemctl status haproxy

#		So as always, there's suppose to be some way other than the status to verify if everything
#		is working as they should. So I issued this command again.
#		Luckily, it now shows 'CONFIGURATION FILE IS VALID'

haproxy -c -f /etc/haproxy/haproxy.cfg

-----------------------------------------------------------------------------------------------------------------

IV.	STEPS - BREAKDOWN

#		So this one lies somewhere between 'RIGHT ON' and 'QUITE HARD'
#		But I guess it's much better to say taht it was tricky.
#		This lab took me around 3 or 4 attempts and it took more time that I expected.
#		I did a couple of t-chooting on my own before caving in to check the KKC.
#		And as mentioned in the section above, there were two errors that I encountered here.

thor@jump_host /$thor@jump_host /$ sshpass -p '******' ssh -o StrictHostKeyChecking=no  loki@172.16.238.14
Warning: Permanently added '172.16.238.14' (ECDSA) to the list of known hosts.
[loki@stlb01 ~]$
[loki@stlb01 ~]$ systemctl status haproxy
● haproxy.service - HAProxy Load Balancer
   Loaded: loaded (/usr/lib/systemd/system/haproxy.service; disabled; vendor preset: disabled)
   Active: inactive (dead)
[loki@stlb01 ~]$
[loki@stlb01 ~]$ sudo systemctl restart haproxy

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for loki:
Sorry, try again.
[sudo] password for loki:
[loki@stlb01 ~]$ systemctl status haproxy
● haproxy.service - HAProxy Load Balancer
   Loaded: loaded (/usr/lib/systemd/system/haproxy.service; disabled; vendor preset: disabled)
   Active: failed (Result: exit-code) since Wed 2020-07-22 16:26:28 UTC; 7s ago
  Process: 91 ExecStart=/usr/sbin/haproxy-systemd-wrapper -f /etc/haproxy/haproxy.cfg -p /run/haproxy.pid $OPTIONS (code=exited, status=1/FAILURE)
 Main PID: 91 (code=exited, status=1/FAILURE)

Jul 22 16:26:28 stlb01 systemd[91]: Executing: /usr/sbin/haproxy-systemd-wrapper -f /etc/h...pid
Jul 22 16:26:28 stlb01 haproxy-systemd-wrapper[91]: [ALERT] 203/162628 (92) : Proxy 'main':...
Jul 22 16:26:28 stlb01 haproxy-systemd-wrapper[91]: [ALERT] 203/162628 (92) : Fatal errors ...n.
Jul 22 16:26:28 stlb01 haproxy-systemd-wrapper[91]: haproxy-systemd-wrapper: exit, haproxy RC=1
Jul 22 16:26:28 stlb01 systemd[1]: Child 91 belongs to haproxy.service
Jul 22 16:26:28 stlb01 systemd[1]: haproxy.service: main process exited, code=exited, sta...LURE
Jul 22 16:26:28 stlb01 systemd[1]: haproxy.service changed running -> failed
Jul 22 16:26:28 stlb01 systemd[1]: Unit haproxy.service entered failed state.
Jul 22 16:26:28 stlb01 systemd[1]: haproxy.service failed.
Jul 22 16:26:28 stlb01 systemd[1]: haproxy.service: cgroup is empty
Hint: Some lines were ellipsized, use -l to show in full.
[loki@stlb01 ~]$
[loki@stlb01 ~]$ haproxy -c -f /etc/haproxy/haproxy.cfg
[ALERT] 203/162654 (94) : Proxy 'main': unable to find required default_backend: 'app'.
[ALERT] 203/162654 (94) : Fatal errors found in configuration.
[loki@stlb01 ~]$ cat /usr/lib/systemd/system/haproxy.service
[Unit]
Description=HAProxy Load Balancer
After=syslog.target network.target

[Service]
EnvironmentFile=/etc/sysconfig/haproxy
ExecStart=/usr/sbin/haproxy-systemd-wrapper -f /etc/haproxy/haproxy.cfg -p /run/haproxy.pid $OPTIONS
ExecReload=/bin/kill -USR2 $MAINPID
KillMode=mixed

[Install]
WantedBy=multi-user.target
[loki@stlb01 ~]$ cat /etc/haproxy/haproxy.cfg
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
#backend app
    balance     roundrobin
    server  app1 127.0.0.1:5001 check
    server  app2 127.0.0.1:5002 check
    server  app3 127.0.0.1:5003 check
    server  app4 127.0.0.1:5004 check

[loki@stlb01 ~]$
[loki@stlb01 ~]$ sudo vi /etc/haproxy/haproxy.cfg
[loki@stlb01 ~]$
[loki@stlb01 ~]$ sudo systemctl restart haproxy
[loki@stlb01 ~]$
[loki@stlb01 ~]$ systemctl status haproxy
● haproxy.service - HAProxy Load Balancer
   Loaded: loaded (/usr/lib/systemd/system/haproxy.service; disabled; vendor preset: disabled)
   Active: active (running) since Wed 2020-07-22 16:29:40 UTC; 12s ago
 Main PID: 103 (haproxy-systemd)
   CGroup: /docker/d49cf7172d89e6a56c8bd6410f9e7d57aa40ff58316736ccf08849e1eedae93e/system.slice/haproxy.service
           ├─103 /usr/sbin/haproxy-systemd-wrapper -f /etc/haproxy/haproxy.cfg -p /run/haprox...
           ├─104 /usr/sbin/haproxy -f /etc/haproxy/haproxy.cfg -p /run/haproxy.pid -Ds
           └─105 /usr/sbin/haproxy -f /etc/haproxy/haproxy.cfg -p /run/haproxy.pid -Ds

Jul 22 16:29:40 stlb01 systemd[1]: Enqueued job haproxy.service/restart as 162
Jul 22 16:29:40 stlb01 systemd[1]: Job haproxy.service/restart finished, result=done
Jul 22 16:29:40 stlb01 systemd[1]: Converting job haproxy.service/restart -> haproxy.serv...tart
Jul 22 16:29:40 stlb01 systemd[1]: About to execute: /usr/sbin/haproxy-systemd-wrapper -f...IONS
Jul 22 16:29:40 stlb01 systemd[1]: Forked /usr/sbin/haproxy-systemd-wrapper as 103
Jul 22 16:29:40 stlb01 systemd[1]: haproxy.service changed failed -> running
Jul 22 16:29:40 stlb01 systemd[1]: Job haproxy.service/start finished, result=done
Jul 22 16:29:40 stlb01 systemd[1]: Started HAProxy Load Balancer.
Jul 22 16:29:40 stlb01 systemd[103]: Executing: /usr/sbin/haproxy-systemd-wrapper -f /etc/...pid
Jul 22 16:29:40 stlb01 haproxy-systemd-wrapper[103]: haproxy-systemd-wrapper: executing /us...Ds
Hint: Some lines were ellipsized, use -l to show in full.
[loki@stlb01 ~]$
[loki@stlb01 ~]$ curl 172.16.238.10:8080
curl: (7) Failed connect to 172.16.238.10:8080; Connection refused
[loki@stlb01 ~]$
[loki@stlb01 ~]$ ss nltp
Error: an inet prefix is expected rather than "nltp".
Cannot parse dst/src address.
[loki@stlb01 ~]$
[loki@stlb01 ~]$ ss -nltp
State      Recv-Q Send-Q   Local Address:Port                  Peer Address:Port
LISTEN     0      128                  *:22                               *:*
LISTEN     0      128         127.0.0.11:34487                            *:*
LISTEN     0      128                  *:5000                             *:*
LISTEN     0      128               [::]:22                            [::]:*
[loki@stlb01 ~]$
[loki@stlb01 ~]$ haproxy -c -f /etc/haproxy/haproxy.cfg
Configuration file is valid
[loki@stlb01 ~]$
[loki@stlb01 ~]$ Connection to host01 closed by remote host.
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


