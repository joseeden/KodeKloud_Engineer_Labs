

-----------------------------------------------------------------------------------------------------------------

Start			2020-11-06 || 06:30 PM
Finished		2020-11-06 || 07:00 PM

-----------------------------------------------------------------------------------------------------------------

TASK 47 - Create a Linux User with non-interactive shell

REQUIREMENTS:

** This was a repeatetd task and my very first task here in KodeKloud.
** It expired last June 26, 2020

The System admin team of xFusionCorp Industries has installed a backup agent tool on all app servers. As per the tool requirements they need to create a user with a non-interactive shell.

Therefore, create a user named ammar with a non-interactive shell in the app02 server.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://community.kodekloud.com/t/create-a-linux-user-with-non-interactive-shell/3367
https://tldp.org/LDP/abs/html/intandnonint.html
https://unix.stackexchange.com/questions/4676/creating-a-user-who-cannot-get-an-interactive-shell

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

#	1.	SSH into App server 3 and switch to root.
#	2.	Add the required user and modify shell intonon-interactice shell.
#		Vefify afterwards.

## For further details on interactive and non0interactive shells, please see references section.

-----------------------------------------------------------------------------------------------------------------

III.	STEPS - BREAKDOWN

#	1.	SSH into App server 3 and switch to root.

		sshpass -p  '******' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
		sudo su -
		******

#	2.	Add the required user and modify shell intonon-interactice shell.
#		Vefify afterwards.

		sudo adduser username
		sudo usermod -s /sbin/nologin username
		grep -i username /etc/passwd


## Since it's a short lab, I opt to include the scrapes here instead of putting it in a seaprate SuppotFile.
## For the complete scrapes, see below:


thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no banner@172.16.238.12Warning: Permanently added '172.16.238.12' (ECDSA) to the list of known hosts.
sudo su -
******[banner@stapp03 ~]$ sudo su -

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for banner:
[root@stapp03 ~]#
[root@stapp03 ~]# sudo useradd javed[root@stapp03 ~]# sudo usermod -s /sbin/nologin javed
[root@stapp03 ~]# grep -i javed /etc/passwd
javed:x:1002:1002::/home/javed:/sbin/nologin
[root@stapp03 ~]#
[root@stapp03 ~]#

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


