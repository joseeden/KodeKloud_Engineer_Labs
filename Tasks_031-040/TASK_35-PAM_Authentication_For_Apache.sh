
-----------------------------------------------------------------------------------------------------------------

Start			2020-09-06 || 11:12 PM
Finished		2020-09-07 || 12:48 AM

-----------------------------------------------------------------------------------------------------------------

TASK 35 - PAM Authentication For Apache

REQUIREMENTS:

The document root /var/www/html of all web apps is on NFS share /data on storage server in Stratos Datacenter. 
We have a requirement where we want to password protect a directory in the Apache web server document root. 
We want to password protect http://<website-url>:<apache_port>/protected URL as per the following requirements 
(you can use any website-url for it like localhost since there are no such specific requirements as of now):


a. We want to use basic authentication.

b. We do not want to use htpasswd file base authentication. Instead, we want to use PAM authentication, i.e Basic 	Auth + PAM so that we can authenticate with a Linux user.

c. We already have a user ammar with password LQfKeWWxWD which you need to provide access to.

d. You can access the website on LBR link. To do so click on the + button on top of your terminal, select Select 	port to view on Host 1, and after adding port 80 click on Display Port.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://www.server-world.info/en/note?os=CentOS_7&p=httpd&f=10
https://community.kodekloud.com/t/how-to-complete-the-pam-authentication-task/1228/48
https://community.kodekloud.com/t/pam-authentication-for-apache-question/5091/6
https://community.kodekloud.com/t/pam-authentication-for-apache-probable-issue-with-lbr-link/5730/15

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

#	1.	SSH into the jump server, Storage Server, App server 1, App server 2, and App server 3 and switch 
#		to root.
#	2.	All configurations are done on the App servers. 
#		Install and enable the required packages for Basic + PAM authentication
#	3.	Modify the /etc/httpd/conf.d/authnz_external.conf file to add the directory and 
#		aattributes.
#	4.	Enable, restart, and verify the status of appache (httpd) afterwards.
#		As an additional verification, check the /etc/httpd/conf/httpd.conf file for the documentroot.
#	5.	To test if authentication is working, access the website on LBR link. Click on the + button on top
#		of terminal, select Select 	port to view on Host 1, and after adding port 80 click on Display Port.
#		This should display the testpage.
#	6.	On the testpage, add /protected on the URL. This should prompt you to enter a username and password.
#		After entering the username/pw provided, page should display 'This is KodeKloud protected directory'
#	7.	As an additional verification, use curl commands on the App Servers.

-----------------------------------------------------------------------------------------------------------------

III.	COMMANDS USED


#	1.	SSH into the jump server, Storage Server, App server 1, App server 2, and App server 3 and switch 
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
						
#	2.	All configurations are done on the App servers. 
#		Install and enable the required packages for Basic + PAM authentication.
		
			yum --enablerepo=epel -y install mod_authnz_external pwauth

#	3.	Modify the /etc/httpd/conf.d/authnz_external.conf file to add the directory and 
#		attributes.

			vi /etc/httpd/conf.d/authnz_external.conf

				<Directory /var/www/html/protected> 
					AuthType Basic
					AuthName "PAM Authentication"
					AuthBasicProvider external
					AuthExternal pwauth
					require valid-user
				</Directory>

#	4.	Enable, restart, and verify the status of appache (httpd) afterwards.

			systemctl enable httpd && systemctl start httpd && systemctl status httpd

#		As an additional verification, check the /etc/httpd/conf/httpd.conf file for the documentroot.

			cat /etc/httpd/conf/httpd.conf | grep -i documentroot
			
				# DocumentRoot: The directory out of which you will serve your
				DocumentRoot "/var/www/html"
				# access content that does not live under the DocumentRoot.
			
#	5.	To test if authentication is working, access the website on LBR link. Click on the + button on top
#		of terminal, select Select 	port to view on Host 1, and after adding port 80 click on Display Port.
#		This should display the testpage.

#	6.	On the testpage, add /protected on the URL. This should prompt you to enter a username and password.
#		After entering the username/pw provided, page should display 'This is KodeKloud protected directory'

#	7.	As an additional verification, use curl commands on the App Servers.

			curl  http://stapp01:8080/protected/index.html 
			curl -u ammar:LQfKeWWxWD http://stapp01:8080/protected/
			curl -u ammar:LQfKeWWxWD http://stapp01:8080/protected/index.html
			curl -u ammar:LQfKeWWxWD http://localhost:8080/protected/

			curl http://stapp02:8080/protected/index.html
			curl -u ammar:LQfKeWWxWD http://stapp02:8080/protected/
			curl -u ammar:LQfKeWWxWD http://stapp02:8080/protected/index.html
			curl -u ammar:LQfKeWWxWD http://localhost:8080/protected/index.html
			curl -u ammar:LQfKeWWxWD http://localhost:8080/protected/

			curl http://stapp03:8080/protected/index.html
			curl -u ammar:LQfKeWWxWD http://stapp03:8080/protected/
			curl -u ammar:LQfKeWWxWD http://stapp03:8080/protected/index.html
			curl -u ammar:LQfKeWWxWD http://localhost:8080/protected/
			curl -u ammar:LQfKeWWxWD http://stlb01:8080/protected/

			curl http://stlb01:8080/protected/
			

-----------------------------------------------------------------------------------------------------------------

IV.	STEPS - BREAKDOWN

#	Please see SF for the scrapes for the App Server 1.
#	Note that the scrape for App server 1 is the same for App Server 2 and App Server 3.

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

