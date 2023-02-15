
-----------------------------------------------------------------------------------------------------------------

Start		2020-07-12 || 03:19 PM
Finished	2020-07-12 || 03:38 PM

-----------------------------------------------------------------------------------------------------------------

TASK 13 - Linux User Expiry

REQUIREMENT:

A developer John has been assigned Nautilus project temporarily as a backup resource. As a temporary resource for this project, we need a temporary user for John. It’s a good idea to create a user with a set expiration date so that the user will not be able to access servers beyond that point.

Therefore, create a user named john on the App Server 1. Set expiry date to 2021-12-07 in Stratos Datacenter. Make sure the user is created as per standard and is in lowercase.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

#	This has been a veru useful resource. I've used in the previous labs, regarding anythng about creating/modifying
#	a user in linux machine

https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/#:~:text=known%20as%20GECOS%20.-,Creating%20a%20User%20with%20an%20Expiry%20Date,YYYY%2DMM%2DDD%20format.

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

	1.	Connect via SSH to the correct App Server
	2.	Create the user with an option to set expiry date (using ROOT).
	3.	Verify.

-----------------------------------------------------------------------------------------------------------------

III.	COMMANDS USED

sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo useradd -e 2021-12-07 john 
sudo chage -l john 

-----------------------------------------------------------------------------------------------------------------

IV.	STEPS - BREAKDOWN

#	This is again one of the easiest task. I just had two attempt; the first one where I slowly do the
#	steps and then verify using resources in KKC and in the internet.

#	1.	Connect via SSH to the correct App Server
thor@jump_host /$thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
Warning: Permanently added '172.16.238.10' (ECDSA) to the list of known hosts.
[tony@stapp01 ~]$

#	2.	Create the user with an option to set expiry date (using ROOT).
[tony@stapp01 ~]$ sudo useradd -e 2021-12-07 john

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for tony:

#	3.	Verify.
[tony@stapp01 ~]$[tony@stapp01 ~]$ sudo chage -l john
Last password change                                    : Jul 12, 2020
Password expires                                        : never
Password inactive                                       : never
Account expires                                         : Dec 07, 2021
Minimum number of days between password change          : 0
Maximum number of days between password change          : 99999
Number of days of warning before password expires       : 7
[tony@stapp01 ~]$

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


