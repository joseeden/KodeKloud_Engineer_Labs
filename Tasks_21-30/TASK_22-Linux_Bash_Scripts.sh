
-----------------------------------------------------------------------------------------------------------------

Start		2020-07-24 || 02:19 AM	
Finished	2020-07-24 || 12:01 PM

-----------------------------------------------------------------------------------------------------------------

TASK 22 - Linux Bash Scripts

REQUIREMENTS:

The production support team of xFusionCorp Industries is working on developing some bash scripts to automate different day to day tasks. One is to create a bash script for taking websites backup. They have a static website running on App Server 3 in Stratos Datacenter, and they need to create a bash script named ecommerce_backup.sh which should accomplish the following tasks. (Also remember to place the script under /scripts directory on App Server 2

a. 	Create a zip archive named xfusioncorp_blog.zip of /var/www/html/blog directory.
b. 	Save the archive in /backup/ on App Server 3. This is a temporary storage, as backups from this location will be clean on 	 weekly basis. Therefore, we also need to save this backup archive on Nautilus Backup Server.
c. 	Copy the created archive to Nautilus Backup Server server in /backup/ location.
d. 	Please make sure script will not ask for password while copying the archive file. Additionally, the respective server user 	  (for example, steve in case of App Server 2) must be able to run it.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://community.kodekloud.com/t/linux-bash-scripts/2980/20
https://www.tecmint.com/ssh-passwordless-login-using-ssh-keygen-in-5-easy-steps/	#Passwordless SSH authentication
https://stackoverflow.com/questions/50096/how-to-pass-password-to-scp
https://community.kodekloud.com/t/task-linux-bash-scripts/6688
https://community.kodekloud.com/t/linux-bash-scripts-task-fail/5737

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

#	This seemed like a 2-part lab. 
#	PART 1 - Setup a password-less SSH connection between the App Server and the Backup Server.

	1.	Connect via SSH to the App Server.
	2.	Create Authentication SSH-Keygen Keys on App Server.
	3.	Create .ssh Directory on Backup server.
	4.	Upload Generated Public Keys to Backup server.
	5.	Set Permissions on Backup server.
	6. 	Test passwordless SSH authentication. Login from App server to Backup server.
	
#	PART 2 - Create the script and then test it.

	1.	Create the script according to the lab requirements.
	2.	Run the script and check if the zip file was created in the /backup directory of both
		App Server and the Backup Server.
	
-----------------------------------------------------------------------------------------------------------------

III.	COMMANDS USED

#	This seemed like a 2-part lab. 
#	PART 1 - Setup a password-less SSH connection between the App Server and the Backup Server.

	1.	Connect via SSH to the App Server.
		
			sshpass -p  '******' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
		
	2.	Create Authentication SSH-Keygen Keys on App Server.
	
			# Note that there's no need to enter key name after issuing the command. 
			# Just hit 'Enter' three times.
			ssh-keygen -t rsa 
			
	3.	Create .ssh Directory on Backup server.
	
			ssh clint@172.16.238.16 mkdir -p .ssh
			# Enter password: ******
			
	4.	Upload Generated Public Keys to Backup server.
	
			cat .ssh/id_rsa.pub | ssh clint@stbkp01 'cat >> .ssh/authorized_keys'
			# Enter password: ******
			
	5.	Set Permissions on Backup server.
	
			ssh clint@stbkp01 "chmod 700 .ssh; chmod 640 .ssh/authorized_keys"
			# Enter password: ******
		
	6. 	Test passwordless SSH authentication. Login from App server to Backup server.
	
			# if everything's go well, you should be able to login to Backup server from
			# the App server without being prompted to enter backup server's password.
			ssh clint@stbkp01
			
	
#	PART 2 - Create the script and then test it.

	1.	Create the script according to the lab requirements.
	
			vi /scripts/blog_backup.sh
			# the script should contain the following. 
			# Note that '#!/bin/bash' is included in the script:
			
				#!/bin/bash
				zip -r xfusioncorp_blog.zip /var/www/html/blog 
				mv xfusioncorp_blog.zip /backup/
				scp -r /backup/xfusioncorp_blog.zip clint@172.16.238.16:/backup
				
	2.	Run the script and check if the zip file was created in the /backup directory of both
		App Server and the Backup Server.
			
			# From App server, run the script. An output 'Adding...' will appear.
			sh /scripts/blog_backup.sh
			
			# Check /backup directory of both App Server and Backup Server.
			ls -l /backup/
			ssh clint@stbkp01
			ls -l /backup/

-----------------------------------------------------------------------------------------------------------------

IV.	STEPS - BREAKDOWN

#	Dang. This one was a tough one. Felt like this was a 2-part lab. 
#	During the first night that I was doign this, I was able to come up with the script and test it.
#	The only part that I was ahaving a hard time was running the script without being promptd to enter
#	the password for the Backup Server.
#	So after some reading in the KKC and the internet, my first attempt was to pass the password
#	through SCP -- this did not quite work. I also found a lot of articles in the KKC about this lab.
#	Deciding I was beat up for the night, I went to sleep.

#	The following day, I had a much clearer mind. So going back to the KKC, I found that I may have been
#	looking at the problem in an incorretct lens. Instead of passing the password, I just have to enable
#	passwordless SSH authentication between the App server and the Backup server.
#	Now this have been a requirement for a previous task -- which I have faile dby the way.
#	So now it turns out this lab actually consist of two labs - 
#	Passwordless SSH athentication and Creating the script.
#	This seems to be heavily supported by the steps suggested in most of the KKC posts.

#	So I went ahead and follow some of the steps. I still had a difficult time in this first part.
#	But once I have enabled passwordless SSH authentication between the two servers, I knew the hard 
#	part is over.

#	So as always, I worked and tested each part.
#	I estimate that I hadaround 5 or 6 attempts on this lab.

thor@jump_host /$thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
Warning: Permanently added '172.16.238.11' (ECDSA) to the list of known hosts.[steve@stapp02 ~]$
[steve@stapp02 ~]$ ssh-keygen -t rsa
Generating public/private rsa key pair.
Enter file in which to save the key (/home/steve/.ssh/id_rsa):
Created directory '/home/steve/.ssh'.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/steve/.ssh/id_rsa.
Your public key has been saved in /home/steve/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:yK14UwrJtvR8aOGjyt0Ay7LrGBbfe6dV+RQ+GVmdrns steve@stapp02
The key's randomart image is:+---[RSA 2048]----+
|               .o|
|              o..|
|             +.  |
|   . o o    o +. |
| .. * + S  o =.  |
| .o=.B *  . o..  |
|o.o.+.% ..   ..  |
|o= . *.=..   . E |
|=oo.o.o.o     .  |
+----[SHA256]-----+
[steve@stapp02 ~]$
[steve@stapp02 ~]$ ssh clint@172.16.238.16 mkdir -p .ssh
The authenticity of host '172.16.238.16 (172.16.238.16)' can't be established.
ECDSA key fingerprint is SHA256:x1et+mPor1MJMXmYGQmwCia/J4rETcOs1XFA1qznH0I.
ECDSA key fingerprint is MD5:3d:48:1b:14:f0:6c:ca:91:10:2d:92:e6:5d:f2:ee:15.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '172.16.238.16' (ECDSA) to the list of known hosts.
clint@172.16.238.16's password:
[steve@stapp02 ~]$
[steve@stapp02 ~]$ cat .ssh/id_rsa.pub | ssh clint@stbkp01 'cat >> .ssh/authorized_keys'
The authenticity of host 'stbkp01 (172.16.238.16)' can't be established.
ECDSA key fingerprint is SHA256:x1et+mPor1MJMXmYGQmwCia/J4rETcOs1XFA1qznH0I.
ECDSA key fingerprint is MD5:3d:48:1b:14:f0:6c:ca:91:10:2d:92:e6:5d:f2:ee:15.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'stbkp01' (ECDSA) to the list of known hosts.
clint@stbkp01's password:
[steve@stapp02 ~]$
[steve@stapp02 ~]$ ssh clint@stbkp01 "chmod 700 .ssh; chmod 640 .ssh/authorized_keys"
clint@stbkp01's password:
[steve@stapp02 ~]$
[steve@stapp02 ~]$ ssh clint@stbkp01
[clint@stbkp01 ~]$ exit
logout
Connection to stbkp01 closed.
[steve@stapp02 ~]$
[steve@stapp02 ~]$
[steve@stapp02 ~]$ vi /scripts/blog_backup.sh
[steve@stapp02 ~]$
[steve@stapp02 ~]$ sh /scripts/blog_backup.sh
  adding: var/www/html/blog/ (stored 0%)
  adding: var/www/html/blog/.gitkeep (stored 0%)
  adding: var/www/html/blog/index.html (stored 0%)
xfusioncorp_blog.zip                                          100%  588     1.0MB/s   00:00
[steve@stapp02 ~]$
[steve@stapp02 ~]$ ls -l /backup/
total 4
-rw-rw-r-- 1 steve steve 588 Jul 24 03:28 xfusioncorp_blog.zip
[steve@stapp02 ~]$
[steve@stapp02 ~]$ ssh clint@stbkp01
Last login: Fri Jul 24 03:26:19 2020 from stapp02
ls -l /backup/[clint@stbkp01 ~]$ ls -l /backup/
total 4
-rw-rw-r-- 1 clint clint 588 Jul 24 03:28 xfusioncorp_blog.zip
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
