
-----------------------------------------------------------------------------------------------------------------

Start		2020-07-11 || 01:13 PM
Finished	2020-07-11 || 01:16 PM

-----------------------------------------------------------------------------------------------------------------

TASK 12 - Linux User Without Home

REQUIREMENT:

The system admins team of xFusionCorp Industries has set up a new tool on all app servers, as they have a requirement to create a service user account that will be used by that tool. They are finished with all apps except for App 1 in Stratos Datacenter.

Create a user named kareem in App Server 1 without a home directory.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://community.kodekloud.com/t/task-linux-user-without-home/1123
https://askubuntu.com/questions/29359/how-to-add-a-user-without-home

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

	1.	Connect via SSH to the correct App server.
	2.	Create a user with an option -- "no home"
	3.	Verify

-----------------------------------------------------------------------------------------------------------------

III.	COMMANDS USED

sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo useradd -M kareem
ls  -l /home

-----------------------------------------------------------------------------------------------------------------

IV.	STEPS - BREAKDOWN

#	This one's fairly easy, though I still searched the KKC just to confirm that the step/s I have in 
#	mind is correct. I've also read before that there was an option that we could use along with the
#	'useradd' command where we can specify for the new user to have no home directory


#	1.	Connect via SSH to the correct App server.

thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
Warning: Permanently added '172.16.238.10' (ECDSA) to the list of known hosts.[tony@stapp01 ~]$


#	2.	Create a user with an option -- "no home"
[tony@stapp01 ~]$ sudo useradd -M kareem

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for tony:


#	3.	Verify
[tony@stapp01 ~]$[tony@stapp01 ~]$ ls -l /home/user
ls: cannot access /home/user: No such file or directory
[tony@stapp01 ~]$
[tony@stapp01 ~]$ ls -l /home
total 8
drwx------ 2 ansible ansible 4096 Oct 15  2019 ansible
drwx------ 2 tony    tony    4096 Jan 25 06:18 tony
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


