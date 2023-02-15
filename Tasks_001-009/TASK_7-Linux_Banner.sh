
TASK 7 - Linux banner

During the monthly compliance meeting, it was pointed out that several servers in the Stratos DC do not have a valid banner. The security team has provided serveral approved templates which should be applied to the servers to maintain compliance. These will be displayed to the user upon a successful login.

Update the message of the day on all application and db servers for Nautilus. Make use of the approved template located at /root/nautilus_banner on jump host

-----------------------------------------------------------------------------------------------------------------

REFERENCE:
https://community.kodekloud.com/t/incorrect-feedback-on-the-banner-question/1072/31
https://community.kodekloud.com/t/linux-banner-task-exercise-help/3206/12

-----------------------------------------------------------------------------------------------------------------

# BANNER - Looks like this

################################################################################################
  .__   __.      ___      __    __  .___________. __   __       __    __       _______.        #
       |  \ |  |     /   \    |  |  |  | |           ||  | |  |     |  |  |  |     /       |   #
       |   \|  |    /  ^  \   |  |  |  | `---|  |----`|  | |  |     |  |  |  |    |   (----   #
       |  . `  |   /  /_\  \  |  |  |  |     |  |     |  | |  |     |  |  |  |     \   \       #
       |  |\   |  /  _____  \ |  `--'  |     |  |     |  | |  `----.|  `--'  | .----)   |      #
       |__| \__| /__/     \__\ \______/      |__|     |__| |_______| \______/  |_______/       #
                                                                                               #
                                                                                               #
                                                                                               #
                                                                                               #
                                 # #  ( )                                                      #
                                  ___#_#___|__                                                 #
                              _  |____________|  _                                             #
                       _=====| | |            | | |==== _                                      #
                 =====| |.---------------------------. | |====                                 #
   <--------------------'   .  .  .  .  .  .  .  .   '--------------/                          #
     \                                                             /                           #
      \_______________________________________________WWS_________/                            #
  wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww                        #
wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww                       #
   wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww                         #
                                                                                               #
                                                                                               #
################################################################################################
Warning! All Nautilus systems are monitored and audited. Logoff immediately if you are not authorized!

-----------------------------------------------------------------------------------------------------------------

# So I first started this lab with a different understandign of the requirement. I easily found the banner template the /root directory in the jump server. My initial understanding was to copy this file -- so I literally copied the contents of this file (which is the one you see above) and went to the first app server, go to the approriate folder, find the motd file, and paste the contents inside that file using vim. 

# Unfortunately, it was not actually that easy. When I tried that, I encounter some permissions issue which again I thoughh could be simply resolved by changing the permissions of the motd file.

# Needless to say, I was going on the wrong trail at first. I believed I have attempted this lab four times, and the third attempt was when I actually understood what should be done. I ran out of time durng my thrid trial so I retried for a fourth time, tested that everything is working as expected, and managed to do the lab
# in less than 20 minutes.

# I have to note also that I learned something new on the CLI of KodeKloud. You can actually retry the lab many times for two days, as long as you don't hit finish.
# You have two options - Hit "Finish" or Hit "Try again Later".
# When you choose "Finish", the whole lab stops and regardless if you've done the lab correctly or not, you would not be able to redo that lab again. So hitting "Finish" wouuld mean its either you have "Succeed" or you "Failed".

# When you choose "Try again Later", the task is put in "Pending" state and you're free to redo the lab for two days before it expires entirely.

-----------------------------------------------------------------------------------------------------------------

# So the correct method here is:

# 	1.	Copy the nautilus_banner template from the jump server to the app server and db server.
#		This can be done by using scp to copy/move files remotely.
#		Now the template is currently located in the jump server's /root directory and must be copied to the 
#		/etc/motd folder of the four server.
#		However, the jump server doesn't seem to have permissions on the four servers' /etc/motd folder so 
#		So what can be done is to just copy the file into any folder if the four servers.
#		Then once template file is copied into the four servers, login to each on of those four and just copy 
#		that file into the /etc/motd file.
#		Of course I did not thought of this by myself. I got the idea form two resources from the KKC.
# 		The links are below:

#		https://community.kodekloud.com/t/incorrect-feedback-on-the-banner-question/1072/31
#		https://community.kodekloud.com/t/linux-banner-task-exercise-help/3206/12


#	2.	ENABLE SCP ON THE JUMP SERVER.
#		So I'm actually entirely new to SCP but I thinked I've understand it from the resources cited above.
#		So I first enabled scp on the jump server-thor

thor@jump_host /$ sudo yum install -y openssh-clients

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.
[sudo] password for thor:
Loaded plugins: fastestmirror, ovl
Determining fastest mirrors


#	3. 	SCP-COPY FILES FROM /root TO /tmp
#		And then once scp is enabled proceed with copying files from /root of the jump server into a temporary #	   folder. For this one I simply copied from jump server's /root into the four servers' /tmp

# Copying into App Server 1
thor@jump_host /$ sudo scp -r /root/nautilus_banner tony@172.16.238.10:/tmp
The authenticity of host '172.16.238.10 (172.16.238.10)' can't be established.
ECDSA key fingerprint is SHA256:4M51OkqmeQgf61ba+AZpjopFc5umBXS7exqeqlAl/HI.
ECDSA key fingerprint is MD5:c1:2d:2e:8e:8f:d5:bd:7b:93:99:a9:27:00:1f:41:34.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '172.16.238.10' (ECDSA) to the list of known hosts.
tony@172.16.238.10's password:
nautilus_banner                                               100% 2531     1.1MB/s   00:00
thor@jump_host /$

# Copying into App Server 2
thor@jump_host /$ sudo scp -r /root/nautilus_banner steve@172.16.238.11:/tmp
The authenticity of host '172.16.238.11 (172.16.238.11)' can't be established.
ECDSA key fingerprint is SHA256:GnVuag5f4aBMy6ZI1pOc/Y43Cx2zKup5g8xXnETYz3s.
ECDSA key fingerprint is MD5:56:06:a5:1d:03:50:70:57:96:c9:31:73:92:dd:45:2a.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '172.16.238.11' (ECDSA) to the list of known hosts.
steve@172.16.238.11's password:
nautilus_banner                                               100% 2531     3.5MB/s   00:00
thor@jump_host /$

# Copying into App Server 3
thor@jump_host /$ sudo scp -r /root/nautilus_banner banner@172.16.238.12:/tmp
The authenticity of host '172.16.238.12 (172.16.238.12)' can't be established.
ECDSA key fingerprint is SHA256:WomAql/58vKk4xzzM3oHET4xjI5SmowtP9G9p0C+Xc4.
ECDSA key fingerprint is MD5:dd:56:c0:b6:72:7a:dd:37:37:97:9c:bb:13:a3:df:06.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '172.16.238.12' (ECDSA) to the list of known hosts.
banner@172.16.238.12's password:
nautilus_banner                                               100% 2531     3.2MB/s   00:00
thor@jump_host /$ 

# Copying into DB Server
The authenticity of host '172.16.239.10 (172.16.239.10)' can't be established.
ECDSA key fingerprint is SHA256:hGiRnBwZ9cqHlFhuOZCJ32Vudf/U6jiztUhgmXIoKhw.
ECDSA key fingerprint is MD5:51:75:9f:6d:a5:03:ed:6a:4c:c9:23:33:04:4b:bb:55.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '172.16.239.10' (ECDSA) to the list of known hosts.
peter@172.16.239.10's password:
bash: scp: command not found			# So here I actually encountered an error
lost connection
thor@jump_host /$

# Thinking that SCP might not be enabled or may not be installed properly in the
# DB server, I SSH into the db server and do the needful.
thor@jump_host /$ sshpass -p '******' ssh -o StrictHostKeyChecking=no  peter@172.16.239.10
Warning: Permanently added '172.16.239.10' (ECDSA) to the list of known hosts.
[peter@stdb01 ~]$
[peter@stdb01 ~]$ sudo yum install -y openssh-clients

# I then went back to jump server again and retried copying the template file into the
# DB server. It worked!
thor@jump_host /$
thor@jump_host /$ sudo scp -r /root/nautilus_banner peter@172.16.239.10:/tmp
peter@172.16.239.10 password:
nautilus_banner                                               100% 2531     5.3MB/s   00:00
thor@jump_host /$
thor@jump_host /$


#	4.	GO INTO EACH OF THE FOUR SERVER AND COPY FILE TO /etc/mot
#		Since each server already has a copy of the template file in its directory, 
#		we just need to move or copy this file into the correct /etc/motd

# Summary - Log into each of the three App server and DB server
sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sshpass -p  '******' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
sshpass -p  '******' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
sshpass -p '******' ssh -o StrictHostKeyChecking=no  peter@172.16.239.10

# Breakdown - Log into each of the three App server and DB server

# Logging into App Server 1 
thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
Warning: Permanently added '172.16.238.10' (ECDSA) to the list of known hosts.
[tony@stapp01 ~]$
[tony@stapp01 ~]$ cd /tmp
[tony@stapp01 tmp]$ ls -l
total 8
-rwx------ 39 root root  836 Aug  1  2019 ks-script-rnBCJB
-rw-r--r--  1 tony tony 2531 Jul  3 22:12 nautilus_banner
-rw------- 39 root root    0 Aug  1  2019 yum.log
[tony@stapp01 tmp]$
[tony@stapp01 tmp]$ ls -l /etc/motd
-rw-r--r-- 39 root root 0 Jun  7  2013 /etc/motd
[tony@stapp01 tmp]$
[tony@stapp01 tmp]$ sudo mv nautilus_banner  /etc/motd

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for tony:
[tony@stapp01 tmp]$
[tony@stapp01 tmp]$ cat /etc/motd
################################################################################################
  .__   __.      ___      __    __  .___________. __   __       __    __       _______.        #
       |  \ |  |     /   \    |  |  |  | |           ||  | |  |     |  |  |  |     /       |   #
       |   \|  |    /  ^  \   |  |  |  | `---|  |----`|  | |  |     |  |  |  |    |   (----    #
       |  . `  |   /  /_\  \  |  |  |  |     |  |     |  | |  |     |  |  |  |     \   \       #
       |  |\   |  /  _____  \ |  `--'  |     |  |     |  | |  `----.|  `--'  | .----)   |      #
       |__| \__| /__/     \__\ \______/      |__|     |__| |_______| \______/  |_______/       #
                                                                                               #
                                                                                               #
                                                                                               #
                                                                                               #
                                 # #  ( )                                                      #
                                  ___#_#___|__                                                 #
                              _  |____________|  _                                             #
                       _=====| | |            | | |==== _                                      #
                 =====| |.---------------------------. | |====                                 #
   <--------------------'   .  .  .  .  .  .  .  .   '--------------/                          #
     \                                                             /                           #
      \_______________________________________________WWS_________/                            #
  wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww                        #
wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww                       #
   wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww                         #
                                                                                               #
                                                                                               #
################################################################################################'
Warning! All Nautilus systems are monitored and audited. Logoff immediately if you are not authorized!

[tony@stapp01 tmp]$
[tony@stapp01 tmp]$ exit
logout
Connection to 172.16.238.11 closed.


# Logging into App Server 2
thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
Warning: Permanently added '172.16.238.11' (ECDSA) to the list of known hosts.
[steve@stapp02 ~]$
[steve@stapp02 ~]$ cd /tmp
[steve@stapp02 tmp]$ ls -l
total 8
-rwx------ 39 root  root   836 Aug  1  2019 ks-script-rnBCJB
-rw-r--r--  1 steve steve 2531 Jul  3 22:11 nautilus_banner
-rw------- 39 root  root     0 Aug  1  2019 yum.log
[steve@stapp02 tmp]$
[steve@stapp02 tmp]$ ls -l /etc/motd
-rw-r--r-- 39 root root 0 Jun  7  2013 /etc/motd
[steve@stapp02 tmp]$
[steve@stapp02 tmp]$ sudo mv nautilus_banner /etc/motd

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for steve:
[steve@stapp02 tmp]$
[steve@stapp02 tmp]$ cat /etc/motd
################################################################################################
  .__   __.      ___      __    __  .___________. __   __       __    __       _______.        #
       |  \ |  |     /   \    |  |  |  | |           ||  | |  |     |  |  |  |     /       |   #
       |   \|  |    /  ^  \   |  |  |  | `---|  |----`|  | |  |     |  |  |  |    |   (----    #
       |  . `  |   /  /_\  \  |  |  |  |     |  |     |  | |  |     |  |  |  |     \   \       #
       |  |\   |  /  _____  \ |  `--'  |     |  |     |  | |  `----.|  `--'  | .----)   |      #
       |__| \__| /__/     \__\ \______/      |__|     |__| |_______| \______/  |_______/       #
                                                                                               #
                                                                                               #
                                                                                               #
                                                                                               #
                                 # #  ( )                                                      #
                                  ___#_#___|__                                                 #
                              _  |____________|  _                                             #
                       _=====| | |            | | |==== _                                      #
                 =====| |.---------------------------. | |====                                 #
   <--------------------'   .  .  .  .  .  .  .  .   '--------------/                          #
     \                                                             /                           #
      \_______________________________________________WWS_________/                            #
  wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww                        #
wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww                       #
   wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww                         #
                                                                                               #
                                                                                               #
################################################################################################
Warning! All Nautilus systems are monitored and audited. Logoff immediately if you are not authorized!
[steve@stapp02 tmp]$ exit
logout
Connection to 172.16.238.11 closed.


# Logging into App Server 3
[banner@stapp03 tmp]$ sudo mv nautilus_banner /etc/motd

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for banner:
[banner@stapp03 tmp]$
[banner@stapp03 tmp]$ cat /etc/motd
################################################################################################
  .__   __.      ___      __    __  .___________. __   __       __    __       _______.        #
       |  \ |  |     /   \    |  |  |  | |           ||  | |  |     |  |  |  |     /       |   #
       |   \|  |    /  ^  \   |  |  |  | `---|  |----`|  | |  |     |  |  |  |    |   (----    #
       |  . `  |   /  /_\  \  |  |  |  |     |  |     |  | |  |     |  |  |  |     \   \       #
       |  |\   |  /  _____  \ |  `--'  |     |  |     |  | |  `----.|  `--'  | .----)   |      #
       |__| \__| /__/     \__\ \______/      |__|     |__| |_______| \______/  |_______/       #
                                                                                               #
                                                                                               #
                                                                                               #
                                                                                               #
                                 # #  ( )                                                      #
                                  ___#_#___|__                                                 #
                              _  |____________|  _                                             #
                       _=====| | |            | | |==== _                                      #
                 =====| |.---------------------------. | |====                                 #
   <--------------------'   .  .  .  .  .  .  .  .   '--------------/                          #
     \                                                             /                           #
      \_______________________________________________WWS_________/                            #
  wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww                        #
wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww                       #
   wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww                         #
                                                                                               #
                                                                                               #
################################################################################################
Warning! All Nautilus systems are monitored and audited. Logoff immediately if you are not authorized!
[banner@stapp03 tmp]$ exit
logout
Connection to 172.16.238.12 closed.


# Logging into DB Server
thor@jump_host /$ sshpass -p '******' ssh -o StrictHostKeyChecking=no  peter@172.16.239.10
Last login: Fri Jul  3 22:15:17 2020 from jump_host.linuxbanner_db_net
[peter@stdb01 ~]$
[peter@stdb01 ~]$ cd /tmp/
[peter@stdb01 tmp]$ ls -l
total 8
-rwx------ 39 root  root   836 Aug  1  2019 ks-script-rnBCJB
-rw-r--r--  1 peter peter 2531 Jul  3 22:17 nautilus_banner
-rw------- 39 root  root     0 Aug  1  2019 yum.log
[peter@stdb01 tmp]$
[peter@stdb01 tmp]$ ls -l /etc/motd
-rw-r--r-- 39 root root 0 Jun  7  2013 /etc/motd
[peter@stdb01 tmp]$
[peter@stdb01 tmp]$ sudo mv nautilus_banner /etc/motd
[sudo] password for peter:
[peter@stdb01 tmp]$
[peter@stdb01 tmp]$ cat /etc/motd
################################################################################################
  .__   __.      ___      __    __  .___________. __   __       __    __       _______.        #
       |  \ |  |     /   \    |  |  |  | |           ||  | |  |     |  |  |  |     /       |   #
       |   \|  |    /  ^  \   |  |  |  | `---|  |----`|  | |  |     |  |  |  |    |   (----    #
       |  . `  |   /  /_\  \  |  |  |  |     |  |     |  | |  |     |  |  |  |     \   \       #
       |  |\   |  /  _____  \ |  `--'  |     |  |     |  | |  `----.|  `--'  | .----)   |      #
       |__| \__| /__/     \__\ \______/      |__|     |__| |_______| \______/  |_______/       #
                                                                                               #
                                                                                               #
                                                                                               #
                                                                                               #
                                 # #  ( )                                                      #
                                  ___#_#___|__                                                 #
                              _  |____________|  _                                             #
                       _=====| | |            | | |==== _                                      #
                 =====| |.---------------------------. | |====                                 #
   <--------------------'   .  .  .  .  .  .  .  .   '--------------/                          #
     \                                                             /                           #
      \_______________________________________________WWS_________/                            #
  wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww                        #
wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww                       #
   wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww                         #
                                                                                               #
                                                                                               #
################################################################################################
Warning! All Nautilus systems are monitored and audited. Logoff immediately if you are not authorized!
[peter@stdb01 tmp]$ exit
logout
Connection to 172.16.239.10 closed.
thor@jump_host /$


#	4.	Now one of the requirements was to make user that users sees the banner everytime he/she logs in.
#		So I tested this as well.

# Summary - Log-in to each of the four server and make sure that you see the banner upon login.
sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sshpass -p  '******' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
sshpass -p  '******' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
sshpass -p '******' ssh -o StrictHostKeyChecking=no  peter@172.16.239.10

# Banner appears upon login. Success!

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
