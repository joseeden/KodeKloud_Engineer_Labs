
-----------------------------------------------------------------------------------------------------------------

Start		  2020-07-19 || 06:46 PM
Finished	2020-07-19 || 07:32 PM

-----------------------------------------------------------------------------------------------------------------

TASK 19 - Linux Firewalld Rules

REQUIREMENT:

The Nautilus system admins team recently deployed a web UI application for their backup utility running on the Nautilus backup server in Stratos Datacenter. The application is running on port 5001. They have firewalld installed on that server. The requirements that have come up include the following:

Open all incoming connection on 5001/tcp port. Zone should be public.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://community.kodekloud.com/t/task-1-linux-firewalld-rules/1716/8
https://community.kodekloud.com/t/linux-firewalld-setup-failed-again/4533

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

	1.	Connect via SSH to the Backup server.
	2.	Check status of firewalld and the available options.
	3.	Add <port id>/protocol and reload.
	4.  Verify.

-----------------------------------------------------------------------------------------------------------------

III.	COMMANDS USED

#	1.	Connect via SSH to the Backup server

      sshpass -p '******' ssh -o StrictHostKeyChecking=no  clint@172.16.238.16

# 	2.	Check status of firewalld and the available options
#		Now for this one, since I try to check first the available options in the man pages before checking out
#		KKC articles for the correct steps, I used --help.
#		Then I checked the KKC where I saw multiple articles.

      firewall-cmd --help
      sudo firewall-cmd --zone=public --list-all							#	lists config for firewall

#	3.	Add <port id>/protocol and reload

      sudo firewall-cmd --zone=public --permanent --add-port=3000/tcp
      firewall-cmd --help | grep reload									#	tried to searchn correct option on how \
      sudo firewall-cmd --reload											#	to reload
                                        
#	4.  Verify.

      sudo firewall-cmd --zone=public --list-all

      #		An additional way to verify is to check the httpd.conf file. This will show the port
      cat /etc/httpd/conf/httpd.conf | grep Listen

-----------------------------------------------------------------------------------------------------------------

IV.	STEPS - BREAKDOWN

thor@jump_host /$thor@jump_host /$ sshpass -p '******' ssh -o StrictHostKeyChecking=no  clint@172.16.238.16
Warning: Permanently added '172.16.238.16' (ECDSA) to the list of known hosts.[clint@stbkp01 ~]$
[clint@stbkp01 ~]$ firewall-cmd --help

Usage: firewall-cmd [OPTIONS...]									#	Output for the man pages for firewall-cmd \
																	#	is reduced to shorten documentation.
General Options
  -h, --help           Prints a short help text and exists
  -V, --version        Print the version string of firewalld
  -q, --quiet          Do not print status messages

[clint@stbkp01 ~]$
[clint@stbkp01 ~]$ sudo firewall-cmd --zone=public --list-all

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for clint:
public
  target: default
  icmp-block-inversion: no
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

[clint@stbkp01 ~]$
[clint@stbkp01 ~]$ sudo firewall-cmd --zone=public --permanent --add-port=3000/tcp
success
[clint@stbkp01 ~]$ firewall-cmd --help | grep reload
  --reload             Reload firewall and keep state information
  --complete-reload    Reload firewall and lose state information
[clint@stbkp01 ~]$
[clint@stbkp01 ~]$ sudo firewall-cmd --reload
success
[clint@stbkp01 ~]$ sudo firewall-cmd --zone=public --list-all
public
  target: default
  icmp-block-inversion: no
  interfaces:
  sources:
  services: dhcpv6-client ssh
  ports: 3000/tcp
  protocols:
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:

[clint@stbkp01 ~]$ cat /etc/httpd/conf/httpd.conf | grep Listen
# Listen: Allows you to bind Apache to specific IP addresses and/or
# Change this to Listen on specific IP addresses as shown below to
#Listen 12.34.56.78:80
Listen 3000
[clint@stbkp01 ~]$
[clint@stbkp01 ~]$ Connection to host01 closed by remote host.
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


