
-----------------------------------------------------------------------------------------------------------------

Start						2020-07-27 || 12:18 PM
Finished					2020-07-27 || 01:10 PM

Number of Attempts:			2
Total Time(in hours):		1 

-----------------------------------------------------------------------------------------------------------------

TASK 24 - Linux Resource Limits

REQUIREMENTS:

On our Storage server in Stratos Datacenter we are having some issues where nfsuser user is holding hundred of processes, which is degrading the performance of the server. Therefore, we have a requirement to limit its maximum processes. Please set its maximum process limits as below:

a. soft limit = 79
b. hard_limit = 100

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://linoxide.com/linux-how-to/limit-processes-user-level-linux/		# detailed explanation
https://community.kodekloud.com/t/linux-resource-limits-task-failed/1254/6
https://community.kodekloud.com/t/linux-resource-limit-task-failed/3886

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

	1.	Connect via SSH to the Storage Server.
	2.	Check the limits and the limits.conf file.
	3.	Edit the limits.conf file to add nfsuser and the hard and soft limits for the processes.
	4.	Verify.

-----------------------------------------------------------------------------------------------------------------

III.	COMMANDS USED

#	1.	Connect via SSH to the Storage Server.

		sshpass -p '******' ssh -o StrictHostKeyChecking=no  natasha@172.16.238.15
		
#	2.	Check the limits and the limits.conf file.
#		Now there aren't much articles in the KKC - there were only two of them.
#		The two were actually helpful but they still seem to be lacking of explanations
#		so I decided to look it up in the internet.
#		And as always, in every lab I do, I always check first if the reported issue is really occuring.
#		the 'ulimiit' and its options doesn't seem to help much - I did not bother to read more on the 
#		verification part and went straight to modifying the limits.conf (as suggested in the Internet article
#		and the KKC article) after I checked the limits

		ulimit -a
		ulimit -Sn
		ulimit -Hn
		cat /etc/security/limits.conf

#	3.	Edit the limits.conf file to add nfsuser and the hard and soft limits for the processes.

		sudo vi /etc/security/limits.conf
		
#		Now the limit.conf file doesn't have a user 'nfsuser' in it so I added the user along with
#		the hard and soft limits for its processes

		@nfsuser	soft	nproc	79
		@nfsuser	hard	nproc	100	
		
#	4.	Verify.
#		Again, I did not read more on how to verify if everything's is working as they should be and the
#		KKC article doesn't seem to provide much on how to valdate the steps.
#		So i just checked again the limits.conf and hit 'Finish'

		cat /etc/security/limits.conf

-----------------------------------------------------------------------------------------------------------------

IV.	STEPS - BREAKDOWN

#	I felt this one was one of the easiest lab although it has a much higher corresponding points
#	when you complete it.
#	For this lab, I did two attempts in 1 hour

thor@jump_host /$ sshpass -p '******' ssh -o StrictHostKeyChecking=no  natasha@172.16.238.15Warning: Permanently added '172.16.238.15' (ECDSA) to the list of known hosts.
[natasha@ststor01 ~]$
[natasha@ststor01 ~]$ ulimit -a
core file size          (blocks, -c) unlimited
data seg size           (kbytes, -d) unlimited
scheduling priority             (-e) 0
file size               (blocks, -f) unlimited
pending signals                 (-i) 7831
max locked memory       (kbytes, -l) 64
max memory size         (kbytes, -m) unlimited
open files                      (-n) 1048576
pipe size            (512 bytes, -p) 8
POSIX message queues     (bytes, -q) 819200real-time priority              (-r) 0
stack size              (kbytes, -s) 8192cpu time               (seconds, -t) unlimited
max user processes              (-u) unlimited
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimited
[natasha@ststor01 ~]$
[natasha@ststor01 ~]$ ulimit -Sn
1048576
[natasha@ststor01 ~]$ ulimit -Hn
1048576
[natasha@ststor01 ~]$ cat /etc/security/limits.conf
# /etc/security/limits.conf
#
#This file sets the resource limits for the users logged in via PAM.
#It does not affect resource limits of the system services.
#
#Also note that configuration files in /etc/security/limits.d directory,
#which are read in alphabetical order, override the settings in this
#file in case the domain is the same or more specific.
#That means for example that setting a limit for wildcard domain here
#can be overriden with a wildcard setting in a config file in the
#subdirectory, but a user specific setting here can be overriden only
#with a user specific setting in the subdirectory.
#
#Each line describes a limit for a user in the form:
#
#<domain>        <type>  <item>  <value>
#
#Where:
#<domain> can be:
#        - a user name
#        - a group name, with @group syntax
#        - the wildcard *, for default entry
#        - the wildcard %, can be also used with %group syntax,
#                 for maxlogin limit
#
#<type> can have the two values:
#        - "soft" for enforcing the soft limits
#        - "hard" for enforcing hard limits
#
#<item> can be one of the following:
#        - core - limits the core file size (KB)
#        - data - max data size (KB)
#        - fsize - maximum filesize (KB)
#        - memlock - max locked-in-memory address space (KB)
#        - nofile - max number of open file descriptors
#        - rss - max resident set size (KB)
#        - stack - max stack size (KB)
#        - cpu - max CPU time (MIN)
#        - nproc - max number of processes
#        - as - address space limit (KB)
#        - maxlogins - max number of logins for this user
#        - maxsyslogins - max number of logins on the system
#        - priority - the priority to run user process with
#        - locks - max number of file locks the user can hold
#        - sigpending - max number of pending signals
#        - msgqueue - max memory used by POSIX message queues (bytes)
#        - nice - max nice priority allowed to raise to values: [-20, 19]
#        - rtprio - max realtime priority
#
#<domain>      <type>  <item>         <value>
#

#*               soft    core            0
#*               hard    rss             10000
#@student        hard    nproc           20
#@faculty        soft    nproc           20
#@faculty        hard    nproc           50
#ftp             hard    nproc           0
#@student        -       maxlogins       4

# End of file
[natasha@ststor01 ~]$
[natasha@ststor01 ~]$ sudo vi /etc/security/limits.conf

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for natasha:
[natasha@ststor01 ~]$
[natasha@ststor01 ~]$ cat /etc/security/limits.conf
# /etc/security/limits.conf
#
#This file sets the resource limits for the users logged in via PAM.
#It does not affect resource limits of the system services.
#
#Also note that configuration files in /etc/security/limits.d directory,
#which are read in alphabetical order, override the settings in this
#file in case the domain is the same or more specific.
#That means for example that setting a limit for wildcard domain here
#can be overriden with a wildcard setting in a config file in the
#subdirectory, but a user specific setting here can be overriden only
#with a user specific setting in the subdirectory.
#
#Each line describes a limit for a user in the form:
#
#<domain>        <type>  <item>  <value>
#
#Where:
#<domain> can be:
#        - a user name
#        - a group name, with @group syntax
#        - the wildcard *, for default entry
#        - the wildcard %, can be also used with %group syntax,
#                 for maxlogin limit
#
#<type> can have the two values:
#        - "soft" for enforcing the soft limits
#        - "hard" for enforcing hard limits
#
#<item> can be one of the following:
#        - core - limits the core file size (KB)
#        - data - max data size (KB)
#        - fsize - maximum filesize (KB)
#        - memlock - max locked-in-memory address space (KB)
#        - nofile - max number of open file descriptors
#        - rss - max resident set size (KB)
#        - stack - max stack size (KB)
#        - cpu - max CPU time (MIN)
#        - nproc - max number of processes
#        - as - address space limit (KB)
#        - maxlogins - max number of logins for this user
#        - maxsyslogins - max number of logins on the system
#        - priority - the priority to run user process with
#        - locks - max number of file locks the user can hold
#        - sigpending - max number of pending signals
#        - msgqueue - max memory used by POSIX message queues (bytes)
#        - nice - max nice priority allowed to raise to values: [-20, 19]
#        - rtprio - max realtime priority
#
#<domain>      <type>  <item>         <value>
#

#*               soft    core            0
#*               hard    rss             10000
#@student        hard    nproc           20
#@faculty        soft    nproc           20
#@faculty        hard    nproc           50
#ftp             hard    nproc           0
#@student        -       maxlogins       4
@nfsuser         soft    nproc           77
@nfsuser         hard    nproc           100



# End of file
[natasha@ststor01 ~]$ Connection to host01 closed by remote host.
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

