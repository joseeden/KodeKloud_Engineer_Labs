
-----------------------------------------------------------------------------------------------------------------

Start			2020-11-25 21:30:01
Finished		2020-11-25 22:34:29

-----------------------------------------------------------------------------------------------------------------

TASK_52-Apache_Troubleshooting

REQUIREMENTS:

# This is a repeated task. This was Task 16, completed last 2020-07-16.
# The main difference is that my approach on this was different than the steps I did before.

xFusionCorp Industries utilizes monitoring tools to check the status of every service, application, etc. running on the systems. The monitoring system identified that Apache service is not running on some of the Nautilus Application Servers in Stratos Datacenter.

Identify the faulty Nautilus Application Servers and fix the issue. Also, make sure Apache service is up and running on all Nautilus Application Servers. Do not try to stop any kind of firewall that is already running.

Apache is running on 8081 port on all Nautilus Application Servers and its document root must be /var/www/html on all app servers.

Finally you can test from jump host using curl command to access Apache on all app servers and it should work fine. E.g. curl http://172.16.238.10:6400/

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://community.kodekloud.com/t/apache-troubleshooting/1657/8
https://community.kodekloud.com/t/apache-troubleshooting-failed-test/2050/26
https://www.cyberciti.biz/faq/unix-linux-check-if-port-is-in-use-command/
https://www.shawonruet.com/2020/08/apache-troubleshooting-kodekloud.html
https://community.kodekloud.com/t/apache-troubleshooting-failed/10409/4

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

#   EDEN:
#   This was the steps I did during the first time this task came to me.
#   This did solved the issue and I was able to complete the task back then, but I've learned now
#   there's a much better or rather correct steps to troubleshoot this issue.
#   Having said, I still included these steps (from the previous task) here but note that
#   the correct approach is written after these set of steps.
#   For the correct steps, please skip this and proceed to 'PROPER TSHOOT STEPS'

#   1.	Connect via SSH to each App Server.
#   2.	Check httspd status. (I knew all httpd in all app servers were not working so I proceeded to step 3))
#   3.	Remove https and then reinstall it again on each app server.
#   4.	Edit the /etc/httpd/conf/httpd.conf file.
#   5.	Restart httpd and check status.
#   6.	Go back to jump server and test curl to each App server.

#   2020-11-25 22:23:41 - PROPER TSHOOT STEPS

#	1.	SSH into the App server 1, App server 2, and App server 3 and switch to root.
#   2.  As it is mentioned that the issue is in Apache, it's good diea to update and install Apache.
#       Start and then verify status afterwards.
#   3.  Note which server has 'Active' status and which has 'inactive' status.
#       Even though a server is Active status, we will still need to check it's /etc/httpd/conf/httpd.conf
#       There are certain parts in the config which we need to check and correct.
#   4.  After modifying the /etc/httpd/conf/httpd.conf, restart the Apache service and verify status.
#       All App servers should be in Active state now.
#   5.  From the jump host, curl the ip addresses of each App server using the port specified
#       in the instruction.

-----------------------------------------------------------------------------------------------------------------

III.	STEPS - BREAKDOWN

#   2020-11-25 12:58:09 - EDEN:

#   The following text are original text copied from Task 16, completed last 2020-07-16.

#	"""So this one's mildly difficult. On my first attempt, I first checked all App servers and see if httpd is working.
#	Httpd was not working so I went in to seach KKC on how to resolve this.
#	Found two useful articles which gave me hints on how to deal with the issue, and also with the commands to use.
#	Though I still did one modification on th ehttpd.conf file which was not suggested in any of the articles.
#	When I tried adding the appservers ip address:port number and the curl test from the jump server still did not
#	worked, I went back to the httpd.conf file and read some parts of it.
#	I found one section that suggests about adding the port where the app server should listen to.
#	It was my 2nd attempt and tried changin the 'Listen <port number>', restarted httpd, checked status, and then went 
#	back to the jump server to do the curl test.
#	And whatdoyaknow, it worked!

#	So at this point in time, I repeated the lab with a defined list of steps to be done and the target is to
#	reconfigure and make sure all app servers working in under 10 mins.""""

#-----------------------------------------------------------------------------------------------------

#   As I've mentioned in the Steps-Summary section, I took a different approach in troubleshooting this issue.
#   While I still use some of the commands, I could say that I understand this task better now.
#   I'll have to mention also that each time I restart the lab, the faulty App server always change.
#   There was an instance that all App Servers show Active state even though I know there's something
#   wrong in there httpd.conf.

#	1.	SSH into the App server 1, App server 2, and App server 3 and switch to root.

        sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
        sudo su -
        ******

        sshpass -p  '******' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
        sudo su -
        ******

        sshpass -p  '******' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
        sudo su -
        ******

#   2.  As it is mentioned that the issue is in Apache, it's good diea to update and install Apache.
#       Start and then verify status afterwards.

        sudo yum install httpd -y
        sudo systemctl start httpd 
        sudo systemctl status httpd

#   3.  Note which server has 'Active' status and which has 'inactive' status.
#       Even though a server is Active status, we will still need to check it's /etc/httpd/conf/httpd.conf
#       There are certain parts in the config which we need to check and correct.

        sudo vi /etc/httpd/conf/httpd.conf

        # These are the parts that we need to check and rectify:

            Listen 8081                                 # this was 'Listen 8080'
            DocumentRoot "/var/www/html"                # this was DocumentRoot "/var/www/html;"
            ServerRoot "/etc/httpd"                     # this was DocumentRoot "/etc/httpd;"

        # in addition, find the 'ServerName' in the httpd.conf of each Appserver and replace the text there with:
        
            ServerName 172.16.238.10:8081               # for App Server1
            ServerName 172.16.238.11:8081               # for App Server2
            ServerName 172.16.238.12:8081               # for App Server3

#   4.  After modifying the /etc/httpd/conf/httpd.conf, restart the Apache service and verify status.
#       All App servers should be in Active state now.

        systemctl restart httpd
        systemctl status httpd

#   5.  From the jump host, curl the ip addresses of each App server using the port specified
#       in the instruction.

        curl http://172.16.238.10:8081/
        curl http://172.16.238.11:8081/
        curl http://172.16.238.12:8081/

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
