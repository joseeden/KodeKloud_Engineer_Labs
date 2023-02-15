
TASK 5 - MariaDB Troubleshooting

There is a critical issue going on with the Nautilus application in Stratos DC. The production support team identified that the application is unable to connect to the database. After digging into the issue, the team found that mariadb service is down on the database server.

Look into the issue and fix the same.

-----------------------------------------------------------------------------------------------------------------

REFERENCE: 
https://community.kodekloud.com/t/issue-with-mariadb-troubleshooting-task/2954
https://serverfault.com/questions/812719/mysql-mariadb-not-starting

-----------------------------------------------------------------------------------------------------------------

# Checking on the Lucidchart, the Nautilus db server is stdb01 -- so I need to connect here first
sshpass -p '******' ssh -o StrictHostKeyChecking=no  peter@172.16.239.10

# then check status of mariadb
systemctl status mariadb

# I first tried restarting it
systemctl restart mariadb

# but this showed an error. It suggested to check "systemctl status mariadb.service"
# So i tried doing it again but in sudo
sudo systemctl restart mariadb

# Errored again this time. It suggested to check "systemctl 1 status mariadb.service"
# Tried the two suggestions, which both showed logs -- showing failed state
# the log showed
# [peter@stdb01 ~]$ systemctl status -l mariadb.service
● mariadb.service - MariaDB database server
   Loaded: loaded (/usr/lib/systemd/system/mariadb.service; disabled; vendor preset: disabled)
   Active: failed (Result: exit-code) since Thu 2020-07-02 09:55:00 UTC; 3min 52s ago
  Process: 121 ExecStartPre=/usr/libexec/mariadb-prepare-db-dir %n (code=exited, status=1/FAILURE)

Jul 02 09:55:00 stdb01 mariadb-prepare-db-dir[121]: Database MariaDB is not initialized, but the directory /var/lib/mysql is not empty, so initialization cannot be done.
Jul 02 09:55:00 stdb01 systemd[1]: Child 121 belongs to mariadb.service
Jul 02 09:55:00 stdb01 systemd[1]: mariadb.service: control process exited, code=exited status=1
Jul 02 09:55:00 stdb01 systemd[1]: mariadb.service got final SIGCHLD for state start-pre
Jul 02 09:55:00 stdb01 systemd[1]: mariadb.service changed start-pre -> failed
Jul 02 09:55:00 stdb01 systemd[1]: Job mariadb.service/start finished, result=failed
Jul 02 09:55:00 stdb01 systemd[1]: Failed to start MariaDB database server.
Jul 02 09:55:00 stdb01 systemd[1]: Unit mariadb.service entered failed state.
Jul 02 09:55:00 stdb01 systemd[1]: mariadb.service failed.
Jul 02 09:55:00 stdb01 systemd[1]: mariadb.service: cgroup is empty

# I tried enabling it
systemctl enable mariadb			# errored
sudo systemctl enable mariadb		# did not seem to error

# However when I try to verify status again, still showed failed
systemctl status mariadb

# so this is the time I reosrted to searching the net and the community -- KodeKloud Community or KKC
# the KKC showed one answer that suggested to check /var/lib
ls -l /var/lib

# the output shows
[peter@stdb01 lib]$ ls -l /var/lib
total 48
drwxr-xr-x 2 root  root  4096 Jan 27 11:05 alternatives
drwxr-xr-x 2 root  root  4096 Mar 14  2019 dbus
drwxr-xr-x 2 root  root  4096 Apr 11  2018 games
drwxr-xr-x 2 root  root  4096 Nov  2  2018 initramfs
drwx------ 2 root  root  4096 Aug  1  2019 machines
drwxr-xr-x 2 root  root  4096 Apr 11  2018 misc
drwxr-xr-x 2 mysql mysql 4096 Aug  8  2019 mysqld				# different owner
drwxr-xr-x 1 root  root  4096 Jul  2 09:33 rpm
drwxr-xr-x 2 root  root  4096 Apr 11  2018 rpm-state
drwxr-xr-x 4 root  root  4096 Oct 15  2019 stateless
drwxr-xr-x 4 root  root  4096 Aug  1  2019 systemd
drwxr-xr-x 6 root  root  4096 Jan 27 11:05 yum
[peter@stdb01 lib]$

# so I tried accessing mysql directory
cd /mysqld				# errored
# sudo cd /mysqld			# can't get in.

# now the KKC article suggests chhanging ownership of the directory 
# now I tried different command combinations
[peter@stdb01 lib]$ chown -hR root /u		
chown: cannot access ‘/u’: No such file or directory
[peter@stdb01 lib]$ chown -hR root /mysqld
chown: cannot access ‘/mysqld’: No such file or directory
[peter@stdb01 lib]$
[peter@stdb01 lib]$ sudo chown -hR root /mysqld
chown: cannot access ‘/mysqld’: No such file or directory
[peter@stdb01 lib]$
[peter@stdb01 lib]$ sudo chown -hR root mysqld					
[peter@stdb01 lib]$ sudo chown -hR root mysqld:mysql
chown: cannot access ‘mysqld:mysql’: No such file or directory
[peter@stdb01 lib]$
[peter@stdb01 lib]$ chown root:root /mysqld
chown: cannot access ‘/mysqld’: No such file or directory
[peter@stdb01 lib]$ sudo chown root:root /mysqld
chown: cannot access ‘/mysqld’: No such file or directory
[peter@stdb01 lib]$ sudo chown root:root mysqld					# this one worked
[peter@stdb01 lib]$
[peter@stdb01 lib]$ ls -l //var/lib								# so checking again
total 48
drwxr-xr-x 2 root root 4096 Jan 27 11:05 alternatives
drwxr-xr-x 2 root root 4096 Mar 14  2019 dbus
drwxr-xr-x 2 root root 4096 Apr 11  2018 games
drwxr-xr-x 2 root root 4096 Nov  2  2018 initramfs
drwx------ 2 root root 4096 Aug  1  2019 machines
drwxr-xr-x 2 root root 4096 Apr 11  2018 misc	
drwxr-xr-x 2 root root 4096 Aug  8  2019 mysqld					# now shows root:root
drwxr-xr-x 1 root root 4096 Jul  2 09:33 rpm
drwxr-xr-x 2 root root 4096 Apr 11  2018 rpm-state

-----------------------------------------------------------------------------------------------------------------

# So I actually failed at this task. My mistake was I did not open a duplicate task dashboard in another tab.
# Will retry this again

REFERENCE: https://community.kodekloud.com/t/issue-with-mariadb-troubleshooting-task/2954

-----------------------------------------------------------------------------------------------------------------

# LESSON LEARNED:

1. Once you fail the lab, you will not be able to retry it again afterward. You will have to wait for it to be assigned   to you again in the future.

2. Make it a practice nextime to open a duplicate task dashboard in another tab.
   This is in case you fail thee lab the first time, you can still retry the lab on the second tab.
   
3. After the timer stops, you still have 5 minutes to continue your work. Make sure to use this time wisely.
   Try to resolve or do the remaining steps within this 5 minutes.
   
4. Do not spend too much time on the documentation. Solve the issue/task first and then once everything is working,
   then do the documentation. Do not do the documentation while the clock is running.
   You will have plenty of time doing the documentation after the lab is solved and the time has finished.

------------------------------------------------------------------------------------------------------------------------
