
-----------------------------------------------------------------------------------------------------------------

Start			2020-11-27 01:09:48
Finished		2020-11-27 01:14:21	

-----------------------------------------------------------------------------------------------------------------

TASK_53-Create_a_Linux_User_with_non-interactive_shell

** This is a repeat task. This was Task 1, which was my first task here in KodeKloud.
** Came in last 26-Jun-2020, but was not able to solve in time. so it expired.

** This was Task 47, came in last 06-Nov-2020, and was able to completely.
** I\'ll be following the same steps I did in Task 47.

REQUIREMENTS:

The System admin team of xFusionCorp Industries has installed a backup agent tool on all app servers. As per the tool requirements they need to create a user with a non-interactive shell.

Therefore, create a user named mark with a non-interactive shell in the app01 server.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

TASK 47 - Create a Linux User with non-interactive shell.sh
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

        sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
        sudo su -
        ******     

#	2.	Add the required user and modify shell intonon-interactice shell.
#		Vefify afterwards.

        sudo adduser mark
        sudo usermod -s /sbin/nologin mark
        grep -i mark /etc/passwd


## Since it's a short lab, I opt to include the scrapes here instead of putting it in a seaprate SuppotFile.
## For the complete scrapes, see below:


thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
Warning: Permanently added '172.16.238.10' (ECDSA) to the list of known hosts.sudo su -******[tony@stapp01 ~]$ sudo su -

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for tony:
[root@stapp01 ~]#
[root@stapp01 ~]# sudo adduser mark
[root@stapp01 ~]# sudo usermod -s /sbin/nologin mark
[root@stapp01 ~]# grep -i mark /etc/passwd
mark:x:1002:1002::/home/mark:/sbin/nologin[root@stapp01 ~]# Connection to host01 closed by remote host.
Connection to host01 closed.

The environment has expired.

Please refresh to get a new environment.

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
