
-----------------------------------------------------------------------------------------------------------------

Start			2020-11-10 03:38:48
Finished		2020-11-10 05:33:08

-----------------------------------------------------------------------------------------------------------------

TASK 48 - Configure Local Yum repos

**This is a repeat task. This was Task 23, dated 2020-07-25 and was already solved.
**I am also still adjusting to using VS Code for my Kodekloud notes.


REQUIREMENTS:

The Nautilus production support team and security team had a meeting last month in which they decided to use 
local yum repositories for maintaing packages needed for their servers. For now they have decided to configure 
a local yum repo on Nautilus Backup Server. This is one of the pending items from last month, so please configure 
a local yum repository on Nautilus Backup Server as per details given below.


a. We have some packages already present at location /packages/downloaded_rpms/ on Nautilus Backup Server.

b. Create a yum repo named yum_local and make sure to set Repository ID to yum_local. Configure it to use package 
location /packages/downloaded_rpms/.

c. Install package samba from this newly created repo.


-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://community.kodekloud.com/t/configure-local-yum-repos-failed/5099/9
https://www.plothost.com/kb/how-to-install-vim-enhanced/
TASK 48 - Configure Local Yum repos.sh

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

#	1.	Connect via SSH to the Backup server and then switch to root.
#	2.	Create the yum repo  in /etc/yum.repos.d/ and enter the necessary details.
#   3.  Clean up, updates, and then check current repolist.
#	4. 	Install the required package, start, enable, and then verify status.

-----------------------------------------------------------------------------------------------------------------

III.	STEPS - BREAKDOWN

**Kept having problems in the terminal of KodeKloud. Had to restart lab several times.
**Note that I just copied the same steps from the preious task but modified some.
**Some notes which I made from the previous task was also used here.

#	1.	Connect via SSH to the Backup server and then switch to root.
#		Since this was the first time I install a local yum repo - also the first time I've heard of it.
#		I checked first the file paths provided in the instructions.
#		As for the /etc directory, I saw multiple articles in KKC that show that the repo file must be 
#		created in the /etc/yum.repos.d

        sshpass -p '******' ssh -o StrictHostKeyChecking=no  clint@172.16.238.16
        sudo su -
        ******

        ll /packages/downloaded_rpms/
        ll /etc

#	2.	Create the yum repo  in /etc/yum.repos.d/ and enter the necessary details.
			
        cd /etc/yum.repos.d/
        cat > yum_local.repo
        
        # The yum_local.repo file should contain:
        
        [yum_local]
        name=yum_local
        baseurl=file:///packages/downloaded_rpms/
        gpgcheck=0
        enabled=1

#   3.  Clean up, updates, and then check current repolist.
        # Now there are also other additional steps after creating the repo.
        # I really haven't read about it yet, but it was suggested in the
        # KKC articles.
			
        sudo yum clean all			# removes cache of repos enabled in /etc/yum
        sudo yum update				# installs, updates, removes packages 
        sudo yum repolist			# lists the repos creates

#	4. 	Install the required package, start, enable, and then verify status.

        # Now for this one, I was supposed to use 'sudo yum install -y samba'
        # But there was a suggestion in the article to use the option '--enablepro'
        # Also, I tried to use 'samba'. Checking the article, it says 'smb'
        
        sudo yum install -y --enablerepo="yum_local" samba
        systemctl start smb 
        systemctl enable smb 
        systemctl status smb
			

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

