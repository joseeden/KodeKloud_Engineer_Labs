
-----------------------------------------------------------------------------------------------------------------

Start			2020-10-23 || 10:06 PM
Finished		2020-10-24 || 01:16 AM

-----------------------------------------------------------------------------------------------------------------

TASK 43 - Install and Configure DB Server 

REQUIREMENTS:

We recently migrated one of our WordPress websites from an old server to a new infrastructure in Stratos Datacenter. We have already setup LAMP, except for the database. We have also restored website code; however, we need to restore the database to make it work on the new infra. Please perform the below given steps on DB host:


a. Install/Configure MariaDB server.

b. Create a database with name kodekloud_db2.

c. There is a DB dump on jump_host under location /home/thor/db.sql. Restore this database in newly created database.

d. Create a user kodekloud_aim and set any password you like.

e. Grant full permissions to user kodekloud_aim on database kodekloud_db2.

f. Update database-related details in /data/wp-config.php file on storage server, which is our NFS server having a share /data mounted on each app server on location /var/www/html. (for more details about how to update WordPress config file please visit https://wordpress.org/support/article/editing-wp-config-php/)

g. You can access the website on LBR link; to do so click on the + button on top of your terminal, select option Select port to view on Host 1, and after adding port 80 click on Display Port.


-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://community.kodekloud.com/t/task-install-and-configure-db-server-need-help/2857/15
https://community.kodekloud.com/t/install-configure-db-server-scp-failure-missing-scp-on-stdb-server/4254
https://community.kodekloud.com/t/install-and-configure-db-server/3338

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

#	1.	SSH into the jump server, Storage Server, App server 1, App server 2, and App server 3 and switch 
#		to root.

#	ENOTE:
#	I actually just half-ass worked on this as I'm currently on duty right now and there's alot on my plate right now.
#	I dont feel too good about myself, in particular on my physical body, which seem to heavily affect my mind.
#	I hate whenever I gain pounds, and not just a few pounds -- as in pounds with beer-belly and man-handles.
#	This fuckin suck! 
#	Anwyay, I originally set OOF in Kodekloud for now since I'm reviewing for GCP Assoc Cloud Engineer.
# 	However there seems to be a glitch becase I was still assigned with a task.
#	Since task is not going away, I decided to work on it, gain the points, and set OOF on my account again.
#	Anyway, I hope to return to this again after the exam and when I focus o learning how to code AGAIN.

-----------------------------------------------------------------------------------------------------------------

III.	STEPS - BREAKDOWN


sshpass -p '******' ssh -o StrictHostKeyChecking=no  peter@172.16.239.10
sudo su -
******

yum install openssh-clients -y


sudo yum install -y mariadb-server

sudo yum install -y mariadb*

systemctl restart mariadb

sudo systemctl enable mariadb && systemctl start mariadb && systemctl status mariadb

sudo mysql_secure_installation


mysql -u root -p
create database kodekloud_db2;
CREATE USER 'kodekloud_cap'@localhost IDENTIFIED BY 'pass';
grant all on kodekloud_db2.* to 'kodekloud_cap' IDENTIFIED BY 'pass' WITH GRANT OPTION;
grant all privileges on kodekloud_db2.* to 'kodekloud_cap'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
exit

cd /home/peter/
vi /etc/my.cnf
bind-address=172.16.239.10
port=3306



mysql -u kodekloud_cap  -p kodekloud_db2 < /tmp/db.sql

systemctl restart mariadb && systemctl status mariadb


mysql -u kodekloud_cap -p -h stdb01
pass
exit

mysql -u kodekloud_cap -p -h localhost
pass
exit

sshpass -p '******' ssh -o StrictHostKeyChecking=no  natasha@172.16.238.15
sudo su -
******


cat /data/wp-config.php | grep DB_NAME
cat /data/wp-config.php | grep DB_USER
cat /data/wp-config.php | grep DB_PASSWORD
cat /data/wp-config.php | grep DB_HOST


sudo sed -i 's/dbname/kodekloud_db2/g' /data/wp-config.php
sudo sed -i 's/dbuser/kodekloud_cap/g' /data/wp-config.php
sudo sed -i 's/dbpass/pass/g' /data/wp-config.php
sudo sed -i 's/dbhost/stdb01/g' /data/wp-config.php

exit
exit


sshpass -p  '******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo su -
******


yum install mysql -y
mysql -u kodekloud_cap -p -h stdb01



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



