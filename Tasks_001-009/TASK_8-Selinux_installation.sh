
TASK 8 - Selinux Installation

REQUIREMENT:

The xFusionCorp Industries security team recently did a security audit of their infrastructure and came up with ideas to improve the application and server security. They decided to use SElinux for an additional security layer. They are still planning how they will implement it; however, they have decided to start testing with app servers, so based on the recommendations they have the following requirements:

Install the required packages of SElinux on App server 3 in Stratos Datacenter and disable it permanently for now; it will be enabled after making some required configuration changes on this host. Don't worry about rebooting the server as there is already a reboot scheduled for tonight's maintenance window. Also ignore the status of SElinux command line right now; the final status after reboot should be disabled.


-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://community.kodekloud.com/t/selinux-installation/1013/17
https://community.kodekloud.com/t/selinux-installation-task/1247
https://serverfault.com/questions/999009/rhel-selinux-etc-sysconfig-selinux-or-etc-selinux-config

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

	1.	Connect via SSH to the correct App Server
	2. 	Install Selinux
	3.	Edit the /etc/selinux/config file as ROOT then verify

--------------------------------------------------------------------------------------------------------------------

III.	STEPS - BREAKDOWN

1.	Connect via SSH to the correct App Server	--------------------------------------------------------------------

#	I felt that this was a bit simple task since this just requires installing selinux.
#	However there are some configurations that must be met, so I set out to search the KodeKloud Community.
#	Found two articles where the steps were broken down. 
# 	Of course the first one, which I already know, is to SSH into the correc App Server.

thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
Warning: Permanently added '172.16.238.11' (ECDSA) to the list of known hosts.
[steve@stapp02 ~]$


2. 	Install Selinux		--------------------------------------------------------------------------------------------

#	The next requirement then is to install Linux.
#	Unfortunately I was not able to copy the whole output, just the command

sudo yum install policycoreutils policycoreutils-python selinux-policy selinux-policy-targeted libselinux-utils setroubleshoot-server setools setools-console mcstrans


3.	Edit the /etc/selinux/config file as ROOT	---------------------------------------------------------------------

#	Note that the file was a READ-ONLY file so I was not able to edit it during my first attempt.
#	I added sudo and was able to edit the file.

[steve@stapp02 selinux]$
[steve@stapp02 selinux]$ cat config

# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#     enforcing - SELinux security policy is enforced.
#     permissive - SELinux prints warnings instead of enforcing.
#     disabled - No SELinux policy is loaded.
SELINUX=enforcing													#	Change this to DISABLED
# SELINUXTYPE= can take one of three values:
#     targeted - Targeted processes are protected,
#     minimum - Modification of targeted policy. Only selected processes are protected.
#     mls - Multi Level Security protection.
SELINUXTYPE=targeted

[steve@stapp02 selinux]$ sudo vi config								#	Can only edit a R.O. file through ROOT
[sudo] password for steve:
[steve@stapp02 selinux]$
[steve@stapp02 selinux]$
[steve@stapp02 selinux]$ getenforce									#	GETENFORCE is similar with SESTATUS 
							
Disabled
[steve@stapp02 selinux]$ sestatus
SELinux status:                 disabled
[steve@stapp02 selinux]$ cat config

# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#     enforcing - SELinux security policy is enforced.
#     permissive - SELinux prints warnings instead of enforcing.
#     disabled - No SELinux policy is loaded.
SELINUX=disabled													#	Changed.
# SELINUXTYPE= can take one of three values:
#     targeted - Targeted processes are protected,
#     minimum - Modification of targeted policy. Only selected processes are protected.
#     mls - Multi Level Security protection.
SELINUXTYPE=targeted


#	FINAL NOTE
#	No need to reboot the server. 
#	The required App server ma change as you redo the lab. Make sure to read carefully.

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


