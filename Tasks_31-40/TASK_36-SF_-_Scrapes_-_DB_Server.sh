
-----------------------------------------------------------------------------------------------------------------

# SUPPORTING FILE 

# This is a supporting file for the Task of the same name.
# This may contain configurations/config file.
# Basically, any file that is edited/created/modified through the 'vi' or 'nano' command will appear here.
# Note that there may be more than one supporting files for the Task at hand.

-----------------------------------------------------------------------------------------------------------------

TASK 36 - SupportFile - Install and Configure PostgreSQL


thor@jump_host /$ sshpass -p '******' ssh -o StrictHostKeyChecking=no  peter@172.16.239.10Warning: Permanently added '172.16.239.10' (ECDSA) to the list of known hosts.
sudo su -******[peter@stdb01 ~]$ sudo su -

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for peter:
[root@stdb01 ~]#
[root@stdb01 ~]# yum install -y postgresql-server postgresql-contribLoaded plugins: fastestmirror, ovl
Determining fastest mirrors
 * base: centosmirror.netcup.net
 * extras: mirror.checkdomain.de
 * updates: centosmirror.netcup.net
base                                                                     | 3.6 kB  00:00:00
extras                                                                   | 2.9 kB  00:00:00
updates                                                                  | 2.9 kB  00:00:00
(1/4): base/7/x86_64/group_gz                                            | 153 kB  00:00:00
(2/4): extras/7/x86_64/primary_db                                        | 206 kB  00:00:00
(3/4): base/7/x86_64/primary_db                                          | 6.1 MB  00:00:00
(4/4): updates/7/x86_64/primary_db                                       | 4.5 MB  00:00:00
Resolving Dependencies
--> Running transaction check
---> Package postgresql-contrib.x86_64 0:9.2.24-4.el7_8 will be installed
--> Processing Dependency: postgresql-libs(x86-64) = 9.2.24-4.el7_8 for package: postgresql-contrib-9.2.24-4.el7_8.x86_64
--> Processing Dependency: postgresql(x86-64) = 9.2.24-4.el7_8 for package: postgresql-contrib-9.2.24-4.el7_8.x86_64
--> Processing Dependency: libxslt.so.1(LIBXML2_1.0.22)(64bit) for package: postgresql-contrib-9.2.24-4.el7_8.x86_64
--> Processing Dependency: libxslt.so.1(LIBXML2_1.0.18)(64bit) for package: postgresql-contrib-9.2.24-4.el7_8.x86_64
--> Processing Dependency: libxslt.so.1(LIBXML2_1.0.11)(64bit) for package: postgresql-contrib-9.2.24-4.el7_8.x86_64
--> Processing Dependency: libxslt.so.1()(64bit) for package: postgresql-contrib-9.2.24-4.el7_8.x86_64
--> Processing Dependency: libpq.so.5()(64bit) for package: postgresql-contrib-9.2.24-4.el7_8.x86_64
--> Processing Dependency: libossp-uuid.so.16()(64bit) for package: postgresql-contrib-9.2.24-4.el7_8.x86_64
---> Package postgresql-server.x86_64 0:9.2.24-4.el7_8 will be installed
--> Processing Dependency: systemd-sysv for package: postgresql-server-9.2.24-4.el7_8.x86_64
--> Running transaction check
---> Package libxslt.x86_64 0:1.1.28-5.el7 will be installed
---> Package postgresql.x86_64 0:9.2.24-4.el7_8 will be installed
---> Package postgresql-libs.x86_64 0:9.2.24-4.el7_8 will be installed
---> Package systemd-sysv.x86_64 0:219-73.el7_8.9 will be installed
--> Processing Dependency: systemd = 219-73.el7_8.9 for package: systemd-sysv-219-73.el7_8.9.x86_64
---> Package uuid.x86_64 0:1.6.2-26.el7 will be installed
--> Running transaction check
---> Package systemd.x86_64 0:219-62.el7_6.9 will be updated
---> Package systemd.x86_64 0:219-73.el7_8.9 will be an update
--> Processing Dependency: systemd-libs = 219-73.el7_8.9 for package: systemd-219-73.el7_8.9.x86_64
--> Running transaction check
---> Package systemd-libs.x86_64 0:219-62.el7_6.9 will be updated
---> Package systemd-libs.x86_64 0:219-73.el7_8.9 will be an update
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================================
 Package                      Arch             Version                  Repository         Size
================================================================================================
Installing:
 postgresql-contrib           x86_64           9.2.24-4.el7_8           updates           552 k
 postgresql-server            x86_64           9.2.24-4.el7_8           updates           3.8 M
Installing for dependencies:
 libxslt                      x86_64           1.1.28-5.el7             base              242 k
 postgresql                   x86_64           9.2.24-4.el7_8           updates           3.0 M
 postgresql-libs              x86_64           9.2.24-4.el7_8           updates           234 k
 systemd-sysv                 x86_64           219-73.el7_8.9           updates            94 k
 uuid                         x86_64           1.6.2-26.el7             base               55 k
Updating for dependencies:
 systemd                      x86_64           219-73.el7_8.9           updates           5.1 M
 systemd-libs                 x86_64           219-73.el7_8.9           updates           416 k

Transaction Summary
================================================================================================
Install  2 Packages (+5 Dependent packages)
Upgrade             ( 2 Dependent packages)

Total download size: 13 M
Downloading packages:
Delta RPMs disabled because /usr/bin/applydeltarpm not installed.
(1/9): libxslt-1.1.28-5.el7.x86_64.rpm                                   | 242 kB  00:00:00
(2/9): postgresql-contrib-9.2.24-4.el7_8.x86_64.rpm                      | 552 kB  00:00:00
(3/9): postgresql-libs-9.2.24-4.el7_8.x86_64.rpm                         | 234 kB  00:00:00
(4/9): postgresql-9.2.24-4.el7_8.x86_64.rpm                              | 3.0 MB  00:00:00
(5/9): postgresql-server-9.2.24-4.el7_8.x86_64.rpm                       | 3.8 MB  00:00:00
(6/9): systemd-219-73.el7_8.9.x86_64.rpm                                 | 5.1 MB  00:00:00
(7/9): systemd-sysv-219-73.el7_8.9.x86_64.rpm                            |  94 kB  00:00:00
(8/9): uuid-1.6.2-26.el7.x86_64.rpm                                      |  55 kB  00:00:00
(9/9): systemd-libs-219-73.el7_8.9.x86_64.rpm                            | 416 kB  00:00:00
------------------------------------------------------------------------------------------------
Total                                                            28 MB/s |  13 MB  00:00:00
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : postgresql-libs-9.2.24-4.el7_8.x86_64                                       1/11
  Installing : postgresql-9.2.24-4.el7_8.x86_64                                            2/11
  Installing : uuid-1.6.2-26.el7.x86_64                                                    3/11
  Updating   : systemd-libs-219-73.el7_8.9.x86_64                                          4/11
  Updating   : systemd-219-73.el7_8.9.x86_64                                               5/11
  Installing : systemd-sysv-219-73.el7_8.9.x86_64                                          6/11
  Installing : libxslt-1.1.28-5.el7.x86_64                                                 7/11
  Installing : postgresql-contrib-9.2.24-4.el7_8.x86_64                                    8/11
  Installing : postgresql-server-9.2.24-4.el7_8.x86_64                                     9/11
  Cleanup    : systemd-219-62.el7_6.9.x86_64                                              10/11
  Cleanup    : systemd-libs-219-62.el7_6.9.x86_64                                         11/11
  Verifying  : postgresql-9.2.24-4.el7_8.x86_64                                            1/11
  Verifying  : systemd-sysv-219-73.el7_8.9.x86_64                                          2/11
  Verifying  : postgresql-contrib-9.2.24-4.el7_8.x86_64                                    3/11
  Verifying  : libxslt-1.1.28-5.el7.x86_64                                                 4/11
  Verifying  : systemd-libs-219-73.el7_8.9.x86_64                                          5/11
  Verifying  : uuid-1.6.2-26.el7.x86_64                                                    6/11
  Verifying  : postgresql-server-9.2.24-4.el7_8.x86_64                                     7/11
  Verifying  : postgresql-libs-9.2.24-4.el7_8.x86_64                                       8/11
  Verifying  : systemd-219-73.el7_8.9.x86_64                                               9/11
  Verifying  : systemd-219-62.el7_6.9.x86_64                                              10/11
  Verifying  : systemd-libs-219-62.el7_6.9.x86_64                                         11/11

Installed:
  postgresql-contrib.x86_64 0:9.2.24-4.el7_8      postgresql-server.x86_64 0:9.2.24-4.el7_8

Dependency Installed:
  libxslt.x86_64 0:1.1.28-5.el7                    postgresql.x86_64 0:9.2.24-4.el7_8
  postgresql-libs.x86_64 0:9.2.24-4.el7_8          systemd-sysv.x86_64 0:219-73.el7_8.9
  uuid.x86_64 0:1.6.2-26.el7

Dependency Updated:
  systemd.x86_64 0:219-73.el7_8.9              systemd-libs.x86_64 0:219-73.el7_8.9

Complete!
[root@stdb01 ~]#
[root@stdb01 ~]# postgresql-setup initdb
Initializing database ... OK

[root@stdb01 ~]#
[root@stdb01 ~]# systemctl enable postgresql && systemctl start postgresql && systemctl status postgresql
Created symlink from /etc/systemd/system/multi-user.target.wants/postgresql.service to /usr/lib/systemd/system/postgresql.service.
● postgresql.service - PostgreSQL database server
   Loaded: loaded (/usr/lib/systemd/system/postgresql.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2020-09-08 17:31:00 UTC; 6ms ago
  Process: 334 ExecStart=/usr/bin/pg_ctl start -D ${PGDATA} -s -o -p ${PGPORT} -w -t 300 (code=exited, status=0/SUCCESS)
  Process: 329 ExecStartPre=/usr/bin/postgresql-check-db-dir ${PGDATA} (code=exited, status=0/SUCCESS)
 Main PID: 336 (postgres)
   CGroup: /docker/425c146ad3e0723033f009565c1b6fa56e269d891e24fd05a958fc962b9a399e/system.slice/postgresql.service
           ├─336 /usr/bin/postgres -D /var/lib/pgsql/data -p 5432
           ├─337 postgres: logger process
           ├─339 postgres: checkpointer process
           ├─340 postgres: writer process
           ├─341 postgres: wal writer process
           ├─342 postgres: autovacuum launcher process
           └─343 postgres: stats collector process

Sep 08 17:30:59 stdb01 systemd[1]: Starting PostgreSQL database server...
Sep 08 17:30:59 stdb01 pg_ctl[334]: LOG:  could not bind IPv6 socket: Cannot assign reques...ess
Sep 08 17:30:59 stdb01 pg_ctl[334]: HINT:  Is another postmaster already running on port 5...ry.
Sep 08 17:31:00 stdb01 systemd[1]: Started PostgreSQL database server.
Hint: Some lines were ellipsized, use -l to show in full.
[root@stdb01 ~]#
[root@stdb01 ~]# sudo -u postgres psql
could not change directory to "/root"
psql (9.2.24)
Type "help" for help.

postgres=#
postgres=# create user kodekloud_rin   with encrypted password 'B4zNgHA7Ya';
CREATE ROLE
postgres=#
postgres=# create database kodekloud_db9 owner kodekloud_rin;
CREATE DATABASE
postgres=#
postgres=# grant all privileges on database kodekloud_db9 to kodekloud_rin ;
GRANT
postgres=# ^Z
[1]+  Stopped                 sudo -u postgres psql
[root@stdb01 ~]#
[root@stdb01 ~]# vi /var/lib/pgsql/data/postgresql.conf
[root@stdb01 ~]# vi /var/lib/pgsql/data/pg_hba.conf
[root@stdb01 ~]#
[root@stdb01 ~]#
[root@stdb01 ~]# sudo systemctl restart postgresql

[root@stdb01 ~]#
[root@stdb01 ~]# systemctl enable postgresql && systemctl start postgresql && systemctl status postgresql
● postgresql.service - PostgreSQL database server
   Loaded: loaded (/usr/lib/systemd/system/postgresql.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2020-09-08 17:34:22 UTC; 53ms ago
 Main PID: 366 (postgres)
   CGroup: /docker/425c146ad3e0723033f009565c1b6fa56e269d891e24fd05a958fc962b9a399e/system.slice/postgresql.service
           ├─366 /usr/bin/postgres -D /var/lib/pgsql/data -p 5432
           ├─367 postgres: logger process
           ├─369 postgres: checkpointer process
           ├─370 postgres: writer process
           ├─371 postgres: wal writer process
           ├─372 postgres: autovacuum launcher process
           └─373 postgres: stats collector process

Sep 08 17:34:20 stdb01 systemd[1]: Starting PostgreSQL database server...
Sep 08 17:34:21 stdb01 pg_ctl[364]: LOG:  could not bind IPv6 socket: Cannot assign reques...ess
Sep 08 17:34:21 stdb01 pg_ctl[364]: HINT:  Is another postmaster already running on port 5...ry.
Sep 08 17:34:22 stdb01 systemd[1]: Started PostgreSQL database server.
Hint: Some lines were ellipsized, use -l to show in full.
[root@stdb01 ~]#
[root@stdb01 ~]#
[root@stdb01 ~]# psql -U kodekloud_rin  -d kodekloud_db9 -h 127.0.0.1 -W
Password for user kodekloud_rin:
psql (9.2.24)
Type "help" for help.

kodekloud_db9=> \l
                                           List of databases
     Name      |     Owner     | Encoding |   Collate   |    Ctype    |        Access privileges

---------------+---------------+----------+-------------+-------------+-------------------------
--------
 kodekloud_db9 | kodekloud_rin | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =Tc/kodekloud_rin
       +
               |               |          |             |             | kodekloud_rin=CTc/kodekl
oud_rin
 postgres      | postgres      | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 template0     | postgres      | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres
       +
               |               |          |             |             | postgres=CTc/postgres
 template1     | postgres      | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres
       +
               |               |          |             |             | postgres=CTc/postgres
(4 rows)

kodekloud_db9=> ^Z
[2]+  Stopped                 psql -U kodekloud_rin -d kodekloud_db9 -h 127.0.0.1 -W
[root@stdb01 ~]#
[root@stdb01 ~]#
[root@stdb01 ~]# psql -U kodekloud_rin  -d kodekloud_db9 -h localhost -W
Password for user kodekloud_rin:
psql (9.2.24)
Type "help" for help.

kodekloud_db9=>
kodekloud_db9=> \l
                                           List of databases
     Name      |     Owner     | Encoding |   Collate   |    Ctype    |        Access privileges

---------------+---------------+----------+-------------+-------------+-------------------------
--------
 kodekloud_db9 | kodekloud_rin | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =Tc/kodekloud_rin
       +
               |               |          |             |             | kodekloud_rin=CTc/kodekl
oud_rin
 postgres      | postgres      | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 template0     | postgres      | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres
       +
               |               |          |             |             | postgres=CTc/postgres
 template1     | postgres      | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres
       +
               |               |          |             |             | postgres=CTc/postgres
(4 rows)

kodekloud_db9=>
kodekloud_db9=> Connection to host01 closed by remote host.
Connection to host01 closed.

The environment has expired.

Please refresh to get a new environment.