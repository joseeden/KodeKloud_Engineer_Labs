
-----------------------------------------------------------------------------------------------------------------

Start			2020-09-08 || 10:51 PM
Finished		2020-09-09 || 01:52 AM	

-----------------------------------------------------------------------------------------------------------------

TASK 36 - Install and Configure PostgreSQL

REQUIREMENTS:

The Nautilus application development team has shared that they are planning to deploy one newly developed application on Nautilus infra in Stratos DC. The application uses PostgreSQL database, so as a pre-requisite we need to set up PostgreSQL database server as per requirements shared below:


a. Install and configure PostgreSQL database on Nautilus database server.

b. Create a database user kodekloud_rin and set its password to TmPcZjtRQx.

c. Create a database kodekloud_db10 and grant full permissions to user kodekloud_rin on this database.

d. Make appropriate settings to allow all local clients (local socket connections) to connect to the kodekloud_db10 	    database through kodekloud_rin user using md5 method (Please do not try to encrypt password with md5sum).

e. At the end its good to test the db connection using these new credentials from root user or server sudo user.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://community.kodekloud.com/t/install-and-configure-postgresql-task-failed/11464/8
https://community.kodekloud.com/t/install-and-configure-postgresql-task-failed/11464/8
https://community.kodekloud.com/t/install-and-configure-postgresql/2343/7
https://community.kodekloud.com/t/install-configure-postgresql-task/2470

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

#	1.	SSH into the jump server, Storage Server, App server 1, App server 2, and App server 3 and switch 
#		to root.
#	2.	Install postgresql and initialize. 
#		Enable, start, and then verify status of postgresql service.
#	3.	Sign-in to the postgresql db. Create the required user and database, and then grant all
#		privileges (for the database) to the user. Exit afterwards.
#	4.	Modify '/var/lib/pgsql/data/postgresql.conf' and uncomment the 'listen_addresses'.
#		Afterwards, modify '/var/lib/pgsql/data/pg_hba.conf' to change methods of local and host to 'md5'
#	5.	Restart postgresql and verify status of the service.
#	6.	Test by accessing the created database using the created user.

-----------------------------------------------------------------------------------------------------------------

III.	COMMANDS USED

#	1.	SSH into the jump server, Storage Server, App server 1, App server 2, and App server 3 and switch 
#		to root.

			sshpass -p '******' ssh -o StrictHostKeyChecking=no  peter@172.16.239.10
			sudo su -
			******

#	2.	Install postgresql and initialize. 
#		Enable, start, and then verify status of postgresql service.

			yum install -y postgresql-server postgresql-contrib
			postgresql-setup initdb
			systemctl enable postgresql && systemctl start postgresql && systemctl status postgresql

#	3.	Sign-in to the postgresql db. Create the required user and database, and then grant all
#		privileges (for the database) to the user. Exit afterwards.

			sudo -u postgres psql
			create user kodekloud_rin   with encrypted password 'B4zNgHA7Ya'; 
			create database kodekloud_db9 owner kodekloud_rin;
			grant all privileges on database kodekloud_db9 to kodekloud_rin ;
			exit

#	4.	Modify '/var/lib/pgsql/data/postgresql.conf' and uncomment the 'listen_addresses'.
#		Afterwards, modify '/var/lib/pgsql/data/pg_hba.conf' to change methods of local and host to 'md5'

			vi /var/lib/pgsql/data/postgresql.conf

				listen_addresses = 'localhost' # what IP address(es) to listen on

			vi /var/lib/pgsql/data/pg_hba.conf

				host all all 0.0.0.0/0 md5
				local all all 0.0.0.0/0 md5
	
#	5.	Restart postgresql and verify status of the service.

			sudo systemctl restart postgresql
			systemctl enable postgresql && systemctl start postgresql && systemctl status postgresql

#	6.	Test by accessing the created database using the created user.	

			psql -U kodekloud_rin  -d kodekloud_db9 -h 127.0.0.1 -W
			psql -U kodekloud_rin  -d kodekloud_db9 -h localhost -W


-----------------------------------------------------------------------------------------------------------------

IV.	STEPS - BREAKDOWN

#	This was one of the hardest labs that I've done so far in Kodekloud. 
#	Took me around 3 hours to go over the different articles in KKC.
#	All the articles in the KKC have been very helpful and I have definitely learned so much
#	after finishing the lab.

#	I've attahed the SupportFile which contains the scrapes for the lab.

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

