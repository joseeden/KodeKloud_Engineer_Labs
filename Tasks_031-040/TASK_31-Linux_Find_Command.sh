
-----------------------------------------------------------------------------------------------------------------

Start			2020-08-08 || 02:06 AM
Finished		2020-08-08 || 03:07 AM

-----------------------------------------------------------------------------------------------------------------

TASK 31 - Linux Find Command

REQUIREMENTS:

During a routine security audit, the team identified an issue on the Nautilus App Server. Some malicious content was identified within the website code. After digging into the issue they found that there might be more infected files. Before doing a cleanup they would like to find all similar files and copy them to a safe location for further investigation. Accomplish the task as per the following requirements:


a. On App Server 2 at location /var/www/html/blog  find out all files (not directories) having .css extension.

b. Copy all those files along with their parent directory structure to location /blog on same server.

c. Please make sure not to copy the entire /var/www/html/blog  directory content.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://community.kodekloud.com/t/linux-find-command-successfull/6587
https://unix.stackexchange.com/questions/83593/copy-specific-file-type-keeping-the-folder-structure

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

#	1.	Connect via SSH to the App server.
#	2.	Proceed to the specified directory and copy required files into another specified directory.
#		Afterwards, verify.

-----------------------------------------------------------------------------------------------------------------

III.	COMMANDS USED

#	1.	Connect via SSH to the App server.

			# This was actually one of the easier labs in terms of the steps required.
			# I mean the tasks can be done by using just two lines - the hard part was searching what 
			# these lines are.
			# Luckily, I immediately found an article in the KKC which states the requried steps.
			# What took me time was I was not able to copy the needed files into the required directory 
			# even though I ran the command. Found out later that there just an incorrect character on
			# the command I use.
			
				sshpass -p  '******' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
				sudo su -
				******

#	2.	Proceed to the specified directory and copy required files into another specified directory.
#		Afterwards, verify.

			# As always, check first the directory and/or the file
			# Here, the /var/www/html/blog will be where the files and directories be located.
			# The blog directory which is actually another directory with the same name is on the 
			# the same number.
			
				ls -l /var/www/html/blog 
				sudo ls -ltr /blog
				
			# Now this was the critical line to find all the files with the '.css' extension within the
			# specified path. This line also includes copying the files into the destination/directory.
			
				sudo find /var/www/html/blog -name '*.css' -exec cp --parents \{\} /blog \;

			# Now the destination directory was initially checked and it was empty.
			# After copying the files, the destination directory will have one nested directory - 'var'

				sudo ls -ltr /blog

-----------------------------------------------------------------------------------------------------------------

IV.	STEPS - BREAKDOWN

thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no steve@172.16.238.11Warning: Permanently added '172.16.238.11' (ECDSA) to the list of known hosts.
sudo su -
******[steve@stapp02 ~]$ sudo su -

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for steve:
[root@stapp02 ~]#
[root@stapp02 ~]# ls -l /var/www/html/blogtotal 208
-rw-r--r--  1 root root   420 Nov 30  2017 index.php
-rw-r--r--  1 root root 19935 Jan  1  2019 license.txt
-rw-r--r--  1 root root  7368 Sep  2  2019 readme.html
-rw-r--r--  1 root root  6939 Sep  3  2019 wp-activate.php
drwxr-xr-x  9 root root  4096 Dec 18  2019 wp-admin
-rw-r--r--  1 root root   369 Nov 30  2017 wp-blog-header.php
-rw-r--r--  1 root root  2283 Jan 21  2019 wp-comments-post.php
-rw-r--r--  1 root root  2898 Jan  8  2019 wp-config-sample.php
drwxr-xr-x  4 root root  4096 Dec 18  2019 wp-content
-rw-r--r--  1 root root  3955 Oct 10  2019 wp-cron.php
drwxr-xr-x 20 root root 12288 Dec 18  2019 wp-includes
-rw-r--r--  1 root root  2504 Sep  3  2019 wp-links-opml.php
-rw-r--r--  1 root root  3326 Sep  3  2019 wp-load.php
-rw-r--r--  1 root root 47597 Dec  9  2019 wp-login.php
-rw-r--r--  1 root root  8483 Sep  3  2019 wp-mail.php
-rw-r--r--  1 root root 19120 Oct 15  2019 wp-settings.php
-rw-r--r--  1 root root 31112 Sep  3  2019 wp-signup.php
-rw-r--r--  1 root root  4764 Nov 30  2017 wp-trackback.php
-rw-r--r--  1 root root  3150 Jul  1  2019 xmlrpc.php
[root@stapp02 ~]#
[root@stapp02 ~]# sudo ls -ltr /blog
total 0
[root@stapp02 ~]#
[root@stapp02 ~]# sudo find /var/www/html/blog -name '*.css' -exec cp --parents \{\} /blog \;
[root@stapp02 ~]#
[root@stapp02 ~]# sudo ls -ltr /blog
total 4
drwxr-xr-x 3 root root 4096 Aug  7 18:54 var
[root@stapp02 ~]#
[root@stapp02 ~]# Connection to host01 closed by remote host.
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

