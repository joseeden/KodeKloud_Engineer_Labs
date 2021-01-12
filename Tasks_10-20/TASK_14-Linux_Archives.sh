
-----------------------------------------------------------------------------------------------------------------

Start		2020-07-13 || 04:25 PM	
Finished	2020-07-13 || 04:56 PM

-----------------------------------------------------------------------------------------------------------------

TASK 14 - Linux Archives

REQUIREMENT:

On Nautilus storage server in Stratos DC there is a storage location /data which is used by different developers to keep their data (no confidential data). One of the developers javed has raised a ticket and asked for a copy of his/her data present in /data/javed directory on storage server. /home is an FTP location on storage server where developers can download their data. Below are the instructions shared by the system admin team to accomplish the task:

a. Make a javed.tar.gz compressed archive of /data/javed directory and move the archive to /home directory on Storage Server.



-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://community.kodekloud.com/t/linux-archives-task-failed/2064
https://community.kodekloud.com/t/linux-archive-task-failed/3226
https://community.kodekloud.com/t/failed-task-linux-archives/3867

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

	1.	Connect via SSH to Storage Server
	2.	Check the /data directory adn then create a tar,gz file for the requester.
	3.	Move tar.gz file to /home directory.

-----------------------------------------------------------------------------------------------------------------

III.	COMMANDS USED

sshpass -p '******' ssh -o StrictHostKeyChecking=no  natasha@172.16.238.15
ls -l  /data/

#	This creates the tar.gz file for the requester.
sudo tar -cvzf javed.tar.gz /data/javed

#	This moves the tar.gz file to the /home directory.
sudo mv javed.tar.gz /home/

#	Checks the tar.gz file in the /home directory.
ls -l /home/

-----------------------------------------------------------------------------------------------------------------

IV.	STEPS - BREAKDOWN

#	Now I did not spend too much time on searching and learning about this lab.
#	I do understand the gist of how I should doo the lab.
#	After reading some articles in the KKC, I created my script which I'll just copy onto the terminal
#	and just change the name of the requester, the tar.gz file and the requesters's directory.
#	Maybe I'll look at it some other time or I might return to this note in the distant future once 
#	I encounter a similar task.

#	I'm probably just not in the mood or my brain's quite tired from the AWS study the whole day.
#	Will try to focus and learn more on the next task, which would probably come tomorrow afternoon.

thor@jump_host /$thor@jump_host /$ sshpass -p '******' ssh -o StrictHostKeyChecking=no  natasha@172.16.238.15
Warning: Permanently added '172.16.238.15' (ECDSA) to the list of known hosts.
[natasha@ststor01 ~]$
[natasha@ststor01 ~]$ ls -l  /data/
total 4
drwxrwxrwx 2 root root 4096 Jul 13 08:46 javed
[natasha@ststor01 ~]$
[natasha@ststor01 ~]$ sudo tar -cvzf javed.tar.gz /data/javed

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.    #3) With great power comes great responsibility.

[sudo] password for natasha:
#tar: Removing leading `/' from member names
/data/javed/
/data/javed/nautilus1.txt
/data/javed/nautilus2.txt
/data/javed/nautilus3.txt
[natasha@ststor01 ~]$
[natasha@ststor01 ~]$ sudo mv javed.tar.gz /home/
[natasha@ststor01 ~]$
[natasha@ststor01 ~]$ ls -l /home/
total 12
drwx------ 2 ansible ansible 4096 Oct 15  2019 ansible
-rw-r--r-- 1 root    root     202 Jul 13 08:47 javed.tar.gz
drwx------ 1 natasha natasha 4096 Jul 13 08:48 natasha
[natasha@ststor01 ~]$
[natasha@ststor01 ~]$ Connection to host01 closed by remote host.
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

