
-----------------------------------------------------------------------------------------------------------------

Start			2020-09-11 || 03:31 PM
Finished		2020-09-11 || 04:52 PM

-----------------------------------------------------------------------------------------------------------------

TASK 38 - Install And Configure SFTP

REQUIREMENTS:

Some of the developers from Nautilus project team have asked for SFTP access to at least one of the app server in Stratos DC. After going through the requirements, the system admins team has decided to configure the SFTP server on App Server 3 server in Stratos Datacenter. Please configure it as per the following instructions:


a. Create an SFTP user yousuf and set its password to 8FmzjvFU6S.

b. Password authentication should be enabled for this user.

c. Set its ChrootDirectory to /var/www/webdata.

d. SFTP user should only be allowed to make SFTP connections.


-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://www.techrepublic.com/article/how-to-set-up-an-sftp-server-on-linux/
https://community.kodekloud.com/t/install-and-configure-sftp-failed/6297/4
https://community.kodekloud.com/t/task-is-showing-failed-install-configure-sftp/6993
https://community.kodekloud.com/t/install-and-configure-sftp-tasks/2851/7

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

#	1.	SSH into the jump server and App server 1 and switch 
#		to root.
#	2.	Add the user and password. Make sure thayou specify the /sbin/nologin.
#		This makes sure that only SFTP connections are allowed.
#	3.	Create the root directory and change it's permissions. This should match the root directory 
#		required for the lab and the root directory that will be specified in the sshd_config later.
#	4.	Edit the sshd_config file. Add the necessary attributes at the bottom.
#		This includes the 'PasswordAuthentication' set to yes. Restart and verify status aferwards.
#	5.	Open a new terminal - which will log you into the jump server again.
#		Try to establish sftp and ssh into the App Server 1. Only sftp should work.

-----------------------------------------------------------------------------------------------------------------

III.	COMMANDS USED

#	1.	SSH into the jump server, Storage Server, App server 1, App server 2, and App server 3 and switch 
#		to root.

			sudo su -
			******	

			sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
			sudo su -
			******
			
#	2.	Add the user and password. Make sure that you specify the /sbin/nologin flag.
#		This makes sure that only SFTP connections are allowed.

			useradd -d /var/www/webdata -s /sbin/nologin yousuf   
			passwd yousuf  
			8FmzjvFU6S

#	3.	Create the root directory and change it's permissions. This should match the root directory 
#		required for the lab and the root directory that will be specified in the sshd_config later.

			mkdir -p /var/www/webdata
			chown root:root /var/www/webdata
			chmod 755 /var/www/webdata

#	4.	Edit the sshd_config file. Add the necessary attributes at the bottom.
#		This includes the 'PasswordAuthentication' set to yes. Restart and verify status aferwards.

			vi /etc/ssh/sshd_config
			
				Match User yousuf  
					ForceCommand internal-sftp
					PasswordAuthentication yes
					ChrootDirectory /var/www/webdata
					PermitTunnel no
					AllowAgentForwarding no
					AllowTcpForwarding no
					X11Forwarding no
					Subsystem sftp internal-sftp

			systemctl restart sshd
			systemctl status sshd
			
#	5.	Open a new terminal - which will log you into the jump server again.
#		Try to establish sftp and ssh into the App Server 1. Only sftp should work.

			sftp yousuf@172.16.238.10

			ssh yousuf@172.16.238.10
			
			# SFTP should be accepted while ssh is blocked.

				thor@jump_host /$ sftp yousuf@172.16.238.10
				yousuf@172.16.238.10 password:
				Connected to 172.16.238.10.
				sftp>
				sftp>

				thor@jump_host /$ ssh yousuf@172.16.238.10
				yousuf@172.16.238.10 password:
				This service allows sftp connections only.
				Connection to 172.16.238.10 closed.
				thor@jump_host /$
				thor@jump_host /$

-----------------------------------------------------------------------------------------------------------------

IV.	STEPS - BREAKDOWN

#	This is another one which is just right-on manageable.
#	Of course I still looked up and read some articles in the KKC Community.

#	Attached as a supportfile is the scrapes for APP Server 1.


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


