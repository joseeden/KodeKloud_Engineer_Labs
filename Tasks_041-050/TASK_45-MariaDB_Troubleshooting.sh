
-----------------------------------------------------------------------------------------------------------------

Start			2020-10-27 || 02:08 PM
Finished		2020-10-27 || 03:01 PM

-----------------------------------------------------------------------------------------------------------------

TASK 45 - MariaDB Troubleshooting

*This was an expired task before - previously TASK 4.

REQUIREMENTS:

There is a critical issue going on with the Nautilus application in Stratos DC. The production support team identified that the application is unable to connect to the database. After digging into the issue, the team found that mariadb service is down on the database server.

Look into the issue and fix the same.

-----------------------------------------------------------------------------------------------------------------

CONTENT:
	I.		REFERENCES
	II.		STEPS - SUMMARY
	III.	COMMANDS USED
	IV.		STEPS - BREAKDOWN

-----------------------------------------------------------------------------------------------------------------

I.		REFERENCES

https://community.kodekloud.com/t/issue-with-mariadb-troubleshooting-task/2954
https://serverfault.com/questions/812719/mysql-mariadb-not-starting
https://www.shawonruet.com/2020/08/mariadb-troubleshooting-kodekloud.html     --- can solve problem but not correct solution

-----------------------------------------------------------------------------------------------------------------

II.		STEPS - SUMMARY

#	1.	SSH into the DB server and switch to root
#	2.	Verify status of Mariadb service. Restart and verify status again.
#	3.	As per the KKC articles, this may be a ownership issue. Check for mysql directory in /var/llb.
#		Change ownership into root:root then restart again service and verify status.
#	4.	Server may need to be updated. Afterwards, restart mariadb  and verify status again.

-----------------------------------------------------------------------------------------------------------------

III.	STEPS - BREAKDOWN

#	1.	SSH into the DB server and switch to root

		sshpass -p '******' ssh -o StrictHostKeyChecking=no  peter@172.16.239.10
		sudo su -
		******

#	2.	Verify status of Mariadb service. Restart and verify status again.

		systemctl status mariadb
		systemctl restart mariadb

#	3.	As per the KKC articles, this may be a ownership issue. Check for mysql directory in /var/llb.
#		Change ownership into root:root then restart again service and verify status.

		ls -l /var/lib
			total 48
			total 48
			drwxr-xr-x 2 root root  4096 Jan 27  2020 alternatives
			drwxr-xr-x 2 root root  4096 Mar 14  2019 dbus
			drwxr-xr-x 2 root root  4096 Apr 11  2018 games
			drwxr-xr-x 2 root root  4096 Nov  2  2018 initramfs
			drwx------ 2 root root  4096 Aug  1  2019 machines
			drwxr-xr-x 2 root root  4096 Apr 11  2018 misc
			drwxr-xr-x 1 root mysql 4096 Aug  8  2019 mysql
			drwxr-xr-x 1 root root  4096 Oct 27 06:42 rpm
			drwxr-xr-x 2 root root  4096 Apr 11  2018 rpm-state
			drwxr-xr-x 4 root root  4096 Oct 15  2019 stateless
			drwxr-xr-x 4 root root  4096 Aug  1  2019 systemd
			drwxr-xr-x 6 root root  4096 Jan 27  2020 yum

		cd /var/lib
		chown root:root mysqld	
			ll
			total 48
			drwxr-xr-x 2 root root 4096 Jan 27  2020 alternatives
			drwxr-xr-x 2 root root 4096 Mar 14  2019 dbus
			drwxr-xr-x 2 root root 4096 Apr 11  2018 games
			drwxr-xr-x 2 root root 4096 Nov  2  2018 initramfs
			drwx------ 2 root root 4096 Aug  1  2019 machines
			drwxr-xr-x 2 root root 4096 Apr 11  2018 misc
			drwxr-xr-x 1 root root 4096 Aug  8  2019 mysql
			drwxr-xr-x 1 root root 4096 Oct 27 06:42 rpm
			drwxr-xr-x 2 root root 4096 Apr 11  2018 rpm-state
			drwxr-xr-x 4 root root 4096 Oct 15  2019 stateless
			drwxr-xr-x 4 root root 4096 Aug  1  2019 systemd
			drwxr-xr-x 6 root root 4096 Jan 27  2020 yum

		systemctl restart mariadb
		systemctl status mariadb
		
#	4.	Server may need to be updated. Afterwards, restart mariadb  and verify status again.

		sudo yum update -y 
		systemctl restart mariadb
		systemctl status mariadb			
			● mariadb.service - MariaDB database server
			   Loaded: loaded (/usr/lib/systemd/system/mariadb.service; enabled; vendor preset: disabled)
			   Active: active (running) since Tue 2020-10-27 06:47:35 UTC; 9s ago
			  Process: 728 ExecStartPost=/usr/libexec/mariadb-wait-ready $MAINPID (code=exited, status=0/SUCCESS)
			  Process: 646 ExecStartPre=/usr/libexec/mariadb-prepare-db-dir %n (code=exited, status=0/SUCCESS)
			 Main PID: 727 (mysqld_safe)
			   CGroup: /docker/4ce047d2124ffe999fc4d8f4faa1829c3fd3aa877e6e5101e9df46bb4ea1be77/system.slice/mariadb.service
					   ├─727 /bin/sh /usr/bin/mysqld_safe --basedir=/usr
					   └─888 /usr/libexec/mysqld --basedir=/usr --datadir=/var/lib/mysql --plugin-dir=/us...

			Oct 27 06:47:32 stdb01 systemd[1]: Starting MariaDB database server...
			Oct 27 06:47:32 stdb01 mariadb-prepare-db-dir[646]: Initializing MariaDB database
			Oct 27 06:47:33 stdb01 mariadb-prepare-db-dir[646]: 201027  6:47:33 [Note] /usr/libexec/mys.....
			Oct 27 06:47:33 stdb01 mariadb-prepare-db-dir[646]: 201027  6:47:33 [Note] /usr/libexec/mys.....
			Oct 27 06:47:33 stdb01 mariadb-prepare-db-dir[646]: PLEASE REMEMBER TO SET A PASSWORD FOR T... !
			Oct 27 06:47:33 stdb01 mysqld_safe[727]: 201027 06:47:33 mysqld_safe Logging to '/var/log/...g'.
			Oct 27 06:47:33 stdb01 mysqld_safe[727]: 201027 06:47:33 mysqld_safe Starting mysqld daemo...sql
			Oct 27 06:47:35 stdb01 systemd[1]: Started MariaDB database server.
			Hint: Some lines were ellipsized, use -l to show in full.
			[root@stdb01 run]#
			[root@stdb01 run]# Connection to host01 closed by remote host.
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


