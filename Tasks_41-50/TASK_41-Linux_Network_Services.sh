
-----------------------------------------------------------------------------------------------------------------

Start			2020-09-14 || 11:35 PM	
Finished		2020-09-15 || 01:32 AM

-----------------------------------------------------------------------------------------------------------------

TASK 41 - Linux Network Services

REQUIREMENTS:

Our monitoring tool has reported an issue in Stratos Datacenter. One of our app servers has an issue, as its Apache service is 
not reachable on port6400 (which is our Apache port). The service itself could be down, the firewall could be at fault, or 
something else could be causing the issue.

Use tools like telnet, netstat, etc. to find and fix the issue. Also make sure Apache is reachable from the jump host without 
compromising any security settings.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://community.kodekloud.com/t/issue-with-linux-network-services-task/8696
https://community.kodekloud.com/t/linux-networks-task-failed/11145/4
https://community.kodekloud.com/t/linux-network-services-apache-not-running-on-app1-port-8081/5891/8
https://community.kodekloud.com/t/linux-network-services-task/7003/2
https://community.kodekloud.com/t/linux-network-service/6520/2

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

#	1.	SSH into the jump server, App server 1, App server 2, and App server 3 and switch 
#		to root. Check if the httpd is working in all App servers.
#	2.	One of the App Servers has an issue with the HTTPD. Check what might be wrong on the configuration
#		or the App Server. In this case, check the processes.
#	3.	Check the iptables as well and ensure that traffic to the specified port is allowed.
#		Append rules and make sure it is placed at the top of iptables. Save the iptables.
#	4.	From jump server, try to telnet onto the App Server 1.
#		Also try to curl.

-----------------------------------------------------------------------------------------------------------------

III.	STEPS - BREAKDOWN

#	1.	SSH into the jump server, App server 1, App server 2, and App server 3 and switch 
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

#	2.	One of the App Servers has an issue with the HTTPD. Check what might be wrong on the configuration
#		or the App Server. In this case, check the processes.

			systemctl enable httpd			# Apache is functioning in the App servers except App Server 1
			systemctl start httpd
			systemctl status httpd	
			
		# Check the processes using netstat. Here we can see that a process is using the Apache port specified - 5003
		# Kill the process and then restart and verify status of httd. It should be working now.
		
			netstat -tulpn
			netstat -tulpn | grep 5003
			sudo kill -9 291

			systemctl enable httpd
			systemctl start httpd
			systemctl status httpd

#	3.	Check the iptables as well and ensure that traffic to the specified port is allowed.
#		Append rules and make sure it is placed at the top of iptables. Save the iptables.

			iptables -L
			iptables -L INPUT -nv

			iptables -I	INPUT -p tcp --destination-port 5003 -j ACCEPT
			service iptables save 

			systemctl enable iptables
			systemctl start iptables
			systemctl status iptables

#	4.	From jump server, try to telnet onto the App Server 1.
#		Also try to curl.

			telnet stapp01 5003
			telnet 172.16.238.10 5003
			curl stapp01:5003
			

#	ENOTE:
#	Now I actually spent a chunk of time on the last part where I need to telnet from the jump server
#	onto the App server 1.

#	I was already able to curl the App server 1 from the jump host but I just can't seem to
#	establish a telnet connection.

#	I've gone over all the KKC articles about this specific lab and I have followed every steps that
#	are suggested in thos articles but I still can't telnet from the jumphost onto the App server 1.

#	At last, I told myself and hoped that this should perhaps be a backend issue on the KK's end
#	and just hit finish. 

#	"SUCCESS"

#	Although it shows success and I gained the experience points for this lab,
#	I still can't shake the feeling that I must have done somethign wrong on the config because
#	I was not able to telnet.

#	Well, what the heck. 


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


