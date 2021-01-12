
-----------------------------------------------------------------------------------------------------------------

Start			2020-11-30 00:31:33
Finished	    2020-11-30 01:16:46

-----------------------------------------------------------------------------------------------------------------

TASK_55-Install_and_Configure_HAProxy_LBR

**This is a repeat task.
**This was TASK_32, completed last 2020-08-09.

REQUIREMENTS:

There is a static website of Nautilus project running in Stratos Datacenter. Based on the infrastructure, they have already configured app servers and code is already deployed there. To make it work properly, they need to configure LBR server. There are number of options for that, but team has decided to go with HAproxy.

a. So install and configure HAproxy on LBR server using yum only and make sure all app servers are added to HAproxy load balancer. HAproxy must serve on default http port (Note: Please do not remove stats socket /var/lib/haproxy/stats entry from haproxy default config.).

b. You can access the website on LBR link—to do so click on the + button on top of your terminal, select option Select port to view on Host 1, and after adding port 80 click on Display Port.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

Copied this and added as supporting file
https://community.kodekloud.com/t/hints-on-haproxy-lbr-task/8830  

# This one has complete steps
https://community.kodekloud.com/t/install-and-configure-haproxy-lbr-failed/6411

# Other sources
https://community.kodekloud.com/t/why-install-and-configure-haproxy-lbr-failed/2336/10
https://community.kodekloud.com/t/install-and-configure-haproxy-lbr/2363/18

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

#	1.  Connect via SSH to each App server and take note of the port where the Apache is listening to.
#	    Ensure httpd is running on all App Server.
#	2.	Proceed to LBR Server and install HAproxy through yum only. Enable, start, and then verify status.
#	3.	Modify the HAproxy config file so that HAproxy must server to the default http port - port 80.
#		Also make sure that the App server are added to the Backend section. Restart HAproxy.
#	4.	Return to the jumphost and curl the ip address of each App server - use the port initially noted.

-----------------------------------------------------------------------------------------------------------------

III.	STEPS - BREAKDOWN

#	1.	Connect via SSH to each App server and take note of the port where the Apache is listening to.
#		Ensure httpd is running on all App Server.

		# I found that it's much  easier to run commands when you switch to root user upon connecting to the 
		# App server/s. So for each one, I just run the three lines and i'll be immediately switched to root
		# without entering any password.
		
        sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
        sudo su -
        ******
        
        sshpass -p  '******' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
        sudo su -
        ******
        
        sshpass -p  '******' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
        sudo su -
        ******

		# Note that the following steps are done on EACH APP SERVER - thus all steps from this point onward is 
		# done after connecting via SSH to each App server.
		# Once connected to the App Server, verify the port that the Apache is listening to.
		
        ps -aux | grep httpd	# Not sure if this was helpful but found this in one of the articles in KKC
		
		# The port number can be verified through the httpd.conf file.

        ls -l /etc/httpd/conf/
        cat /etc/httpd/conf/httpd.conf | grep Listen
			
		# So far, all three App server have port '8089'
		
        Listen 8089
		
		# Verify that httpd is running and enabled.
		
        systemctl status httpd
        systemctl enable httpd
        systemctl status httpd
					
#	2.	Proceed to LBR Server and install HAproxy through yum only. Enable, start, and then verify status.
		
        sshpass -p '******' ssh -o StrictHostKeyChecking=no  loki@172.16.238.14
        sudo su -
        ******
		
		# Install HAproxy through YUM then start and enable afterwards.
		
        sudo yum install -y haproxy
        systemctl start haproxy
        systemctl enable haproxy
        systemctl status haproxy
                    
#	3.	Modify the HAproxy config file so that HAproxy must serve to the default http port - port 80.

		# As always, it's best practice to check first the content of the required file.
		# Another best practice is to create a backup file in case you mess up the config file.
		# Since this was a lab, I did not bother to create a backup. But that should always be a must!
		
        ls -l /etc/haproxy/
        cd /etc/haproxy/
        cat haproxy.cfg

		# Once config file is checked, modify it according to th requirement.
		# Make sure that the App server are added to the Backend section. Restart HAproxy.
		# Please check 'TASK 32 - SF - haproxy.cfg(modified).sh' for further details/
			
        vi haproxy.cfg

        # The changes to make are:

        #   - 'frontend main *:80'          << This was initially a different port number.
        #                                      Change to '80'

        #   - add the app servers in the    << Make sure to add the ports where the App Servers
        #    'backend app' section.            are listening to.

        # The modified sections should look something like this:

            #---------------------------------------------------------------------
            # main frontend which proxys to the backends
            #---------------------------------------------------------------------
            frontend  main *:80
                acl url_static       path_beg       -i /static /images /javascript /stylesheets
                acl url_static       path_end       -i .jpg .gif .png .css .js

                use_backend static          if url_static
                default_backend             app

            #---------------------------------------------------------------------
            # round robin balancing between the various backends
            #---------------------------------------------------------------------
            backend app
                balance     roundrobin
                server  stapp01 172.16.238.10:8089 check            << Make sure the ports
                server  stapp02 172.16.238.11:8089 check               are added. 
                server  stapp03 172.16.238.12:8089 check 
            
            #    server  app1 127.0.0.1:5001 check
            #    server  app2 127.0.0.1:5002 check
            #    server  app3 127.0.0.1:5003 check
            #    server  app4 127.0.0.1:5004 check
			
		# For the changes to take effect, restart the HAproxy service.
		
        systemctl status haproxy
        systemctl restart haproxy
        systemctl enable haproxy
        systemctl status haproxy
			
		# After restarting and verifying HAproxy is up and running, I got stuck at solving the wrong problem.
		# I kept doing the curl in the LBR server.
		# I was not also able to access the website on LBR link through the + button on the terminal during my
		# my first attempt.
		
		# I was so focused on this two lines that I didn't notice that I was actually doing the correct steps.
		# I was just doing the incorrect way of verifying it.

        # These was the two steps I was doing - which are wrong.
                
        haproxy -db -f /etc/haproxy/haproxy.cfg
        curl http://localhost:80
			
		# After some tries, I decided to take a break and go out to do some errands in the market.
		# I went back after a few hours and did the lab again but this time check other articles in KKC.
		# And somehow by some miracle, after two attempts, I was able to open the website through the LBR link.
		# But before I did that, I first returned to the jumphost and curl the IP addresses.

#	4.	Return to the jumphost and curl the ip address of each App server - use the port initially noted.

        curl http://172.16.238.14:80
        curl http://172.16.238.10:8089
        curl http://172.16.238.11:8089
        curl http://172.16.238.12:8089
                    
		# All of this curl commands shuld return this output:
		
        thor@jump_host /$ curl http://172.16.238.14:80
        Welcome to xFusionCorp Industries !

        thor@jump_host /$ curl http://172.16.238.10:8089
        Welcome to xFusionCorp Industries !

        thor@jump_host /$ curl http://172.16.238.11:8089
        Welcome to xFusionCorp Industries !

        thor@jump_host /$ curl http://172.16.238.12:8089
        Welcome to xFusionCorp Industries !


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


############################################################################################################

    #########	  #####	 	 ###	###			 #########	  ########		###				   ##
	#########	 #######	 ###	###			 #########	  #########		###				 ###
	###			###	  ###	 ### 	###			 ###		  ###	###		###		 ###	 ###
	###			###	  ###	 ### 	###			 ###		  ###	###		###		 ###    ###
	########	###	  ### 	 ### 	###			 ########	  ###	###		###		 		###
	########	###	  ### 	 ### 	###			 ########  	  ###	###		###				###
	###			#########	 ###	###			 ###		  ###	###		###		 ###	###
	###			######### 	 ###	###			 ###		  ###	###				 ###	 ###
	###		    ###   ###	 ### 	#########	 #########	  #########		###		 		 ###
	###			###   ###	 ###	#########	 #########	  ########		###				   ##
		
############################################################################################################
