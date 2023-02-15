
-----------------------------------------------------------------------------------------------------------------

Start			2020-07-31 || 08:40 PM
Finished		2020-08-01 || 12:01 AM

-----------------------------------------------------------------------------------------------------------------

TASK 27 - Web Server Security

REQUIREMENTS:

During a recent security audit, the application security team of xFusionCorp Industries found security issues with the Apache web server on Nautilus App Server 1 server in Stratos DC. They have listed several security issues that need to be fixed on this server. Please apply the security settings below:

a. On Nautilus App Server 1 it was identified that the Apache web server is exposing the version number. Ensure this server has the appropriate settings to hide the version number of the Apache web server.

b. There is a website hosted under /var/www/html/official on App Server 1. It was detected that the directory /official lists all of its contents while browsing the URL. Disable the directory browser listing in Apache config.

c. Also make sure to restart the Apache service after making the changes.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://catonmat.net/cookbooks/curl/print-response-headers							# insightful, but did not help much
https://www.tecmint.com/hide-apache-web-server-version-information/					# helped on the first task
https://stackoverflow.com/questions/2530372/how-do-i-disable-directory-browsing		# insightful, helped too
https://community.kodekloud.com/t/web-server-security-task-marked-failed/2048		# detailed, helped alot too
https://community.kodekloud.com/t/web-security-server/6111							# actually 1st method I tried.

# Probably the most detailed documentation though I'm not sure if this solved the task 2 as there's no way to verify.
https://devops.ionos.com/tutorials/how-to-harden-the-apache-web-server-on-centos-7/#turn-off-directory-listing
									

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

#	So for this lab, it took me lot of time going through the available articles in KKC and the internet.
#	The first task was easy; the second one was difficult because the suggested way to test was not working at all.
#	So for this one, I used two methods

#	METHOD 1

#	1.	Connect to the App Server via SSH and switch to root user.
#	2.	Check httpd.conf and modify the details under the "/var/www/html" .  At the bottom, put an additional config.
#	3.	Restart HTTPD and check.

#	METHOD 2

#	1.	Connect to the App Server via SSH and switch to root user.
#	2.	Check httpd.conf and modify one option in that file. At the bottom, put an additional config.
#	3.	Create a .htaccess file in the /var/www/html/official directory and put a config inside the .htaccess.
#	4.	Restart HTTPD and check.

#	I was not able to see if the 2nd task was resolved by doing both methods. The suggested way did not work as expected
#	so I decided to combine the two methods into one and hope it satisifess all requirements.

#	COMBINED METHOD

#	1.	Connect to the App Server via SSH and switch to root user.
#	2.	Check httpd.conf and modify the details under the "/var/www/html" .CAt the bottom, put an additional config.
#	3.	Create a .htaccess file in the /var/www/html/official directory and put a config inside the .htaccess.
#	4.	Restart HTTPD and check.

-----------------------------------------------------------------------------------------------------------------

III.	COMMANDS USED

#	1.	Connect to the App Server via SSH and switch to root user.
#		I had multiple attempts on doing lab. The hard part was the second task - the difficult part was actually
#		verifying viewing the site through port 80 will display 'Forbidden' or something like 'Ooops. Unreachable'
#		This is better explained in the next step.

			sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
			sudo su - 
			
#	2.	Check httpd.conf and modify the details under the "/var/www/html" .CAt the bottom, put an additional config.
#		As I've mentioned, I did this lab for multiple times, and I found that the httpd was not running during login.
#		So on my last few attempts, restarting the httpd was the first thing I did - though I should really just
#		use 'start' instead of 'restart' -- anyway, it still did the job.

			sudo systemctl restart httpd 
			systemctl status httpd
			
			# As the first requirement, I need to stop the server from including the version on its http response header.
			# Of course, as best practice, I need to verify this first using the curl command.
			# NOTE: Tried doing variants of curl to display http response but always 'connection refused'
			# so i restarted httpd and then tried curl again. it worked.

			
			curl -I http://stapp02:8080
			curl --head http://172.16.238.11:8080
			curl -V https://localhost:8080			
			
			# i sticked with the curl command below as it returns a much shorter outptu which included all the
			# details I need.
			# Plus I continued using this in every attempt as I don't need to change the server name inside the link.
			
			curl -I http://localhost:8080
			
			# It returns the followign output:
			
				HTTP/1.1 403 Forbidden
				Date: Fri, 31 Jul 2020 15:08:33 GMT
				Server: Apache/2.4.6 (CentOS) PHP/7.2.26			# 2.4.6 is the version number.
				Last-Modified: Thu, 16 Oct 2014 13:20:58 GMT
				ETag: "1321-5058a1e728280"
				Accept-Ranges: bytes
				Content-Length: 4897
				Content-Type: text/html; charset=UTF-8
			
			# To prevent the version number from being displayed, I need to modify  the httpd.conf
			
			ls -l /etc/httpd/conf
			cd /etc/httpd/conf
			sudo vi httpd.conf
			
			# Now, adding the two lines (below) at the bottom solved task 1.
			
				ServerTokens Prod
				ServerSignature Off
			
			# Some of the articles in the net and in KKC suggested that, to solve task 2, I needed to change
			# another line in the same httpd.conf. I needed to verify if doing so will actually resolve task 2.
			# A way to verify this was to view the site through HTTP port 80.
			# There was an option in the KK platform to do that.
			# When the site is displayed, it should showed something like 'Forbidden' or 'Unreachable'.
			# However, the new tab just show the QUIZ page along witht the countdown timer.
			# And this happened in all of my attempts. So there is no was to actually verify if it's working.
			# So I decided to combine the two methods into just one and hope it will satisfy all the requirements
			# event though I have not verified the solution for the Task 2.
			# Note that I did different variants of this two methods.
			# So, going back, I needed to modify a line in the '/var/www/html' directory in the httpd.conf

			ls -l /etc/httpd/conf
			cd /etc/httpd/conf
			sudo vi httpd.conf
			
			# Under the Directory "/var/www/html/blog", I need to change the configuration from this:
		
				<Directory /var/www/html/>
				Options -Indexes 
				AllowOverride All
				Require all granted
				</Directory>

			# To this:

				<Directory /var/www/html/>
				Options -Indexes
				AllowOverride All
				Require all granted
				</Directory>
				
#	3.	Create a .htaccess file in the /var/www/html/official directory and put a config inside the .htaccess.

			cd /var/www/html/official
			vi .htaccess
			
			# the .htaccess should only contain this single line.
			# you could notice that this was also done in the httpd.conf file in step 2.
			
				Options -Indexes
			
			# Ofcourse, verify
			
			ls -l
			cat .htaccess
			
#	4.	Restart HTTPD and check.

			sudo systemctl restart httpd
			systemctl status httpd
			
			# To verify task 1, recall that doing the curl before modifying the httpd.conf showed:

				HTTP/1.1 403 Forbidden
				Date: Fri, 31 Jul 2020 15:08:33 GMT
				Server: Apache/2.4.6 (CentOS) PHP/7.2.26			# 2.4.6 is the version number.
				Last-Modified: Thu, 16 Oct 2014 13:20:58 GMT
				ETag: "1321-5058a1e728280"
				Accept-Ranges: bytes
				Content-Length: 4897
				Content-Type: text/html; charset=UTF-8
			
			# After modifying and restarting httpd, the curl output now shows:
			
				HTTP/1.1 403 Forbidden
				Date: Fri, 31 Jul 2020 15:08:33 GMT
				Server: Apache										# no more version number and OS details.
				Last-Modified: Thu, 16 Oct 2014 13:20:58 GMT
				ETag: "1321-5058a1e728280"
				Accept-Ranges: bytes
				Content-Length: 4897
				Content-Type: text/html; charset=UTF-8			
			
			# Now for task 2, since I'm really not sure how to verify if the steps actually solved task 2,
			# I decided to just hit 'Finish'. Fortunately, it showed 'Success'
			# It's just sad that I actually was not able to check if the config was working as expected.

	
-----------------------------------------------------------------------------------------------------------------

IV.	STEPS - BREAKDOWN


thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10Warning: Permanently added '172.16.238.10' (ECDSA) to the list of known hosts.
[tony@stapp01 ~]$  sudo su -We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for tony:
[root@stapp01 ~]#
[root@stapp01 ~]# ls -l /etc/httpd/conftotal 28
-rw-r--r-- 13 root root 11755 Jan  8  2020 httpd.conf-rw-r--r-- 15 root root 13077 Aug  8  2019 magic
[root@stapp01 ~]#
[root@stapp01 ~]# cd /etc/httpd/conf
[root@stapp01 conf]#
[root@stapp01 conf]# sudo systemctl restart httpd
[root@stapp01 conf]#
[root@stapp01 conf]#
[root@stapp01 conf]# systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: active (running) since Fri 2020-07-31 15:08:10 UTC; 947ms ago
     Docs: man:httpd(8)
           man:apachectl(8)
 Main PID: 243 (httpd)
   Status: "Processing requests..."
   CGroup: /docker/43377f4a694f02f3ca56ba642c727e5d45aaa57bbe32c8a5a28c7adb09c2b515/system.slice/httpd.service
           ├─243 /usr/sbin/httpd -DFOREGROUND
           ├─244 /usr/sbin/httpd -DFOREGROUND
           ├─245 /usr/sbin/httpd -DFOREGROUND
           ├─246 /usr/sbin/httpd -DFOREGROUND
           ├─247 /usr/sbin/httpd -DFOREGROUND
           └─248 /usr/sbin/httpd -DFOREGROUND

Jul 31 15:08:10 stapp01 systemd[1]: Starting The Apache HTTP Server...
Jul 31 15:08:10 stapp01 httpd[243]: AH00558: httpd: Could not reliably determine the serve...age
Jul 31 15:08:10 stapp01 systemd[1]: Started The Apache HTTP Server.
Hint: Some lines were ellipsized, use -l to show in full.
[root@stapp01 conf]#
[root@stapp01 conf]# curl -I http://localhost:8080
HTTP/1.1 403 Forbidden
Date: Fri, 31 Jul 2020 15:08:33 GMT
Server: Apache/2.4.6 (CentOS) PHP/7.2.26
Last-Modified: Thu, 16 Oct 2014 13:20:58 GMT
ETag: "1321-5058a1e728280"
Accept-Ranges: bytes
Content-Length: 4897
Content-Type: text/html; charset=UTF-8

[root@stapp01 conf]#
[root@stapp01 conf]# sudo vi httpd.conf
[root@stapp01 conf]#
[root@stapp01 conf]# cd /var/www/html/official
[root@stapp01 official]#
[root@stapp01 official]# ls -l
total 0
-rw-r--r-- 1 root root 0 Jul 31 15:06 official.txt
[root@stapp01 official]# vi .htaccess
[root@stapp01 official]# ls -l
total 0
-rw-r--r-- 1 root root 0 Jul 31 15:06 official.txt
[root@stapp01 official]#
[root@stapp01 official]# ls -l
total 0
-rw-r--r-- 1 root root 0 Jul 31 15:06 official.txt
[root@stapp01 official]#
[root@stapp01 official]# cat .htaccess
Options -Indexes
[root@stapp01 official]# sudo systemctl restart httpd
[root@stapp01 official]#
[root@stapp01 official]# systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: active (running) since Fri 2020-07-31 15:11:59 UTC; 14ms ago
     Docs: man:httpd(8)
           man:apachectl(8)
  Process: 263 ExecStop=/bin/kill -WINCH ${MAINPID} (code=exited, status=0/SUCCESS)
 Main PID: 266 (httpd)
   Status: "Processing requests..."
   CGroup: /docker/43377f4a694f02f3ca56ba642c727e5d45aaa57bbe32c8a5a28c7adb09c2b515/system.slice/httpd.service
           ├─266 /usr/sbin/httpd -DFOREGROUND
           ├─267 /usr/sbin/httpd -DFOREGROUND
           ├─268 /usr/sbin/httpd -DFOREGROUND
           ├─269 /usr/sbin/httpd -DFOREGROUND
           ├─270 /usr/sbin/httpd -DFOREGROUND
           └─271 /usr/sbin/httpd -DFOREGROUND

Jul 31 15:11:59 stapp01 systemd[1]: Starting The Apache HTTP Server...
Jul 31 15:11:59 stapp01 httpd[266]: AH00558: httpd: Could not reliably determine the serve...age
Jul 31 15:11:59 stapp01 systemd[1]: Started The Apache HTTP Server.
Hint: Some lines were ellipsized, use -l to show in full.
[root@stapp01 official]#
[root@stapp01 official]#
[root@stapp01 official]# curl -I http://localhost:8080
HTTP/1.1 403 Forbidden
Date: Fri, 31 Jul 2020 15:12:14 GMT
Server: Apache
Last-Modified: Thu, 16 Oct 2014 13:20:58 GMT
ETag: "1321-5058a1e728280"
Accept-Ranges: bytes
Content-Length: 4897
Content-Type: text/html; charset=UTF-8

[root@stapp01 official]#
[root@stapp01 official]# cd /etc/httpd/conf
[root@stapp01 conf]# ls -l
total 28
-rw-r--r--  1 root root 11793 Jul 31 15:10 httpd.conf
-rw-r--r-- 15 root root 13077 Aug  8  2019 magic
[root@stapp01 conf]#
[root@stapp01 conf]# sudo vi httpd.conf
[root@stapp01 conf]#
[root@stapp01 conf]# sudo systemctl restart httpd
[root@stapp01 conf]#
[root@stapp01 conf]# systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: active (running) since Fri 2020-07-31 15:14:08 UTC; 210ms ago
     Docs: man:httpd(8)
           man:apachectl(8)
  Process: 290 ExecStop=/bin/kill -WINCH ${MAINPID} (code=exited, status=0/SUCCESS)
 Main PID: 293 (httpd)
   Status: "Processing requests..."
   CGroup: /docker/43377f4a694f02f3ca56ba642c727e5d45aaa57bbe32c8a5a28c7adb09c2b515/system.slice/httpd.service
           ├─293 /usr/sbin/httpd -DFOREGROUND
           ├─294 /usr/sbin/httpd -DFOREGROUND
           ├─295 /usr/sbin/httpd -DFOREGROUND
           ├─296 /usr/sbin/httpd -DFOREGROUND
           ├─297 /usr/sbin/httpd -DFOREGROUND
           └─298 /usr/sbin/httpd -DFOREGROUND

Jul 31 15:14:08 stapp01 systemd[1]: Starting The Apache HTTP Server...
Jul 31 15:14:08 stapp01 httpd[293]: AH00558: httpd: Could not reliably determine the serve...age
Jul 31 15:14:08 stapp01 systemd[1]: Started The Apache HTTP Server.
Hint: Some lines were ellipsized, use -l to show in full.
[root@stapp01 conf]#
[root@stapp01 conf]#
[root@stapp01 conf]# exit
logout
[tony@stapp01 ~]$
[tony@stapp01 ~]$ Connection to host01 closed by remote host.
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
