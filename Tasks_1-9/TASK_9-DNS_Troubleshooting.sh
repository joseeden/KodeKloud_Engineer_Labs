
TASK 9 - DNS Troubleshooting - 2020-07-07 || 03:20 AM


REQUIREMENT:

The system admins team of xFusionCorp Industries has noticed intermittent issues with DNS resolution in several apps . App Server 3 in Stratos Datacenter is having some DNS resolution issues, so we want to add some additional DNS nameservers on this server.

As a temporary fix we have decided to go with Google public DNS. Please make appropriate changes on this server.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://community.kodekloud.com/t/taks-dns-troubleshooting/1485
https://community.kodekloud.com/t/dns-troubleshooting/2955
https://support.rackspace.com/how-to/changing-dns-settings-on-linux/

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

	1.	Connect via SSH to the correct app server.
	2.	Verify if DNS is really not working by doing a ping test.
	3.	Edit /etc/resolv.conf and add nameserver for Google
	4.	Test connectivity

-----------------------------------------------------------------------------------------------------------------

III.	STEPS - BREAKDOWN

#	This was actually quite an easy one. Wish I could have started this earlier.
# 	I was a bit disoriented or I guess distracted the whole day that I only started working on this lab
#	8 hours after it was assigned to me, adnd I only worked on this lab for 15 mins or less!
#	Anyway, this lab just requires to add a DNS name server to the App server.


#	1.	Connect via SSH to the correct app server
thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
Warning: Permanently added '172.16.238.10' (ECDSA) to the list of known hosts.
[tony@stapp01 ~]$

#	2.	Verify if DNS is really not working by doing a ping test.
[tony@stapp01 ~]$ ping www.google.com
PING www.google.com (216.58.206.4) 56(84) bytes of data.									# Well this seems to
64 bytes from fra16s20-in-f4.1e100.net (216.58.206.4): icmp_seq=1 ttl=118 time=5.08 ms		# be working...
64 bytes from fra16s20-in-f4.1e100.net (216.58.206.4): icmp_seq=2 ttl=118 time=5.42 ms
64 bytes from fra16s20-in-f4.1e100.net (216.58.206.4): icmp_seq=3 ttl=118 time=5.17 ms
64 bytes from fra16s20-in-f4.1e100.net (216.58.206.4): icmp_seq=4 ttl=118 time=5.12 ms
64 bytes from fra16s20-in-f4.1e100.net (216.58.206.4): icmp_seq=5 ttl=118 time=5.11 ms
64 bytes from fra16s20-in-f4.1e100.net (216.58.206.4): icmp_seq=6 ttl=118 time=5.16 ms
^C
--- www.google.com ping statistics ---
6 packets transmitted, 6 received, 0% packet loss, time 5008msrtt min/avg/max/mdev = 5.087/5.180/5.421/0.145 ms
[tony@stapp01 ~]$
[tony@stapp01 ~]$

#	3.	Edit /etc/resolv.conf and add nameserver for Google
[tony@stapp01 ~]$ sudo ls -l /etc/resolv.conf

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for tony:
-rw-r--r-- 1 root root 69 Jul  6 19:00 /etc/resolv.conf
[tony@stapp01 ~]$																			# So apparently 'nano'
[tony@stapp01 ~]$ sudo nano /etc/resolv.conf												# isn't really supported
sudo: nano: command not found																# in KodeKloud labs.
[tony@stapp01 ~]$																			
[tony@stapp01 ~]$ sudo vi /etc/resolv.conf													# Add nameserver
[tony@stapp01 ~]$
[tony@stapp01 ~]$ sudo cat /etc/resolv.conf
search stratos.xfusioncorp.com
nameserver 127.0.0.11
nameserver 8.8.8.8											#	added nameserver 8.8.8.8
nameserver 8.8.4.4											#	added nameserver 8.8.4.4
options ndots:0
[tony@stapp01 ~]$

#	4.	Test connectivity
[tony@stapp01 ~]$ ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=118 time=5.75 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=118 time=5.08 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=118 time=5.10 ms
^C
--- 8.8.8.8 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2002ms
rtt min/avg/max/mdev = 5.080/5.311/5.754/0.318 ms
[tony@stapp01 ~]$
[tony@stapp01 ~]$ ping 8.8.4.4
PING 8.8.4.4 (8.8.4.4) 56(84) bytes of data.
64 bytes from 8.8.4.4: icmp_seq=1 ttl=118 time=5.30 ms
64 bytes from 8.8.4.4: icmp_seq=2 ttl=118 time=5.64 ms
64 bytes from 8.8.4.4: icmp_seq=3 ttl=118 time=5.71 ms
64 bytes from 8.8.4.4: icmp_seq=4 ttl=118 time=5.36 ms
^C
--- 8.8.4.4 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3004ms
rtt min/avg/max/mdev = 5.302/5.507/5.715/0.175 ms
[tony@stapp01 ~]$

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

