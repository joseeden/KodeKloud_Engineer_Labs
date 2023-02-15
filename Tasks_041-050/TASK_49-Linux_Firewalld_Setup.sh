
-----------------------------------------------------------------------------------------------------------------

Start			2020-11-15 02:37:54
Finished		2020-11-15 03:17:00

-----------------------------------------------------------------------------------------------------------------

TASK 49 - Linux Firewalld Setup

** This is another repeat task - my third repeat task so far. 
** This was also my last task before I took a month-long hiatus to prepare for the SAA-C02.
** Fortunately, I passed the AWS Solutions Architect exam. Noice.

** I might raise this up in the KKC Forum if I get another 2 more repeated task.
** This was Task 33, finished last 2020-08-11.
** I just copied the same texts here.

REQUIREMENTS:

To secure our Nautilus infrastructure in Stratos Datacenter we have decided to install and configure firewalld on all app servers. We have Apache and Nginx services running on these apps. Nginx is running as a reverse proxy server for Apache. We might have more robust firewall settings in the future, but for now we have decided to go with the given requirements listed below:

a. Allow all incoming connections on Nginx port.

b. Allow incoming connections from LB host only on Apache port and block for all others.

c. All rules must be permanent.

d. Zone should be public.

e. If Apache or Nginx services are not running already, please make sure to start them.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

Task 33 - Linux Firewalld Setup.sh
https://community.kodekloud.com/t/linux-firewalld-setup-failed-again/4533/13
https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-using-firewalld-on-centos-7
https://community.kodekloud.com/t/linux-firewalld-setup-task-failed/2358/11
https://firewalld.org/documentation/man-pages/firewalld.richlanguage.html
https://community.kodekloud.com/t/linux-firewalld-setup-may-30/6059/3

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

#	1.	SSH into the jump server, Storage Server, App server 1, App server 2, and App server 3 and switch 
#		to root.
#	1.	Connect via SSH to each App server and install firewalld. Enable, start it, and then verify.
#		Also check for nginx port and http port for each.
#	2.	Add the necessary firewalld rules, along with the rich rules. Reload firewalld and then verify status.
#		Also verify status of httpd and nginx service for each App server.
#	3.  Test from the LBR server if it's able to curl the ip address of all App server using the nginx port 
#		and httpd ports.

-----------------------------------------------------------------------------------------------------------------

III.	STEPS - BREAKDOWN


#	1.	Connect via SSH to each App server and install firewalld. Enable, start it, and then verify.
#		Also check for nginx port and http port for each.

		# I always switch to root user upon login since it simplifies the succeeding tasks 
		# It's much easier to just enter password once and then run all the commands.
		
        sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
        sudo su -
        ******

        sshpass -p  '******' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
        sudo su -
        ******

        sshpass -p  '******' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
        sudo su -
        ******

		# Note that all commands from here on forward are run on each App server unless specified to run
		# on LBR server only.
		
		# Install firewalld and then start it. Enable it and then verify that it is up and running.
		
        yum install firewalld -y

        systemctl start firewalld 
        systemctl enable firewalld
        systemctl status firewalld
			
		# Now I did try this lab multiple times and the firewalld does not always boot up immeidately and
		# sometimes a 'DB error' appears. To resolve this, I just need to issue the following command
		# and then verify status of the firewalld service again.
		
        sudo systemctl restart dbus
        sudo systemctl restart firewalld
        systemctl status firewalld

		# Check the nginx port and httpd port.
        
        cat /etc/nginx/nginx.conf | grep listen		        # Port 8097			
        cat /etc/httpd/conf/httpd.conf | grep Listen		# Port 3003			    

#	2.	Add the necessary firewalld rules, along with the rich rules. Reload firewalld and then verify status.
#		Also verify status of httpd and nginx service for each App server.

		# This is the part where I got stucked. I thought I was missing something when I was trying to
		# test using NGINX port.

        # NGINX port = 8097

        firewall-cmd --permanent --zone=public --change-interface=eth0
        firewall-cmd --permanent --zone=public --add-port=8097/tcp				
        firewall-cmd --permanent --zone=public --add-service=http
        firewall-cmd --permanent --zone=public --add-service=https
        firewall-cmd --permanent --zone=public \
        --add-rich-rule='rule family="ipv4" source address="172.16.238.14" port port=3003 protocol=tcp accept'
			
		# FOr the changes to take effect, the firewalld service must be reloaded.
		
        sudo firewall-cmd --reload
        systemctl restart firewalld
        systemctl status firewalld

		# Once firewalld is back, verify status and the nginx and httpd ports.
		# Also check if the updates are reflected after rebooting.

        systemctl status nginx 
        systemctl status httpd

        firewall-cmd --get-active-zones
        firewall-cmd --zone=public --list-all

#	3.  Test from the LBR server if it's able to curl the ip address of all App server using the nginx port 
#		and httpd ports.

		# I initially tested both from LBR server and jumphost but I found that testing from the LBR server
		# is enough.
		
        sshpass -p '******' ssh -o StrictHostKeyChecking=no  loki@172.16.238.14       
			
		# I actually got stucked here because whenever I try to curl for all the App server using the NGINX port, I always get a 'Forbidden 503' error just like this:
            
            <html>
            <head><title>403 Forbidden</title></head>
            <body>
            <center><h1>403 Forbidden</h1></center>
            <hr><center>nginx/1.16.1</center>
            </body>
            </html>
                
		# Turns out, that was actually the real HTTP page for nginx port!
		# I only discovered this when I tried to curl on the App server themselves through their localhost.
		# I still get the same 'error' page!
		
        curl localhost:8097
		
		# So I proceeded to curl for all App Servers from the LBR server.
		# For the HTTP connecttions through NGINX port:
		
        curl stapp01:8097
        curl stapp02:8097
        curl stapp03:8097

		# For the HTTP connecttions through APACHE port:

        curl stapp01:3003
        curl stapp02:3003
        curl stapp03:3003
			
		# For the curl commands using the apache port, it should return a series of HTML commands for the page.
			
            <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"><html><head>
			<meta http-equiv="content-type" content="text/html; charset=UTF-8">
							<title>Apache HTTP Server Test Page powered by CentOS</title>
							<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
				
				........................................................
				
				<div class="jumbotron text-center">
					<div class="container">
						  <h1>Testing 123..</h1>
								<p class="lead">This page is used to test the proper operation of the <a href="http://apache.org">Apache HTTP server</a> after it has been installed. If you can read this pageit means that this site is working properly. This server is powered by <a href="http://centos.org">CentOS</a>.</p>
								</div>
				  </div>
				
				........................................................
				
				
		# I have attached the scrapes for all App servers as SupportFIle here.

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
