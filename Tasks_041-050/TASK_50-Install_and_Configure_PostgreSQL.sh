
-----------------------------------------------------------------------------------------------------------------

Start			2020-11-22 00:29:39
Finished		2020-11-22 00:52:26

-----------------------------------------------------------------------------------------------------------------

TASK 50 - Install and Configure PostgreSQL

** This is a repeat task. This was Task 36, finished last 2020-09-09

REQUIREMENTS:

TASK 36 - Install and Configure PostgreSQL

REQUIREMENTS:

The Nautilus application development team has shared that they are planning to deploy one newly developed application on Nautilus infra in Stratos DC. The application uses PostgreSQL database, so as a pre-requisite we need to set up PostgreSQL database server as per requirements shared below:


a. Install and configure PostgreSQL database on Nautilus database server.

b. Create a database user kodekloud_cap and set its password to dCV3szSGNA.

c. Create a database kodekloud_db10 and grant full permissions to user kodekloud_cap on this database.

d. Make appropriate settings to allow all local clients (local socket connections) to connect to the kodekloud_db10 database through kodekloud_cap user using md5 method (Please do not try to encrypt password with md5sum).

e. At the end its good to test the db connection using these new credentials from root user or server sudo user.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
    III.	STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES


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

III.	STEPS - BREAKDOWN

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
        create user kodekloud_cap with encrypted password 'dCV3szSGNA'; 
        create database kodekloud_db10 owner kodekloud_cap;
        grant all privileges on database kodekloud_db10 to kodekloud_cap ;
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

        psql -U kodekloud_cap  -d kodekloud_db10 -h 127.0.0.1 -W
        psql -U kodekloud_cap  -d kodekloud_db10 -h localhost -W

        (enter password: dCV3szSGNA)


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
