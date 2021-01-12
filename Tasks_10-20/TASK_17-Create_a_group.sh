
-----------------------------------------------------------------------------------------------------------------

Start		2020-07-17 || 05:16 AM
Finished	

-----------------------------------------------------------------------------------------------------------------

TASK 17 - Create a group

REQUIREMENT:

There are specific access levels for users defined by the xFusionCorp Industries system admin team. Rather than providing access levels to every individual user, the team has decided to create groups with required access levels and add users to that groups as needed. See the following requirements:

a. Create a group named nautilus_sftp_users in all App servers in Stratos Datacenter.
b. Add the user mohammed to nautilus_sftp_users in all App servers. (create the user if not present already)

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://linuxhandbook.com/list-users-in-group-linux/
https://www.howtogeek.com/50787/add-a-user-to-a-group-or-second-group-on-linux/
https://linuxize.com/post/how-to-add-user-to-group-in-linux/
https://community.kodekloud.com/t/task-creating-a-group-and-adding-an-user-to-group-on-all-application-servers/1103
https://community.kodekloud.com/t/failed-create-group-and-add-user/1134/2

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

	1.	Connect via SSH to each App Server.
	2.	Create the group
	3. 	Add user to the group then verify.
	
-----------------------------------------------------------------------------------------------------------------

III.	COMMANDS USED

sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sshpass -p  '******' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
sshpass -p  '******' ssh -o StrictHostKeyChecking=no banner@172.16.238.12

sudo groupadd nautilus_developers
sudo useradd -G nautilus_developers jarod
sudo usermod -a -G nautilus_developers jarod
getent passwd | grep jarod
getent group nautilus_developers
getent group

-----------------------------------------------------------------------------------------------------------------

IV.	STEPS - BREAKDOWN

#	This was actually one of the fairly easy but I complicated it that's why it took me around an hour
#	or more before I finally decided to hit finis.
#	When I was creating the group and the use and then when I check th elist of groups, the username always appears
#	in the grouplist.
#	Thinking that somehow the command I'm usign is also creating a 2nd group and uses the username, 
#	I kept modifying the commands I used. I also looked in the net and KKC for the solution.
#	When I ws already at many attempts, I decided to just follow the commands listed in one article
#	in KKC and disregard if the username appears in the group list.
#	After doing it for the 3 servers and hitting finish, it didn't showed an error. it actually worked.
#	So lesson-learn: don't overthink things.
#	I guess I was just consumed by the idea of not failing the lab that it held me back from actually finishing the lab
#	faster.
#	Also, I might need to recall/study more on the user and group creation.
#	It's basic, I know, but yeah. we all need to get down the basics before succeeding at somethign difficult.

thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10Warning: Permanently added '172.16.238.10' (ECDSA) to the list of known hosts.
[tony@stapp01 ~]$ getent grouproot:x:0:
bin:x:1:
daemon:x:2:
sys:x:3:
adm:x:4:
tty:x:5:
disk:x:6:
lp:x:7:
mem:x:8:
kmem:x:9:
wheel:x:10:ansible,tony
cdrom:x:11:mail:x:12:
man:x:15:
dialout:x:18:
floppy:x:19:
games:x:20:
tape:x:33:
video:x:39:
ftp:x:50:
lock:x:54:
audio:x:63:
nobody:x:99:
users:x:100:
utmp:x:22:
utempter:x:35:
input:x:999:
systemd-journal:x:190:
systemd-network:x:192:
dbus:x:81:
ssh_keys:x:998:
sshd:x:74:
ansible:x:1000:
tony:x:1001:
[tony@stapp01 ~]$ sudo groupadd nautilus_developers

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for tony:
[tony@stapp01 ~]$ sudo useradd -G nautilus_developers jarod
[tony@stapp01 ~]$ sudo usermod -a -G nautilus_developers jarod
[tony@stapp01 ~]$ getent passwd | grep jarod
jarod:x:1002:1003::/home/jarod:/bin/bash
[tony@stapp01 ~]$
[tony@stapp01 ~]$ getent group
root:x:0:
bin:x:1:
daemon:x:2:
sys:x:3:
adm:x:4:
tty:x:5:
disk:x:6:
lp:x:7:
mem:x:8:
kmem:x:9:
wheel:x:10:ansible,tony
cdrom:x:11:
mail:x:12:
man:x:15:
dialout:x:18:
floppy:x:19:
games:x:20:
tape:x:33:
video:x:39:
ftp:x:50:
lock:x:54:
audio:x:63:
nobody:x:99:
users:x:100:
utmp:x:22:
utempter:x:35:
input:x:999:
systemd-journal:x:190:
systemd-network:x:192:
dbus:x:81:
ssh_keys:x:998:
sshd:x:74:
ansible:x:1000:
tony:x:1001:
nautilus_developers:x:1002:jarod
jarod:x:1003:
[tony@stapp01 ~]$ getent group nautilus_developers
nautilus_developers:x:1002:jarod
[tony@stapp01 ~]$
[tony@stapp01 ~]$ exit
logout
Connection to 172.16.238.10 closed.
thor@jump_host /$
thor@jump_host /$
thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
Warning: Permanently added '172.16.238.11' (ECDSA) to the list of known hosts.
[steve@stapp02 ~]$
[steve@stapp02 ~]$ sudo groupadd nautilus_developers

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for steve:
[steve@stapp02 ~]$
[steve@stapp02 ~]$ sudo useradd -G nautilus_developers jarod
[steve@stapp02 ~]$ sudo usermod -a -G nautilus_developers jarod
[steve@stapp02 ~]$ getent passwd | grep jarod
jarod:x:1002:1003::/home/jarod:/bin/bash
[steve@stapp02 ~]$ getent group nautilus_developers
nautilus_developers:x:1002:jarod
[steve@stapp02 ~]$
[steve@stapp02 ~]$ getent group
root:x:0:
bin:x:1:
daemon:x:2:
sys:x:3:
adm:x:4:
tty:x:5:
disk:x:6:
lp:x:7:
mem:x:8:
kmem:x:9:
wheel:x:10:ansible,steve
cdrom:x:11:
mail:x:12:
man:x:15:
dialout:x:18:
floppy:x:19:
games:x:20:
tape:x:33:
video:x:39:
ftp:x:50:
lock:x:54:
audio:x:63:
nobody:x:99:
users:x:100:
utmp:x:22:
utempter:x:35:
input:x:999:
systemd-journal:x:190:
systemd-network:x:192:
dbus:x:81:
ssh_keys:x:998:
sshd:x:74:
ansible:x:1000:
steve:x:1001:
nautilus_developers:x:1002:jarod
jarod:x:1003:
[steve@stapp02 ~]$ exit
logout
Connection to 172.16.238.11 closed.
thor@jump_host /$
thor@jump_host /$ sshpass -p  '******' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
Warning: Permanently added '172.16.238.12' (ECDSA) to the list of known hosts.
[banner@stapp03 ~]$
[banner@stapp03 ~]$ sudo groupadd nautilus_developers

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for banner:
[banner@stapp03 ~]$
[banner@stapp03 ~]$ sudo useradd -G nautilus_developers jarod
[banner@stapp03 ~]$ sudo usermod -a -G nautilus_developers jarod
[banner@stapp03 ~]$ getent passwd | grep jarod
jarod:x:1002:1003::/home/jarod:/bin/bash
[banner@stapp03 ~]$ getent group nautilus_developers
nautilus_developers:x:1002:jarod
[banner@stapp03 ~]$ getent group
root:x:0:
bin:x:1:
daemon:x:2:
sys:x:3:
adm:x:4:
tty:x:5:
disk:x:6:
lp:x:7:
mem:x:8:
kmem:x:9:
wheel:x:10:ansible,banner
cdrom:x:11:
mail:x:12:
man:x:15:
dialout:x:18:
floppy:x:19:
games:x:20:
tape:x:33:
video:x:39:
ftp:x:50:
lock:x:54:
audio:x:63:
nobody:x:99:
users:x:100:
utmp:x:22:
utempter:x:35:
input:x:999:
systemd-journal:x:190:
systemd-network:x:192:
dbus:x:81:
ssh_keys:x:998:
sshd:x:74:
ansible:x:1000:
banner:x:1001:
nautilus_developers:x:1002:jarod
jarod:x:1003:
[banner@stapp03 ~]$
[banner@stapp03 ~]$
[banner@stapp03 ~]$ exit
logout
Connection to 172.16.238.12 closed.
thor@jump_host /$ Connection to host01 closed by remote host.
Connection to host01 closed.


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


