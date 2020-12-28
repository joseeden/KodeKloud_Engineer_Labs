
-----------------------------------------------------------------------------------------------------------------

Start			WAS NOT ABLE TO RECORD TIME
Finished		2020-08-07 || 02:01 AM

-----------------------------------------------------------------------------------------------------------------

TASK 30 - Install a package - git

REQUIREMENTS:

As per new application requirements shared by the Nautilus project development team, serveral new packages need to be installed on all app servers in Stratos Datacenter. Most of them are completed except for vsftpd.

Therefore, install the git package on all app-servers.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://www.digitalocean.com/community/tutorials/how-to-install-git-on-centos-7

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

#	1. Connect to each App server and switch to root
#	2. Install git. Verify.

-----------------------------------------------------------------------------------------------------------------

III.	COMMANDS USED

#	1. Connect to each App server and switch to root

			sshpass -p  'Ir0nM@n' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
			sudo su -
			Ir0nM@n
			sshpass -p  'Am3ric@' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
			sudo su -
			Am3ric@
			sshpass -p  'BigGr33n' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
			sudo su -
			BigGr33n
			
#	2. Install git. Verify.

			sudo yum install git -y
			git --version
			sudo yum list installed | grep git

-----------------------------------------------------------------------------------------------------------------

IV.	STEPS - BREAKDOWN

#	Since the installation was done on all App servers, I decided to put the scrapes of each in their
#	own file. These three files are added as supporting files for Task 30

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

