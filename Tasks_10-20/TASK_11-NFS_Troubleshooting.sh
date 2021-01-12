
-----------------------------------------------------------------------------------------------------------------

Start		2020-07-09 || 09:14 PM	
Finished	2020-07-10 || 05:24 AM

-----------------------------------------------------------------------------------------------------------------

TASK 11 - NFS Troubleshooting

REQUIREMENT:

The Nautilus production support team was trying to fix issues with their storage server. The storage server has a shared directory /code, which is mounted on all app servers at location /var/www/html so that whatever data they store on storage server under /code can be shared among all app servers. Somehow NFS server is broken and having some issues.

Identify the root cause of the issue and fix it to make sure sharing works fine among all app servers and storage server.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://www.tecmint.com/how-to-setup-nfs-server-in-linux/				-------- MOST USEFUL OF ALL
https://community.kodekloud.com/t/nfs-troubleshooting-failure/2493/2	
https://community.kodekloud.com/t/nfs-troubleshoot/8299
https://community.kodekloud.com/t/task-19-nfs-troubleshooting/1679
https://community.kodekloud.com/t/nfs-server-broke/1921/22				-------- MOST USEFUL OF ALL

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

	1.	Connect via SSH to the Storage Server.
	2.	Make sure NFS is installed. If not, install and enable NFS utiities anyway.
	3.	Edit the /etc/exports file. This should contain the ip address of the three App servers.
	4.	To ensure that file system shared directory will reflect on the Appservers, make sure to. 
		export file system (exportfs)
	5.	Create a file inside the shared directory - this should be seen by all App servers once NFS
		is installed and configured on them.
	6.	Connect via SSH to each App server. For each one, do the next steps.
	7.	Install and enable the NFS utilities.
	8.	Ensure App server sees the filesystem and the correct shared shared directory(showmount).
	9.	Once it does, mount the directory into the App server.
	10.	Verify directory is mounted. Also, verify that the file previously created (in Storage Server)
		can be seen when App server/s access the shared directory.
	
-----------------------------------------------------------------------------------------------------------------

III.	COMMANDS USED

#	1.	Connect via SSH to the Storage Server.
#   2.	Make sure NFS is installed. If not, install and enable NFS utiities anyway.	

sshpass -p  '******' ssh -o StrictHostKeyChecking=no natasha@172.16.238.15

systemctl status nfs								#	checks status of NFS - if it is installed 							

sudo yum install -y nfs-utils nfs-utils-lib			#	installs NFS packages anyway
													#	need to enter password here.
sudo yum install -y portmap 
sudo systemctl enable nfs							#	enables and starts the service
sudo systemctl start  nfs


#	3.	Edit the /etc/exports file. This should contain the ip address of the three App servers.

cat /etc/exports									#	checks contents of export file
sudo vi /etc/exports								#	edits the export file

/opt 172.16.238.10(rw,sync,no_subtree_check,no_root_squash,fsid=0)		#	note that /web is the
/opt 172.16.238.11(rw,sync,no_subtree_check,no_root_squash,fsid=0)		#	shared/mounting directory
/opt 172.16.238.12(rw,sync,no_subtree_check,no_root_squash,fsid=0)


#	4.	To ensure that file system shared directory will reflect on the Appservers, make sure to. 
#		export file system (exportfs)
#	5.	Create a file inside the shared directory - this should be seen by all App servers once NFS
#		is installed and configured on them.

sudo exportfs -r
sudo touch /opt/testeden.txt


#	6.	Connect via SSH to each App server. For each one, do the next steps.

sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10		#	App server 1
sshpass -p  '******' ssh -o StrictHostKeyChecking=no steve@172.16.238.11		#	App server 2
sshpass -p  '******' ssh -o StrictHostKeyChecking=no banner@172.16.238.12		#	App server 3


#	7.	Install and enable the NFS utilities.
#	8.	Ensure App server sees the filesystem and the correct shared shared directory(showmount).
#	9.	Once it does, mount the directory into the App server.
#	10.	Verify directory is mounted. Also, verify that the file previously created (in Storage Server)
#		can be seen when App server/s access the shared directory.

sudo yum install -y nfs-utils nfs-utils-lib										#	installs NFS packages anyway
																				#	need to enter password here.
sudo yum install -y portmap 								
sudo systemctl enable nfs
sudo systemctl start  nfs

showmount -e 172.16.238.15														#	Number 8

sudo mount -t nfs 172.16.238.15:/opt /var/www/html/								#	Number 9

mount | grep nfs																#	Number 10
ls -l /var/www/html


-----------------------------------------------------------------------------------------------------------------

IV.	STEPS - BREAKDOWN

#	So this was probably at the borderline between easy and intermediate, but leaning more closely to intermediate
#	difficulty. I think I repeated this for like 10 times or more.
#	The first 6 times was probably for trial and error and also learning the steps, as well as
#	following the resources I found in the KKC and the internet.
#	The last four times or more I think, i repeated because I was waiting for the /web or /opt to appear
#	in the instructions again.
#	Note that the mounting/shared directory changes everytime you restart a lab, and I already have my
#	scripts prepared after the first 6 times. i settled for /opt directory and proceeded in
#	copy-pasting the commands intot he CLI until I finished the lab.

#	I also made some changes here in my documentation:
#		-	I added START TIME and END TIME - this is for me to measure how much time I spend in doing 
#			the lab and the documentation
#		-	I also inserted another section, "COMMANDS USED".
#		-	And as for the final section "STEPS - BREAKDOWN", this would contain my personal notes and the
#			scrapes of the lab.


thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no natasha@172.16.238.15Warning: Permanently added '172.16.238.15' (ECDSA) to the list of known hosts.
[natasha@ststor01 ~]$
[natasha@ststor01 ~]$ sudo yum install -y nfs-utils nfs-utils-lib

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for natasha:
Loaded plugins: fastestmirror, ovl
Determining fastest mirrors
 * base: ftp.fau.de * extras: ftp.rz.uni-frankfurt.de

Updated:
  rpcbind.x86_64 0:0.2.0-49.el7

Complete!
[natasha@ststor01 ~]$ sudo systemctl enable nfs
Created symlink from /etc/systemd/system/multi-user.target.wants/nfs-server.service to /usr/lib/systemd/system/nfs-server.service.
[natasha@ststor01 ~]$ sudo systemctl start  nfs
[natasha@ststor01 ~]$
[natasha@ststor01 ~]$ sudo vi /etc/exports
[natasha@ststor01 ~]$ sudo exportfs -r
[natasha@ststor01 ~]$
[natasha@ststor01 ~]$ sudo touch /opt/testeden.txt
[natasha@ststor01 ~]$ exit
logout
Connection to 172.16.238.15 closed.

thor@jump_host /$
thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
Warning: Permanently added '172.16.238.10' (ECDSA) to the list of known hosts.
[tony@stapp01 ~]$ sudo yum install -y nfs-utils nfs-utils-lib

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for tony:
Loaded plugins: fastestmirror, ovl
Determining fastest mirrors
 * base: ftp.fau.de * extras: ftp.rz.uni-frankfurt.de

Updated:
  rpcbind.x86_64 0:0.2.0-49.el7
  
Complete!
[tony@stapp01 ~]$ sudo systemctl enable nfs
Created symlink from /etc/systemd/system/multi-user.target.wants/nfs-server.service to /usr/lib/systemd/system/nfs-server.service.
[tony@stapp01 ~]$ sudo systemctl start  nfs
[tony@stapp01 ~]$
[tony@stapp01 ~]$ showmount -e 172.16.238.15
Export list for 172.16.238.15:
/opt 172.16.238.12,172.16.238.11,172.16.238.10
[tony@stapp01 ~]$
[tony@stapp01 ~]$ sudo mount -t nfs 172.16.238.15:/opt /var/www/html/
[tony@stapp01 ~]$
[tony@stapp01 ~]$ mount | grep nfs
sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw,relatime)
nfsd on /proc/fs/nfsd type nfsd (rw,relatime)
172.16.238.15:/opt on /var/www/html type nfs (rw,relatime,vers=3,rsize=262144,wsize=262144,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=172.16.238.15,mountvers=3,mountport=20048,mountproto=udp,local_lock=none,addr=172.16.238.15)
[tony@stapp01 ~]$
[tony@stapp01 ~]$ ls -l /var/www/html
total 4
-rw-r--r-- 1 root root 7 Jul  9 20:32 testeden.txt
[tony@stapp01 ~]$
[tony@stapp01 ~]$ exit
logout
Connection to 172.16.238.10 closed.


thor@jump_host /$
thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
Warning: Permanently added '172.16.238.11' (ECDSA) to the list of known hosts.
[steve@stapp02 ~]$ sudo yum install -y nfs-utils nfs-utils-lib

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for steve:
Loaded plugins: fastestmirror, ovl
Determining fastest mirrors
 * base: ftp.fau.de * extras: ftp.rz.uni-frankfurt.de

Updated:
  rpcbind.x86_64 0:0.2.0-49.el7
  
Complete!
[steve@stapp02 ~]$ 
[steve@stapp02 ~]$ sudo systemctl enable nfs
Created symlink from /etc/systemd/system/multi-user.target.wants/nfs-server.service to /usr/lib/systemd/system/nfs-server.service.
[steve@stapp02 ~]$ sudo systemctl start  nfs
[steve@stapp02 ~]$ 
[steve@stapp02 ~]$ showmount -e 172.16.238.15
Export list for 172.16.238.15:
/opt 172.16.238.12,172.16.238.11,172.16.238.10
[steve@stapp02 ~]$ 
[steve@stapp02 ~]$ sudo mount -t nfs 172.16.238.15:/opt /var/www/html/
[steve@stapp02 ~]$ 
[steve@stapp02 ~]$ mount | grep nfs
sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw,relatime)
nfsd on /proc/fs/nfsd type nfsd (rw,relatime)
172.16.238.15:/opt on /var/www/html type nfs (rw,relatime,vers=3,rsize=262144,wsize=262144,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=172.16.238.15,mountvers=3,mountport=20048,mountproto=udp,local_lock=none,addr=172.16.238.15)
[steve@stapp02 ~]$ 
[steve@stapp02 ~]$ ls -l /var/www/html
total 4
-rw-r--r-- 1 root root 7 Jul  9 20:32 testeden.txt
[steve@stapp02 ~]$
[steve@stapp02 ~]$ exit
logout
Connection to 172.16.238.11 closed.


thor@jump_host /$
thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
Warning: Permanently added '172.16.238.12' (ECDSA) to the list of known hosts.
[banner@stapp03 ~]$ sudo yum install -y nfs-utils nfs-utils-lib

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for banner:
Loaded plugins: fastestmirror, ovl
Determining fastest mirrors
 * base: ftp.fau.de * extras: ftp.rz.uni-frankfurt.de

Updated:
  rpcbind.x86_64 0:0.2.0-49.el7
  
Complete!
[banner@stapp03 ~]$
[banner@stapp03 ~]$ sudo yum install -y portmap
Loaded plugins: fastestmirror, ovl
[banner@stapp03 ~]$
Updated:
  rpcbind.x86_64 0:0.2.0-49.el7

Complete!
[banner@stapp03 ~]$ sudo systemctl enable nfs
Created symlink from /etc/systemd/system/multi-user.target.wants/nfs-server.service to /usr/lib/systemd/system/nfs-server.service.
[banner@stapp03 ~]$ sudo systemctl start  nfs
[banner@stapp03 ~]$
[banner@stapp03 ~]$ showmount -e 172.16.238.15
Export list for 172.16.238.15:
/opt 172.16.238.12,172.16.238.11,172.16.238.10
[banner@stapp03 ~]$
[banner@stapp03 ~]$ sudo mount -t nfs 172.16.238.15:/opt /var/www/html/
[banner@stapp03 ~]$
[banner@stapp03 ~]$ mount | grep nfs
sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw,relatime)
nfsd on /proc/fs/nfsd type nfsd (rw,relatime)
172.16.238.15:/opt on /var/www/html type nfs (rw,relatime,vers=3,rsize=262144,wsize=262144,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=172.16.238.15,mountvers=3,mountport=20048,mountproto=udp,local_lock=none,addr=172.16.238.15)
[banner@stapp03 ~]$
[banner@stapp03 ~]$ ls -l /var/www/html
total 4
-rw-r--r-- 1 root root 7 Jul  9 20:32 testeden.txt
[banner@stapp03 ~]$
[banner@stapp03 ~]$ cd /var/www/html
[banner@stapp03 html]$ ls -l
total 4
-rw-r--r-- 1 root root 7 Jul  9 20:32 testeden.txt
[banner@stapp03 ~]$
[banner@stapp03 html]$ sudo rm testeden.txt
[banner@stapp03 html]$
[banner@stapp03 html]$ ls -l
total 0
[banner@stapp03 html]$
[banner@stapp03 html]$ exit
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



