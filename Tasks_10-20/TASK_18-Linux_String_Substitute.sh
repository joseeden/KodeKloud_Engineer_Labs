
-----------------------------------------------------------------------------------------------------------------

Start		2020-07-18 || 02:05 PM	
Finished	2020-07-18 || 03:29 PM

-----------------------------------------------------------------------------------------------------------------

TASK 18 - Linux String Substitute

REQUIREMENT:

The backup server in the Stratos DC contains several template XML files used by the Nautilus application. However, these template XML files must be populated with valid data before they can be used. One of the daily tasks of a system admin working in the xFusionCorp industries is to apply string and file manipulation commands!

Replace all occurances of the string Random to Cloud on the XML file /root/nautilus.xml located in the backup server.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://community.kodekloud.com/t/linux-string-substitute-sed/1796/9
https://community.kodekloud.com/t/linux-string-substitute-issue/1688
https://community.kodekloud.com/t/linux-string-substitute-task/1088
https://community.kodekloud.com/t/linux-string-substitute-task/2143							# this is the most detailed one
https://askubuntu.com/questions/442013/using-sed-to-search-and-replace-text-in-xml-file		# used this one as source

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

	1.	Connect via SSH to the  Backup server
	2.	Check the /root/nautilus.xml and grep for 'Random'
	3.	Switch to root user and search an replace.
	
-----------------------------------------------------------------------------------------------------------------

III.	COMMANDS USED

#	1.	Connect via SSH to the  Backup server
sshpass -p '******' ssh -o StrictHostKeyChecking=no  clint@172.16.238.16

#	2.	Check the /root/nautilus.xml and grep for 'Random'
sudo ls -l /root/nautilus.xml
sudo cat /root/nautilus.xml | grep Random

#	3.	Switch to root user and search an replace.
sudo su -
sudo sed -i 's#Random#Cloud#g' nautilus.xml
sudo cat /root/nautilus.xml | grep Cloud

-----------------------------------------------------------------------------------------------------------------

IV.	STEPS - BREAKDOWN

#	Now this one was a bit more complex though the main task was simple - just do a search and replace.
#	It was complex in a sese that even though I've played with REGEX before, I have never really
#	dived deep into it, even with Linux.
#	After reading some articales in KKC and the internet, I kinda learn adn recall about sed
#	(though i hope that the concept pf sed stick with me this time since I forgot about after the last time
#	 I first learned about it. ha! :D )

#	So going back, as I've said, the task was failry simple - just search for a given word in a file and replace 
#	all the occurence of that particular word  with another specific word.

#	You see I emphasize the 'particular' and ;specific' since one of the articles I've read
#	has failed the lab just because the sed was actually disregarding the case of the letters.
#	So this mean the words 'Text' and 'text' are taken as the sam eventhough they are not.
#	And that was one of the challenges of that lab.

#	I almost encountered that during my first attempt but luckily I repeated the lab and another word
#	was required to be replace in the second attempt.

#	Still, it's good to learn that there are ways to specificaly manipulate strings in Linux
#	- one I need to learn more about.

#	Anyway, learned (and re-learned) something new today! Noicee!

Warning: Permanently added '172.16.238.16' (ECDSA) to the list of known hosts.
[clint@stbkp01 ~]$[clint@stbkp01 ~]$ sudo su -

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for clint:
[root@stbkp01 ~]#
[root@stbkp01 ~]# sudo cat /root/nautilus.xml | grep Random
      <type>Random</type>      										# there were lots of occurence of 'Random'
      <type>Random</type>											# in this format but I've removed some of 
      <type>Random</type>											# since they are all the same.
      <type>Random</type>											# To shorten the documentation.
      <type>Random</type>
[root@stbkp01 ~]#
[root@stbkp01 ~]# sudo sed -i 's#Random#Cloud#g' nautilus.xml
[root@stbkp01 ~]#
[root@stbkp01 ~]# sudo cat /root/nautilus.xml | grep Random			# note that 'Random' doesn't show in the
[root@stbkp01 ~]#													# file anymore.
[root@stbkp01 ~]# sudo cat /root/nautilus.xml | grep Cloud			# we see that 'Cloud' has replaced all 'Random'	
      <type>Cloud</type>
      <type>Cloud</type>
      <type>Cloud</type>
      <type>Cloud</type>
      <type>Cloud</type>
[root@stbkp01 ~]#
[root@stbkp01 ~]# Connection to host01 closed by remote host.
Connection to host01 closed.

The environment has expired.

Please refresh to get a new environment.

#	FINAL NOTE:
#	So I actually spent 1.5 hours because I was not entirely focu on this lab while I was doing it.
#	I had many stops and distraction in the room.
#	Still, was able to learn the concept f sed again.


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

