
-----------------------------------------------------------------------------------------------------------------

Start		2020-07-15 || 12:03 AM
Finished	2020-07-15 || 12:53 AM

-----------------------------------------------------------------------------------------------------------------

TASK 15 - Disable Root Login

REQUIREMENT:

After doing some security audits of servers, xFusionCorp Industries security team has implemented some new security policies. One of them is to disable direct root login through SSH.

Disable direct SSH root login on all app servers in Stratos Datacenter.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://community.kodekloud.com/t/disable-root-login-task-failed/1534
https://community.kodekloud.com/t/disable-ssh-root-login-on-the-3-app-server/1307/2
https://community.kodekloud.com/t/task-7-disable-root-login/1416/2
https://community.kodekloud.com/t/disable-root-login-task-failed/8436

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

	1.	Connect via SSH to each App Server - there are 3.
	2.	Edit the /etc/ssh/sshd_config - note that the file to be edited is sshd_config, not ssh_config
	3.	On the sshd_config, change "PermitRootLogin yes" to "PermitRootLogin no".
	4.	Make sure to UNCOMMENT "PermitRootLogin no".
	5.	Restart sshd.
	
-----------------------------------------------------------------------------------------------------------------

III.	COMMANDS USED

sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sshpass -p  '******' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
sshpass -p  '******' ssh -o StrictHostKeyChecking=no banner@172.16.238.12

sudo vi /etc/ssh/sshd_config

#	change yes to no
PermitRootLogin no

sudo cat /etc/ssh/sshd_config | grep PermitRoot
sudo systemctl enable sshd
sudo systemctl start sshd
sudo systemctl restart sshd
sudo systemctl status sshd

exit

-----------------------------------------------------------------------------------------------------------------

IV.	STEPS - BREAKDOWN

#	This is one of the easiest again but I still spent time reading in the KKC about this task.
#	This alb just requires disabling direct ssh login by the root user - which I discover can be
#	achieved by simply editing the sshd_config file.
#	After editing the option, make sure to UNCOMMENT IT, otherwise option will not take effect.
#	Lastly, restart the ssh service. I went extra road by enabling, starting, then restarting the service.
#	Just to be sure.

#	I was also searching on how to make sure that the SSHD is indeed restarted - one post in KKC says
#	that sshd didn't restart even after doing it. Might be an incorrect command, I don't know.
#	Next to this, i also checked the net on how to ensure ssh root login access is disabled.
#	Lots of article appeared but none seem to relevatn to what I'm looking for.

#	In the end, I did not spend too much time on looking for way to verify and just restarted the lab,
#	Pasted in my "templated commands" and then hit finish.
#	Luckily, thhere were no errors and lab succeeded.

thor@jump_host /$thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
Warning: Permanently added '172.16.238.10' (ECDSA) to the list of known hosts.
[tony@stapp01 ~]$
[tony@stapp01 ~]$ sudo vi /etc/ssh/sshd_config

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for tony:
[tony@stapp01 ~]$[tony@stapp01 ~]$ sudo cat /etc/ssh/sshd_config | grep PermitRoot
PermitRootLogin no
# the setting of "PermitRootLogin without-password".
[tony@stapp01 ~]$
[tony@stapp01 ~]$ sudo systemctl enable sshd
[tony@stapp01 ~]$ sudo systemctl start sshd
[tony@stapp01 ~]$ sudo systemctl restart sshd
[tony@stapp01 ~]$ sudo systemctl status sshd
● sshd.service - OpenSSH server daemon
   Loaded: loaded (/usr/lib/systemd/system/sshd.service; enabled; vendor preset: enabled)
   Active: active (running) since Tue 2020-07-14 16:37:15 UTC; 1s ago
     Docs: man:sshd(8)
           man:sshd_config(5)
 Main PID: 128 (sshd)
   CGroup: /docker/aea129fa058b04ad18a5e288cba09e681bc39b2cd87a9aadd9cefcc503fda89b/system.slice/sshd.service
           ├─ 80 sshd: tony [priv]
           ├─ 82 sshd: tony@pts/0
           ├─ 83 -bash
           └─128 /usr/sbin/sshd -D

Jul 14 16:37:15 stapp01 systemd[1]: sshd.service changed dead -> start
Jul 14 16:37:15 stapp01 systemd[1]: Starting OpenSSH server daemon...
Jul 14 16:37:15 stapp01 systemd[128]: Executing: /usr/sbin/sshd -D
Jul 14 16:37:15 stapp01 systemd[1]: Got notification message for unit sshd.service
Jul 14 16:37:15 stapp01 systemd[1]: sshd.service: Got notification message from PID 128 (R...=1)
Jul 14 16:37:15 stapp01 systemd[1]: sshd.service: got READY=1
Jul 14 16:37:15 stapp01 systemd[1]: sshd.service changed start -> running
Jul 14 16:37:15 stapp01 systemd[1]: Job sshd.service/start finished, result=done
Jul 14 16:37:15 stapp01 systemd[1]: Started OpenSSH server daemon.
Jul 14 16:37:17 stapp01 sudo[129]:     tony : TTY=pts/0 ; PWD=/home/tony ; USER=root ; CO...sshd
Hint: Some lines were ellipsized, use -l to show in full.
[tony@stapp01 ~]$
[tony@stapp01 ~]$ exit
logout
Connection to 172.16.238.10 closed.


thor@jump_host /$
thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
Warning: Permanently added '172.16.238.11' (ECDSA) to the list of known hosts.
[steve@stapp02 ~]$
[steve@stapp02 ~]$ sudo vi /etc/ssh/sshd_config

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for steve:
[steve@stapp02 ~]$
[steve@stapp02 ~]$ sudo cat /etc/ssh/sshd_config | grep PermitRoot
PermitRootLogin no
# the setting of "PermitRootLogin without-password".
[steve@stapp02 ~]$
[steve@stapp02 ~]$ sudo systemctl enable sshd
[steve@stapp02 ~]$ sudo systemctl start sshd
[steve@stapp02 ~]$ sudo systemctl restart sshd
[steve@stapp02 ~]$ sudo systemctl status sshd
● sshd.service - OpenSSH server daemon
   Loaded: loaded (/usr/lib/systemd/system/sshd.service; enabled; vendor preset: enabled)
   Active: active (running) since Tue 2020-07-14 16:38:43 UTC; 661ms ago
     Docs: man:sshd(8)
           man:sshd_config(5)
 Main PID: 128 (sshd)
   CGroup: /docker/bd38bf953f5d604b7311dbda0b255d059f7bee2d3b351173367bf3d108b66d44/system.slice/sshd.service
           ├─ 80 sshd: steve [priv]
           ├─ 82 sshd: steve@pts/0
           ├─ 83 -bash
           └─128 /usr/sbin/sshd -D

Jul 14 16:38:43 stapp02 systemd[1]: sshd.service changed dead -> start
Jul 14 16:38:43 stapp02 systemd[1]: Starting OpenSSH server daemon...
Jul 14 16:38:43 stapp02 systemd[128]: Executing: /usr/sbin/sshd -D
Jul 14 16:38:43 stapp02 systemd[1]: Got notification message for unit sshd.service
Jul 14 16:38:43 stapp02 systemd[1]: sshd.service: Got notification message from PID 128 (R...=1)
Jul 14 16:38:43 stapp02 systemd[1]: sshd.service: got READY=1
Jul 14 16:38:43 stapp02 systemd[1]: sshd.service changed start -> running
Jul 14 16:38:43 stapp02 systemd[1]: Job sshd.service/start finished, result=done
Jul 14 16:38:43 stapp02 systemd[1]: Started OpenSSH server daemon.
Jul 14 16:38:44 stapp02 sudo[129]:    steve : TTY=pts/0 ; PWD=/home/steve ; USER=root ; C...sshd
Hint: Some lines were ellipsized, use -l to show in full.
[steve@stapp02 ~]$
[steve@stapp02 ~]$ exit
logout
Connection to 172.16.238.11 closed.


thor@jump_host /$
thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
Warning: Permanently added '172.16.238.12' (ECDSA) to the list of known hosts.
[banner@stapp03 ~]$
[banner@stapp03 ~]$ sudo vi /etc/ssh/sshd_config

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for banner:
[banner@stapp03 ~]$
[banner@stapp03 ~]$ sudo cat /etc/ssh/sshd_config | grep PermitRoot
PermitRootLogin no
# the setting of "PermitRootLogin without-password".
[banner@stapp03 ~]$
[banner@stapp03 ~]$ sudo systemctl enable sshd
[banner@stapp03 ~]$ sudo systemctl start sshd
[banner@stapp03 ~]$ sudo systemctl restart sshd
[banner@stapp03 ~]$ sudo systemctl status sshd
● sshd.service - OpenSSH server daemon
   Loaded: loaded (/usr/lib/systemd/system/sshd.service; enabled; vendor preset: enabled)
   Active: active (running) since Tue 2020-07-14 16:40:05 UTC; 1s ago
     Docs: man:sshd(8)
           man:sshd_config(5)
 Main PID: 131 (sshd)
   CGroup: /docker/41876d8036e26d40e1db4a18f8ba739bf69cf897360420c002e705a9f77e7bcf/system.slice/sshd.service
           ├─ 83 sshd: banner [priv]
           ├─ 85 sshd: banner@pts/0
           ├─ 86 -bash
           └─131 /usr/sbin/sshd -D

Jul 14 16:40:05 stapp03 systemd[1]: sshd.service changed dead -> start
Jul 14 16:40:05 stapp03 systemd[1]: Starting OpenSSH server daemon...
Jul 14 16:40:05 stapp03 systemd[131]: Executing: /usr/sbin/sshd -D
Jul 14 16:40:05 stapp03 systemd[1]: Got notification message for unit sshd.service
Jul 14 16:40:05 stapp03 systemd[1]: sshd.service: Got notification message from PID 131 (R...=1)
Jul 14 16:40:05 stapp03 systemd[1]: sshd.service: got READY=1
Jul 14 16:40:05 stapp03 systemd[1]: sshd.service changed start -> running
Jul 14 16:40:05 stapp03 systemd[1]: Job sshd.service/start finished, result=done
Jul 14 16:40:05 stapp03 systemd[1]: Started OpenSSH server daemon.
Jul 14 16:40:07 stapp03 sudo[132]:   banner : TTY=pts/0 ; PWD=/home/banner ; USER=root ; ...sshd
Hint: Some lines were ellipsized, use -l to show in full.
[banner@stapp03 ~]$
[banner@stapp03 ~]$ exit
logout
Connection to 172.16.238.12 closed.
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



