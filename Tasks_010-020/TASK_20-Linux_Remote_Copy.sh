
-----------------------------------------------------------------------------------------------------------------

Start		2020-07-21 || 06:47 PM
Finished	2020-07-21 || 07:10 PM

-----------------------------------------------------------------------------------------------------------------

TASK 20 - Linux Remote Copy

REQUIREMENTS:

One of the Nautilus developers has copied confidential data on the jump host in Stratos DC. That data must be copied to one of the app servers. Because developers do not have access to app servers, they asked the system admins team to accomplish the task for them.

Copy /tmp/nautilus.txt.gpg file from jump server to App Server 3 at location /home/code.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

#	FOR THIS LAB, I did not used any artiles from the net or from KKC since I've done a lab that is quite 
#	similar with this. I used the TASK 7 - Linux Banner.sh file as my reference for this lab.

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

	1.	Check the file in the directory in the specified directory in the jump server.
	2.	Copy the file from the jump server to any directory in the App Server 3 - using scp
	3.	Connect via SSH to the app server and move the file from the initial directory to the 
		required directory.
	4.	Verify.

-----------------------------------------------------------------------------------------------------------------

III.	COMMANDS USED

#	1.	Check the file in the directory in the specified directory in the jump server.
#		I guess this isn't part of the required tasks but it's just bst practice or I guess a force of habit to
#		check first.
ls -l /tmp
sudo cat /tmp/nautilus.txt.gpg

#	2.	Copy the file from the jump server to any directory in the App Server 3 - using scp
#		Similar with Task 7, the jump server-user doesn't have permissions to copy files to the /home directory
#		of the App Server. So what I did is first copy the file in a temporary directory in the App server.
#		This ensures that the App server has the file
sudo scp -r /tmp/nautilus.txt.gpg banner@172.16.238.12:/tmp

#	3.	Connect via SSH to the app server and move the file from the initial directory to the 
#		required directory.
#		Go in to the specified App server and then move the filr from the temporary directory to the 
#		specified one. 
sshpass -p  '******' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
sudo mv /tmp/nautilus.txt.gpg /home/code

#	4.	Verify.
#		And then as always, verify if the required task is fulfilled and everything is where they should be.
ls -l /home/code/
sudo cat /tmp/nautilus.txt.gpg

-----------------------------------------------------------------------------------------------------------------

IV.	STEPS - BREAKDOWN

#	This was actually one fo the faster labs since I've done Task 7 before which has the same tasks as with this lab.
#	I guess the documentation took much more time that the actual lab itself.
#	I also just had on attempt ont his lab since I was aprtially confident of the steps to take.

thor@jump_host /$thor@jump_host /$ ls -l /tmp
total 8
-rw-r--r--  1 thor thor   0 Jul 21 10:48 demofile2.json
-rwx------ 46 root root 836 Aug  1  2019 ks-script-rnBCJB
-rw-r--r--  1 thor thor  74 Jul 21 10:48 nautilus.txt.gpg
-rw------- 46 root root   0 Aug  1  2019 yum.log
thor@jump_host /$
thor@jump_host /$ sudo cat /tmp/nautilus.txt.gpg

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.    #3) With great power comes great responsibility.

[sudo] password for thor:
0���Чu���9�n�&M's�al�]�pqW�_thor@jump_host /$
thor@jump_host /$
thor@jump_host /$ sudo scp -r /tmp/nautilus.txt.gpg banner@172.16.238.12:/home/code
The authenticity of host '172.16.238.12 (172.16.238.12)' can't be established.
ECDSA key fingerprint is SHA256:SySamszyWhhLGFiybhGBqfrr8g55wS/3e37ZpBOvICs.
ECDSA key fingerprint is MD5:6d:31:18:2a:f9:07:f3:29:dd:0a:d3:1f:6e:04:0a:db.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '172.16.238.12' (ECDSA) to the list of known hosts.
banner@172.16.238.12's password:
Permission denied, please try again.
banner@172.16.238.12's password:
Permission denied, please try again.
banner@172.16.238.12's password:
scp: /home/code/nautilus.txt.gpg: Permission denied
thor@jump_host /$
thor@jump_host /$ sudo scp -r /tmp/nautilus.txt.gpg banner@172.16.238.12:/home
banner@172.16.238.12's password:
scp: /home/nautilus.txt.gpg: Permission denied
thor@jump_host /$
thor@jump_host /$ sudo scp -r /tmp/nautilus.txt.gpg banner@172.16.238.12:/tmp
banner@172.16.238.12 password:
nautilus.txt.gpg                                              100%   74   115.2KB/s   00:00
thor@jump_host /$
thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
Warning: Permanently added '172.16.238.12' (ECDSA) to the list of known hosts.
[banner@stapp03 ~]$
[banner@stapp03 ~]$ sudo mv /tmp/nautilus.txt.gpg /home/code/

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for banner:
[banner@stapp03 ~]$
[banner@stapp03 ~]$ cd /home/code/
[banner@stapp03 code]$ cd ..
[banner@stapp03 home]$ cd ..
[banner@stapp03 /]$
[banner@stapp03 /]$ cd  ~
[banner@stapp03 ~]$
[banner@stapp03 ~]$ ls -l /home/code/
total 4
-rw-r--r-- 1 banner banner 74 Jul 21 10:54 nautilus.txt.gpg
[banner@stapp03 ~]$
[banner@stapp03 ~]$ Connection to host01 closed by remote host.
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


