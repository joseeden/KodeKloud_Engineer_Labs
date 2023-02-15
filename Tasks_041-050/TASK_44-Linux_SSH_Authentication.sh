
-----------------------------------------------------------------------------------------------------------------

Start			2020-10-25 || 09:35 PMM
Finished		2020-10-25 || 09:52 PM

-----------------------------------------------------------------------------------------------------------------

TASK 44 - Linux SSH Authentication

*This was actually a return-task as the first time I got this task, I was not able to solve it in time and it 
expired. This was Task 3.

REQUIREMENTS:

The system admins team of xFusionCorp Industries has set up some scripts on jump host that run on regular intervals and perform operations on all app servers in Stratos Datacenter. To make these scripts work properly we need to make sure thor user on jump host has password-less SSH access to all app servers through their respective sudo users. Based on the requirements, perform the following:

Set up a password-less authentication from user thor on jump host to all app servers through their respective sudo users.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://community.kodekloud.com/t/linux-ssh-authentication-failed/6544/3
https://community.kodekloud.com/t/linux-ssh-authentication-not-passed/3526/5

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

#	1.	Generate ssh-keygen in jumphost. It will be saved in the .ssh directory.
#	2.	Copy the id_rsa into all the three app servers.
#	3.	Verify that each app server's uer is able to ssh into it's respective app server without
#		entering the password

-----------------------------------------------------------------------------------------------------------------

III.	STEPS - BREAKDOWN

#	1.	Generate ssh-keygen in jumphost. It will be saved in the .ssh directory.

		ssh-keygen -t rsa -b 4096
		ll /home/thor/.ssh
		
			total 8
			-rw------- 1 thor thor 3243 Oct 25 13:48 id_rsa
			-rw-r--r-- 1 thor thor  764 Oct 25 13:48 id_rsa.pub
		
#	2.	Copy the id_rsa into all the three app servers.

		ssh-copy-id tony@stapp01
		ssh-copy-id steve@stapp02
		ssh-copy-id banner@stapp03

#	3.	Verify that each app server's uer is able to ssh into it's respective app server without
#		entering the password

		ssh tony@stapp01
		ssh steve@stapp02
		ssh banner@stapp03

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


