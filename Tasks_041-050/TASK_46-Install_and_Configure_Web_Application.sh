
-----------------------------------------------------------------------------------------------------------------

Start			2020-11-04 || 01:25 PM
Finished		2020-11-04 || 05:00 PM

-----------------------------------------------------------------------------------------------------------------

TASK 46 - Install and Configure Web Application 


** This was a repeated task. This was Task 42 but but I was not able to resolve it in time and it expired.
** This kinda feel easier on my second try. I have learned the sed utility, which I think made it a bit easier to 
** edit config files.

REQUIREMENTS:

xFusionCorp Industries is planning to host two static websites on their infra in Stratos Datacenter. The development of these websites is still in -progress, but we want to get the servers ready. The storage server has a shared directory /data that is mounted on each app host under /var/www/html directory. Please perform the following steps to accomplish the task:


a. Install httpd package and dependencies on all app hosts.

b. Apache should serve on port 8080 within the apps.

c. There are two website backups /home/thor/media and /home/thor/apps on jump_host. Set them up on Apache in a way that media should work on link http://lb-url/media/ and apps should work on link http://lb-url/apps. (do not worry about load balancer configuration, as its already configured).

d. You can access the website on LBR link; to do so click on the + button on top of your terminal, select the option Select port to view on Host 1, and after adding port 80 click on Display Port.

 
-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://community.kodekloud.com/t/install-and-configure-web-application-failed/7605/33
https://community.kodekloud.com/t/install-and-configure-web-application-task-failed/11933/15
https://community.kodekloud.com/t/install-configure-web-application/7056

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

#	1.	SSH into the jump server, App server 1, App server 2, and App server 3 and then switch 
#		to root.
#	2.	On each App servers, install openssh-clients(this will be used for SCP later) and httpd.
#		Enable, start, and verify status of httpd
#	3.	On each App servers, modify the port where server will listen. This can be done my editing the line 
#		'Listen 80' in http.conf to the required port -8080. Reload httpd service afterwards and verify status.
#	4.	On each app server, view /var/www/html. This would be empty for now but will be filled with the backup directories
#		in Step 6.
#	5.	On the jump server, check directories where the website backups are located.
#		Copy both directories onto the /tmp of each app servers.
#	6.	On App server 1, move these directories onto /var/www/html.
#		The two backup directories should now also reflect in App server 2 and 3.
#	7.	TEST - On each app server, curl the /media and /apps directory.
#		TEST - On the jump server, curl the /media and /apps directry of all app servers.

-----------------------------------------------------------------------------------------------------------------

III.	STEPS - BREAKDOWN

#	1.	SSH into the jump server, App server 1, App server 2, and App server 3 and then switch 
#		to root.

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

#	2.	On each App servers, install openssh-clients(this will be used for SCP later) and httpd.
#		Enable, start, and verify status of httpd

		yum install openssh-clients -y
		sudo yum install -y httpd
		systemctl enable httpd && systemctl start httpd && systemctl status httpd
			Created symlink from /etc/systemd/system/multi-user.target.wants/httpd.service to /usr/lib/systemd/system/httpd.service.
			● httpd.service - The Apache HTTP Server
			   Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor preset: disabled)
			   Active: active (running) since Wed 2020-11-04 08:23:48 UTC; 6ms ago

#	3.	On each App servers, modify the port where server will listen. This can be done my editing the line 
#		'Listen 80' in http.conf to the required port -8080. Reload httpd service afterwards and verify status.

		cd /etc/httpd/conf
		grep -n -i listen httpd.conf	
			34:# Listen: Allows you to bind Apache to specific IP addresses and/or
			38:# Change this to Listen on specific IP addresses as shown below to
			41:#Listen 12.34.56.78:80
			42:Listen 80

		sed -i 42s/80/8080/ httpd.conf			# this substitues '80' with '8080'
		grep -n -i listen httpd.conf
			34:# Listen: Allows you to bind Apache to specific IP addresses and/or
			38:# Change this to Listen on specific IP addresses as shown below to
			41:#Listen 12.34.56.78:80
			42:Listen 8080
			
		systemctl reload httpd && systemctl status httpd
			● httpd.service - The Apache HTTP Server
			   Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor preset: disabled)
			   Active: active (running) since Wed 2020-11-04 08:23:48 UTC; 44s ago
   
#	4.	On each app server, view /var/www/html. This would be empty for now but will be filled with the backup directories
#		in Step 6.

		ll /var/www/html
			total 0

#	5.	On the jump server, check directories where the website backups are located.
#		Copy both directories onto the /tmp of each app servers.

		ll /home/thor/media
			total 4
			-rw-r--r-- 1 root root 118 Nov  4 08:21 index.html
			
		ll /home/thor/apps
			total 4
			-rw-r--r-- 1 root root 117 Nov  4 08:21 index.html
			
		# Since the jump server didn't have permissions to copy files onto the specified directory of each app server,
		# the backup directories are temporarily copied to /tmp. 	
		
		sudo scp -r /home/thor/media tony@172.16.238.10:/tmp

		sudo scp -r /home/thor/apps tony@172.16.238.10:/tmp

		sudo scp -r /home/thor/media steve@172.16.238.11:/tmp

		sudo scp -r /home/thor/apps steve@172.16.238.11:/tmp

		sudo scp -r /home/thor/media banner@172.16.238.12:/tmp

		sudo scp -r /home/thor/apps banner@172.16.238.12:/tmp

#	6.	On App server 1, move these directories onto /var/www/html.
#		The two backup directories should now also reflect in App server 2 and 3.

		[root@stapp01 conf]# ll /var/www/html
		total 0
		[root@stapp01 conf]# ll /tmp
		total 16
		drwxr-xr-x  2 tony tony 4096 Nov  4 08:26 apps
		-rwx------ 50 root root  836 Aug  1  2019 ks-script-rnBCJB
		drwxr-xr-x  2 tony tony 4096 Nov  4 08:26 media
		drwx------  3 root root 4096 Nov  4 08:23 systemd-private-8bcf295c866340ce8036bc794378964d-httpd.service-hfSlt9
		-rw------- 50 root root    0 Aug  1  2019 yum.log
		[root@stapp01 conf]# 
		[root@stapp01 conf]# mv /tmp/media /tmp/apps /var/www/html
		[root@stapp01 conf]# 
		[root@stapp01 conf]# ll /var/www/html
		total 8
		drwxr-xr-x 2 tony tony 4096 Nov  4 08:26 apps
		drwxr-xr-x 2 tony tony 4096 Nov  4 08:26 media

		-----------------------------------------------------------------------------------------------------------------
	
		[root@stapp02 conf]# ll /tmp
		total 16		
		[root@stapp02 conf]# ll /var/www/html
		total 8
		drwxr-xr-x 2 steve steve 4096 Nov  4 08:26 apps
		drwxr-xr-x 2 steve steve 4096 Nov  4 08:26 media

		-----------------------------------------------------------------------------------------------------------------
	
		[root@stapp03 conf]# ll /tmp
		total 16			
		[root@stapp03 conf]# ll /var/www/html
		total 8
		drwxr-xr-x 2 banner banner 4096 Nov  4 08:26 apps
		drwxr-xr-x 2 banner banner 4096 Nov  4 08:26 media
		
#	7.	TEST - On each app server, curl the /media and /apps directory.
#		TEST - On the jump server, curl the /media and /apps directry of all app servers.

		[root@stapp01 conf]# curl -4 http://stapp01:8080/media/
		<!DOCTYPE html>
		<html>
		<body>

		<h1>KodeKloud</h1>

		<p>This is a sample page for our media website</p>

		</body>
		</html>
		
		[root@stapp01 conf]# curl -4 http://stapp01:8080/apps/
		<!DOCTYPE html>
		<html>
		<body>

		<h1>KodeKloud</h1>

		<p>This is a sample page for our apps website</p>

		</body>
		[root@stapp01 conf]# 

		# TEST - On the jump server, curl the /media and /apps directry of all app servers.

		curl -4 http://stapp01:8080/media/
		curl -4 http://stapp01:8080/apps/

		curl -4 http://stapp02:8080/media/
		curl -4 http://stapp02:8080/apps/

		curl -4 http://stapp03:8080/media/
		curl -4 http://stapp03:8080/apps/


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


