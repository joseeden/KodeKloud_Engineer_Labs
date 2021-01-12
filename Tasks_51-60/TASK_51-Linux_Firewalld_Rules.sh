
-----------------------------------------------------------------------------------------------------------------

Start			2020-11-23 09:09:47
Finished		2020-11-23 09:20:52	

-----------------------------------------------------------------------------------------------------------------

TASK_51-Linux_Firewalld_Rules

** This is a Repeat task. This was Task 19 and was complete last 2020-07-19 

REQUIREMENT:

The Nautilus system admins team recently deployed a web UI application for their backup utility running on the Nautilus backup server in Stratos Datacenter. The application is running on port 8084. They have firewalld installed on that server. The requirements that have come up include the following:

Open all incoming connection on 8084/tcp port. Zone should be public.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://community.kodekloud.com/t/task-1-linux-firewalld-rules/1716/8
https://community.kodekloud.com/t/linux-firewalld-setup-failed-again/4533

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

#	1.	SSH into the Backup Server and switch to root.
#   2.  Check status of firewalld and the available options.
#   3.	Add <port id>/protocol and reload.
#   4.  Verify.

-----------------------------------------------------------------------------------------------------------------

III.	STEPS - BREAKDOWN

#	1.	SSH into the Backup Server and switch to root.

        sshpass -p '******' ssh -o StrictHostKeyChecking=no  clint@172.16.238.16
        sudo su -
        ******

# 	2.	Check status of firewalld and the available options
        # Now for this one, since I try to check first the available options in the man pages 
        # before checking out
        # KKC articles for the correct steps, I used --help.
        # Then I checked the KKC where I saw multiple articles.

        firewall-cmd --help
        sudo firewall-cmd --zone=public --list-all							
        # lists config for firewall

#	3.	Add <port id>/protocol and reload

        sudo firewall-cmd --zone=public --permanent --add-port=8084/tcp
        firewall-cmd --help | grep reload									

        # tried to searchn correct option on how to reload

        sudo firewall-cmd --reload												
																	
#	4.  Verify.
        
        sudo firewall-cmd --zone=public --list-all

        # An additional way to verify is to check the httpd.conf file. This will show the port

        grep Listen /etc/httpd/conf/httpd.conf

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
