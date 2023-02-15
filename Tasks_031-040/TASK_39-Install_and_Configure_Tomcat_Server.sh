
-----------------------------------------------------------------------------------------------------------------

Start			2020-09-12 || 05:03 PM
Finished		2020-09-12 || 06:19 PM

-----------------------------------------------------------------------------------------------------------------

TASK 39 - Install and Configure Tomcat Server

REQUIREMENTS:

The Nautilus application development team recently finished the beta version of one of their Java-based applications, which they are planning to deploy on one of the app servers in Stratos DC. After an internal team meeting, they have decided to use the tomcat application server. Based on the requirements mentioned below complete the task:


a. Install tomcat server on App Server 1 using yum.

b. Configure it to run on port 3002.

c. There is a ROOT.war file on Jump host at location /tmp. Deploy it on this tomcat server and make sure the webpage works directly on base URL i.e without specifying any sub-directory anything like this http://URL/ROOT .

d. You can access the website on LBR link. To do so click on the + button on top of your terminal, select option Select port to view on Host 1, and after adding port 80 click on Display Port.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://www.digitalocean.com/community/tutorials/how-to-install-apache-tomcat-7-on-centos-7-via-yum
https://community.kodekloud.com/t/install-and-configure-tomcat/2218/13
https://community.kodekloud.com/t/task-install-and-configure-tomcat-server/5986/2

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

#	1.	SSH into the jump server and App server 1 from two separate terminals and switch
#		to root.
#	2.	On App Server 1, install tomcat service using yum.
#		Enable, start, and verify status of service afterwards.
#	3.	Change the connector port number on /usr/share/tomcat/conf/server.xml to the port number required.
#		Enable, start, and verify status of service afterwards.
#	4.	On the jump server, check the ROOT.war in /tmp and copy it to the /tmp of App Server 1.
#		Then App Server 1, copy the ROOT.war onto the /usr/share/tomcat/webapps.
#	5.	On App Server 1, curl the localhost using the required port.
#		You could try to access the website on LBR link. To do so click on the + button on top of your terminal, 
#		select option Select port to view on Host 1, and after adding port 80 click on Display Port.

-----------------------------------------------------------------------------------------------------------------

III.	STEPS - BREAKDOWN

#	1.	SSH into the jump server and App server 1 from two separate terminals and switch
#		to root.

			sudo su -
			******	

			sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
			sudo su -
			******

#	2.	On App Server 1, install tomcat service using yum.
#		Enable, start, and verify status of service afterwards.

			sudo yum install -y tomcat

			systemctl enable tomcat 
			systemctl start tomcat 
			systemctl status tomcat

#	3.	Change the connector port number on /usr/share/tomcat/conf/server.xml to the port number required.
#		Enable, start, and verify status of service afterwards.

			cat /usr/share/tomcat/conf/server.xml | grep connector
			vi /usr/share/tomcat/conf/server.xml

				<Connector port="8081" protocol="HTTP/1.1"			# 8081 is the requried port for this lab.
						   connectionTimeout="20000"
						   redirectPort="8443" />

			systemctl enable tomcat 
			systemctl start tomcat 
			systemctl status tomcat
			   
#	4.	On the jump server, check the ROOT.war in /tmp and copy it to the /tmp of App Server 1.
#		Then on App Server 1, copy the ROOT.war onto the /usr/share/tomcat/webapps.

			ll /tmp
			scp /tmp/ROOT.war tony@172.16.238.10:/tmp
			
			# Then on App Server 1, copy the ROOT.war onto the /usr/share/tomcat/webapps.

			ll /tmp	
			ll /usr/share/tomcat/webapps/

			cp /tmp/ROOT.war /usr/share/tomcat/webapps
			ll /usr/share/tomcat/webapps/

#	5.	On App Server 1, curl the localhost using the required port.
#		You could try to access the website on LBR link. To do so click on the + button on top of your terminal, 
#		select option Select port to view on Host 1, and after adding port 80 click on Display Port.

			curl -i http://localhost:8081

				HTTP/1.1 200 OK
				Server: Apache-Coyote/1.1
				Accept-Ranges: bytes
				ETag: W/"471-1580289830000"
				Last-Modified: Wed, 29 Jan 2020 09:23:50 GMT
				Content-Type: text/html
				Content-Length: 471
				Date: Sat, 12 Sep 2020 09:49:32 GMT	
				

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


