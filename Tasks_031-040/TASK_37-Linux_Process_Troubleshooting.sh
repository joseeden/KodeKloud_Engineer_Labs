
-----------------------------------------------------------------------------------------------------------------

Start			2020-09-10 || 03:14 AM
Finished		2020-09-10 || 04:17 AM

-----------------------------------------------------------------------------------------------------------------

TASK 37 - Linux Process Troubleshooting 

REQUIREMENTS:

The production support team of xFusionCorp Industries has deployed some of the latest monitoring tools to keep an eye on every service, application, etc. running on the systems. One of the monitoring systems reported about Apache service unavailability on one of the app servers in Stratos DC.


Identify the faulty app host and fix the issue. Make sure Apache service is up and running on all app hosts. Also, do not try to change the Apache port on any host.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://community.kodekloud.com/t/linux-process-troubleshooting-start-service-issue/6154/8
https://community.kodekloud.com/t/linux-process-troubleshooting-failed/6115/4				# explains the issue

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

#	1.	SSH into the App server 1, App server 2, and App server 3 and switch 
#		to root. Check which of the App Servers has an inactive httpd service.
#	2. 	Try to enable and restart and then verify status of httpd again.
#		If it's still not coming up, there may be issue on permission or ports
#	3.	Check httpd.conf file for the Listening port.
#		Check the errors again.
#	4.	Kill the process which are occupying the port.
#		Enable, start, and verify status of httpd.

-----------------------------------------------------------------------------------------------------------------

III.	COMMANDS USED

#	1.	SSH into the App server 1, App server 2, and App server 3 and switch 
#		to root. Check which of the App Servers has an inactive httpd service.

			sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
			sudo su -
			******

			sshpass -p  '******' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
			sudo su -
			******

			sshpass -p  '******' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
			sudo su -
			******


#	2. 	Try to enable and restart and then verify status of httpd again.
#		If it's still not coming up, there may be issue on permission or ports

			systemctl enable httpd
			systemctl start httpd
			systemctl status httpd
			
#	3.	Check httpd.conf file for the Listening port.
#		Check the errors again.

			cat /etc/httpd/conf/httpd.conf | grep Listen
			
				# Listen: Allows you to bind Apache to specific IP addresses and/or
				# Change this to Listen on specific IP addresses as shown below to
				#Listen 12.34.56.78:80
				Listen 6100
				
			httpd -t

				AH00558: httpd: Could not reliably determine the server fully qualified domain name, 
				using 172.16.238.10. Set the 'ServerName' directive globally to suppress this message
				Syntax OK
				
			yum install -y net-tools

			netstat -tulpen
			netstat -tulpen | grep 6100
			
				Sep 09 20:02:33 stapp01 httpd[365]: (98)Address already in use: AH00072: make_sock: 
				could not bind to address 0.0.0.0:6100

			# Look at this Error. It is because of port unavailability, just need free the port and 
			# start the application
			

#	4.	Kill the process which are occupying the port.
#		Enable, start, and verify status of httpd.

			sudo kill -9 333
			systemctl enable httpd
			systemctl start httpd
			systemctl status httpd

-----------------------------------------------------------------------------------------------------------------

IV.	STEPS - BREAKDOWN

# This one's fairly easy so i believe I was able to finish this in less than an hour -- went through some
# reading on th eKKC articles first just to make sure.

# Attach is the supportfile for the scrapes of App Server 1.

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

