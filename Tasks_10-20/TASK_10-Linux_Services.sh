
TASK 10 - Linux Services - 2020-07-08 || 05:27 AM

REQUIREMENT:

As per details shared by the development team, the new application release has some dependencies on the back end. There are some packages/services that need to be installed on all app servers under Stratos Datacenter. As per requirements please perform the following steps:

a. Install httpd package on all the application servers.
b. Once installed, make sure it is enabled to start during boot.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://community.kodekloud.com/t/linux-services-postfix/6982
https://community.kodekloud.com/t/install-postfix-httpd-task-on-all-application-servers/1100
https://community.kodekloud.com/t/linux-services-task-failed-but-i-did-correct/6952
https://community.kodekloud.com/t/task-status-failed-by-the-system/1173
https://serverfault.com/questions/472145/apache-httpd-not-starting-automatically-on-boot
https://geekflare.com/how-to-auto-start-services-on-boot-in-linux/

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

	1.	Install httpd package on all the application servers.
	2.	Once installed, make sure it is enabled to start during boot.

-----------------------------------------------------------------------------------------------------------------

III.	STEPS - BREAKDOWN

#	This one is a bit easy because it just requires installing a service package onto the app servers.
#	The tricky part is that the required package changes everytime I restart the lab. 
#	I had three attempts on this lab because I wanted to redo the lab in the shortest possible time.
#	Each time I redo the lab, i get different packages.
#	The first one was NSCD, then POSTFIX, then finally HTTPD which is the one I'm most familiar of.

#	So, below are the commands I used for this lab.
#	To log in to the three app servers:
sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sshpass -p  '******' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
sshpass -p  '******' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
sshpass -p '******' ssh -o StrictHostKeyChecking=no  peter@172.16.239.10

#	To install httpd and make sure that it'll be enable upon bootup:
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd
sudo systemctl status httpd
systemctl list-unit-files | grep httpd						# this may be optional but is also useful

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



