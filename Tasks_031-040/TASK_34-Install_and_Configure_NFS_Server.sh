
-----------------------------------------------------------------------------------------------------------------

Start			2020-09-05 || 08:57 PM
Finished		2020-09-05 || 11:06 PM

-----------------------------------------------------------------------------------------------------------------

TASK 34 - Install and Configure NFS Server

REQUIREMENTS:

For our infrastructure in Stratos Datacenter, we need to serve our website code from a common/shared location that can be shared among all app nodes. To solve this, we came up with a solution to use the NFS (Network File System) server where we can store the data and mount the share among our app nodes. The dedicated NFS server will be our storage server. To accomplish this task, perform the following steps:


1. Install required NFS packages on storage server.

2. Configure storage server to act as an NFS server.

3. Make a NFS share /code on storage server.

4. Install and configure NFS client packages on all app nodes and configure them to act as NFS client.

5. Mount /code directory on all app nodes at /var/www/app directory (Create the directories if do not exist).

6. Start and enable required services.

7. There is an /tmp/index.html file on jump host. Copy this file on NFS server (storage server) under /code and   make sure it 	gets replicated to all app servers in mounted location.	

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://www.tutorialspoint.com/how-to-install-and-configure-nfs-server-on-linux
https://stackoverflow.com/questions/17131048/error-when-using-scp-command-bash-scp-command-not-found

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

#	1.	SSH into the jump server, Storage Server, App server 1, App server 2, and App server 3 and switch 
#		to root.
#	2.	Install NFS on Storage Server, App server 1, App server 2, and App server 3.
#		Enable, start, and verify status of nfs service.
#	3.	On Storage Server, add directory and the App servers' IP to /etc/exports.
#		To ensure that shared folderreflect on the Appservers, make sure to export file system (exportfs)
#	4.	On all App servers, create the directory to mount point the shared folder.
#		Afterwards, mount the Share Directory.
#	5.	Verify openssh-clients is installed in both the Jump server and the Storage Server
#		(This is for the SCP operation later). Install if it's not already installed.
#	6.	From jump server, copy the /tmp/index.html to a temporary folder (/tmp) in Storage Server.
#		From Storage Server, move index.html from /tmp to /code.
#	7.	Verify that index.html is visible across the storage Server and the App Servers.

-----------------------------------------------------------------------------------------------------------------

III.	COMMANDS USED

#	1.	SSH into the jump server, Storage Server, App server 1, App server 2, and App server 3 and switch 
#		to root.

			sudo su -
			******	

			sshpass -p '******' ssh -o StrictHostKeyChecking=no  natasha@172.16.238.15
			sudo su -
			******

			sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
			sudo su -
			******

			sshpass -p  '******' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
			sudo su -
			******

			sshpass -p  '******' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
			sudo su -
			******

#	2.	Install NFS on Storage Server, App server 1, App server 2, and App server 3.
#		Enable, start, and verify status of nfs service.

			sudo yum install -y nfs-utils nfs-utils-lib

			systemctl enable nfs
			systemctl start nfs
			systemctl status nfs

#	3.	On Storage Server, add directory and the App servers' IP to /etc/exports.
#		To ensure that shared folderreflect on the Appservers, make sure to export file system (exportfs)

			vi /etc/exports

				/code 172.16.238.10(rw,sync,no_subtree_check,no_root_squash,fsid=0)		
				/code 172.16.238.11(rw,sync,no_subtree_check,no_root_squash,fsid=0)		
				/code 172.16.238.12(rw,sync,no_subtree_check,no_root_squash,fsid=0)

			sudo exportfs -ra

#	4.	On all App servers, create the directory to mount point the shared folder.
#		Afterwards, mount the Share Directory.

			# Creates the directory			
			
				sudo mkdir -p /var/www/app 	 
			
			# Ensure App server sees the filesystem and the correct shared shared directory
			# (showmount)
			
				showmount -e 172.16.238.15	

			# Mounts the directory on the shared folder.
			
				sudo mount -t nfs 172.16.238.15:/code /var/www/app  
				mount | grep nfs	
			
			# Verify that App Server is able to list the mounted directory.
			
				ls -l /var/www/app

#	5.	Verify openssh-clients is installed in both the Jump server and the Storage Server
#		(This is for the SCP operation later). Install if it's not already installed.

			yum info openssh-clients
			sudo yum install -y openssh-clients

#	6.	From jump server, copy the /tmp/index.html to a temporary folder (/tmp) in Storage Server.
#		From Storage Server, move index.html from /tmp to /code.

			# On Jump server, copy index.html using SCP.
			
				sudo scp -r /tmp/index.html natasha@172.16.238.15:/tmp

			# On Storage Server, verify file is copied to /tmp and then move to /code
			# Verify index.html is moved to /code
			
				ls -l /tmp
				mv /tmp/index.html /code
				ls -l /code

#	7.	Verify that index.html is visible across all App Servers.

			ls -l /var/www/app  

-----------------------------------------------------------------------------------------------------------------

IV.	STEPS - BREAKDOWN

#	So this was actually my first time coming back after some hiatus for 25 days.
#	Luckily, I was able to bag both AWS Cloud Practitioner and Solutions Architect during that hiatus. Yey!
#	So coming back, I had to adjust my brain again but it really feels good to do these kind of tasks.

#	Anyway, my comeback task is also great since it has given me 900 POINTS. Another Yey!

#	For the breakdown, check out the supportfiles for this task. Cheers!

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

