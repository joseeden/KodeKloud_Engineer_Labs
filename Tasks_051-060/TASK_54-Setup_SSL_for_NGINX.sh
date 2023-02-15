
-----------------------------------------------------------------------------------------------------------------

Start			2020-11-28 21:55:00
Finished	    2020-11-28 22:52:43

-----------------------------------------------------------------------------------------------------------------

TASK_54-Setup_SSL_for_NGINX

** This is a repeated task.
** this was TASK 28, completed last 2020-08-02.

REQUIREMENTS:

The system admins team of xFusionCorp Industries needs to deploy a new application on App Server 2 in Stratos Datacenter. They have some pre-requites to get ready that server for application deployment. Prepare the server as per requirements shared below:

Install and configure nginx on App Server 2.

On App Server 2 there is a self signed SSL certificate and key present at location /tmp/nautilus.crt and /tmp/nautilus.key. Move them to some appropriate location and deploy the same in Nginx.

Create an index.html file with content Welcome! under Nginx document root.

For final testing try to access the App Server 2 link (either hostname or IP) from jump host using curl command. For example curl -Ik https://<app-server-ip>/.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

TASK 28 - Setup SSL for NGINX.sh

https://community.kodekloud.com/t/ssl-nginx-setup-error/9311	# so helpful!

# now the next one explains alot on where the TLS/SSL certificate should be placed.
https://serverfault.com/questions/681336/why-do-apache-ssl-certificate-and-key-need-to-be-in-etc-pki-tls-private

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

#	1.	Connect via SSH to the App server and switch to roout user.
#	2.	Install nginx. Start, enable, and then verify status.
#	3.	Move the SSL certificate and the certificate key to the appropriate location.
#	4.	Modify nginx.conf to reflect the configuration for the TLS. Verify that nginx.conf is good.
#	5.	Restart nginx to reflect the updates.
#	6.	Verify document root of nginx and proceed there. Create the index.html
#	7.	Return to jump host and verify https connection to App server through curl.

-----------------------------------------------------------------------------------------------------------------

III.	STEPS - BREAKDOWN

#	1.	Connect via SSH to the App server and switch to root user.
#		Switching to root user simplifies the succeeding commands as I won't have to use sudo and enter password
#		everytime I run a root-level command.

        sshpass -p  '******' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
        sudo su -
        ******

#	2.	Install nginx. Start, enable, and then verify status.

        sudo yum install epel-release -y
        sudo yum install -y nginx
        systemctl enable nginx
        systemctl start nginx
        systemctl status nginx
			
#	3.	Move the SSL certificate and the certificate key to the appropriate location.

        # Normally the SSL certificates are found/should be found under /etc
        # Check if the path is existing. If yes, move the two mentioned certs to this directory.

        ls -l /etc/pki/tls/certs/
        ls -l /tmp

        mv /tmp/nautilus.crt /etc/pki/tls/certs/
        mv /tmp/nautilus.key /etc/pki/tls/certs/

        # Verify that the two items are indeed moved.

        ls -l /etc/pki/tls/certs/
        ls -l /tmp

#	4.	Modify nginx.conf to reflect the configuration for the TLS. Verify that nginx.conf is good.

        # It's always best practice to check nginx.conf
        # This is where the document rot is specified.
        # Configuration for enabling TLS server is also here. Make sure this section is correct

        cat /etc/nginx/nginx.conf

        # To check if there's an error in the nginx.conf:

        nginx -t 

        # For the needed changes, check 'TASK 28 - Setup SSL for Nginx-nginx.conf.sh' file.

        cd /etc/nginx/
        vi nginx.conf

        # One thing I've learned from Task 27 was to verify nginx.conf won't be causing any error.
        # This can be done through:

        nginx -t 

        # If the nginx.conf is good and no error is detected, it will return the following:

            nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
            nginx: configuration file /etc/nginx/nginx.conf test is successful
                        
#	5.	Restart nginx to reflect the updates.
		
        systemctl enable nginx
        systemctl start nginx
        systemctl restart nginx
        systemctl status nginx
			
#	6.	Verify document root of nginx and proceed there. Create the index.html

        cat /etc/nginx/nginx.conf | grep root
        ls -l /usr/share/nginx/html/
        cd /usr/share/nginx/html/

        # Since there's an existing linked index.html, will need to delete that before creating a new one.

        rm index.html			# Enter 'yes' after prompt.

        ls -l /usr/share/nginx/html/

        cat > index.html

        # The index.html should contain:
            
        Welcome!
            
        # Verify index.html

        cat index.html
				
#	7.	Return to jump host and verify https connection to App server through curl.
            
        # For testing, we can use two curl commands:

        curl -Ik https://172.16.238.11

            # If the tasks were done correct, this curl command should return:

            HTTP/1.1 200 OK
            Server: nginx/1.16.1
            Date: Sun, 02 Aug 2020 04:43:53 GMT
            Content-Type: text/html
            Content-Length: 10
            Last-Modified: Sun, 02 Aug 2020 04:43:21 GMT
            Connection: keep-alive
            ETag: "5f264469-a"
            Accept-Ranges: bytes
    

        # To verify the index.html we could use:

        curl --insecure https://172.16.238.11

            # This one should return the index.html

            Welcome!

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

