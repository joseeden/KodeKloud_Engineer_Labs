
-----------------------------------------------------------------------------------------------------------------

# SUPPORTING FILE 

# This is a supporting file for the Task of the same name.
# This may contain configurations/config file.
# Basically, any file that is edited/created/modified through the 'vi' or 'nano' command will appear here.
# Note that there may be more than one supporting files for the Task at hand.

-----------------------------------------------------------------------------------------------------------------

TASK 50 - SF - Scrapes - DB Server.sh


thor@jump_host /$ sshpass -p '******' ssh -o StrictHostKeyChecking=no  peter@172.16.239.10
Warning: Permanently added '172.16.239.10' (ECDSA) to the list of known hosts.sudo su -
******[peter@stdb01 ~]$ sudo su -

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for peter:

[root@stdb01 ~]#
[root@stdb01 ~]# yum install -y postgresql-server postgresql-contrib
Loaded plugins: fastestmirror, ovl
Determining fastest mirrors * base: mirror.checkdomain.de
 * extras: mirror.ratiokontakt.de
 * updates: mirror.softaculous.com

base                                                                     | 3.6 kB  00:00:00
extras                                                                   | 2.9 kB  00:00:00
updates                                                                  | 2.9 kB  00:00:00

(1/4): base/7/x86_64/group_gz                                            | 153 kB  00:00:00
(2/4): extras/7/x86_64/primary_db                                        | 222 kB  00:00:00

(3/4): updates/7/x86_64/primary_db                                       | 3.7 MB  00:00:00
(4/4): base/7/x86_64/primary_db                                          | 6.1 MB  00:00:01
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
---> Package libxslt.x86_64 0:1.1.28-6.el7 will be installed
---> Package postgresql.x86_64 0:9.2.24-4.el7_8 will be installed
---> Package postgresql-libs.x86_64 0:9.2.24-4.el7_8 will be installed
---> Package systemd-sysv.x86_64 0:219-78.el7_9.2 will be installed
--> Processing Dependency: systemd = 219-78.el7_9.2 for package: systemd-sysv-219-78.el7_9.2.x86_64
---> Package uuid.x86_64 0:1.6.2-26.el7 will be installed
--> Running transaction check
---> Package systemd.x86_64 0:219-62.el7_6.9 will be updated
---> Package systemd.x86_64 0:219-78.el7_9.2 will be an update
--> Processing Dependency: systemd-libs = 219-78.el7_9.2 for package: systemd-219-78.el7_9.2.x86_64
--> Running transaction check
---> Package systemd-libs.x86_64 0:219-62.el7_6.9 will be updated
---> Package systemd-libs.x86_64 0:219-78.el7_9.2 will be an update
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================================
 Package                      Arch             Version                  Repository         Size
================================================================================================
Installing:
 postgresql-contrib           x86_64           9.2.24-4.el7_8           base              552 k
 postgresql-server            x86_64           9.2.24-4.el7_8           base              3.8 M
Installing for dependencies:
 libxslt                      x86_64           1.1.28-6.el7             base              242 k
 postgresql                   x86_64           9.2.24-4.el7_8           base              3.0 M
 postgresql-libs              x86_64           9.2.24-4.el7_8           base              234 k
 systemd-sysv                 x86_64           219-78.el7_9.2           updates            96 k
 uuid                         x86_64           1.6.2-26.el7             base               55 k
Updating for dependencies:
 systemd                      x86_64           219-78.el7_9.2           updates           5.1 M
 systemd-libs                 x86_64           219-78.el7_9.2           updates           418 k

Transaction Summary
================================================================================================
Install  2 Packages (+5 Dependent packages)
Upgrade             ( 2 Dependent packages)

Total download size: 13 M
Downloading packages:
Delta RPMs disabled because /usr/bin/applydeltarpm not installed.
(1/9): libxslt-1.1.28-6.el7.x86_64.rpm                                   | 242 kB  00:00:00
(2/9): postgresql-contrib-9.2.24-4.el7_8.x86_64.rpm                      | 552 kB  00:00:00
(3/9): postgresql-libs-9.2.24-4.el7_8.x86_64.rpm                         | 234 kB  00:00:00
(4/9): systemd-libs-219-78.el7_9.2.x86_64.rpm                            | 418 kB  00:00:00
(5/9): systemd-sysv-219-78.el7_9.2.x86_64.rpm                            |  96 kB  00:00:00
(6/9): systemd-219-78.el7_9.2.x86_64.rpm                                 | 5.1 MB  00:00:00
(7/9): postgresql-9.2.24-4.el7_8.x86_64.rpm                              | 3.0 MB  00:00:01
(8/9): postgresql-server-9.2.24-4.el7_8.x86_64.rpm                       | 3.8 MB  00:00:01
(9/9): uuid-1.6.2-26.el7.x86_64.rpm                                      |  55 kB  00:00:00
------------------------------------------------------------------------------------------------
Total                                                            10 MB/s |  13 MB  00:00:01
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : postgresql-libs-9.2.24-4.el7_8.x86_64                                       1/11
  Installing : postgresql-9.2.24-4.el7_8.x86_64                                            2/11
  Updating   : systemd-libs-219-78.el7_9.2.x86_64                                          3/11
  Updating   : systemd-219-78.el7_9.2.x86_64                                               4/11
  Installing : systemd-sysv-219-78.el7_9.2.x86_64                                          5/11
  Installing : uuid-1.6.2-26.el7.x86_64                                                    6/11
  Installing : libxslt-1.1.28-6.el7.x86_64                                                 7/11
  Installing : postgresql-contrib-9.2.24-4.el7_8.x86_64                                    8/11
  Installing : postgresql-server-9.2.24-4.el7_8.x86_64                                     9/11
  Cleanup    : systemd-219-62.el7_6.9.x86_64                                              10/11
  Cleanup    : systemd-libs-219-62.el7_6.9.x86_64                                         11/11
  Verifying  : postgresql-9.2.24-4.el7_8.x86_64                                            1/11
  Verifying  : systemd-sysv-219-78.el7_9.2.x86_64                                          2/11
  Verifying  : postgresql-contrib-9.2.24-4.el7_8.x86_64                                    3/11
  Verifying  : libxslt-1.1.28-6.el7.x86_64                                                 4/11
  Verifying  : uuid-1.6.2-26.el7.x86_64                                                    5/11
  Verifying  : systemd-libs-219-78.el7_9.2.x86_64                                          6/11
  Verifying  : postgresql-server-9.2.24-4.el7_8.x86_64                                     7/11
  Verifying  : postgresql-libs-9.2.24-4.el7_8.x86_64                                       8/11
  Verifying  : systemd-219-78.el7_9.2.x86_64                                               9/11
  Verifying  : systemd-219-62.el7_6.9.x86_64                                              10/11
  Verifying  : systemd-libs-219-62.el7_6.9.x86_64                                         11/11

Installed:
  postgresql-contrib.x86_64 0:9.2.24-4.el7_8      postgresql-server.x86_64 0:9.2.24-4.el7_8

Dependency Installed:
  libxslt.x86_64 0:1.1.28-6.el7                    postgresql.x86_64 0:9.2.24-4.el7_8
  postgresql-libs.x86_64 0:9.2.24-4.el7_8          systemd-sysv.x86_64 0:219-78.el7_9.2
  uuid.x86_64 0:1.6.2-26.el7

Dependency Updated:
  systemd.x86_64 0:219-78.el7_9.2              systemd-libs.x86_64 0:219-78.el7_9.2

Complete!
[root@stdb01 ~]# postgresql-setup initdb
Initializing database ... OK

[root@stdb01 ~]# systemctl enable postgresql && systemctl start postgresql && systemctl status postgresql
Created symlink from /etc/systemd/system/multi-user.target.wants/postgresql.service to /usr/lib/systemd/system/postgresql.service.
● postgresql.service - PostgreSQL database server
   Loaded: loaded (/usr/lib/systemd/system/postgresql.service; enabled; vendor preset: disabled)
   Active: active (running) since Sat 2020-11-21 16:39:44 UTC; 6ms ago
  Process: 337 ExecStart=/usr/bin/pg_ctl start -D ${PGDATA} -s -o -p ${PGPORT} -w -t 300 (code=exited, status=0/SUCCESS)
  Process: 332 ExecStartPre=/usr/bin/postgresql-check-db-dir ${PGDATA} (code=exited, status=0/SUCCESS)
 Main PID: 339 (postgres)
   CGroup: /docker/f50ded42785126a78bc46c5d5cd376b71aff7de94b79be4d0604af2932b6edb4/system.slice/postgresql.service
           ├─339 /usr/bin/postgres -D /var/lib/pgsql/data -p 5432
           ├─340 postgres: logger process
           ├─342 postgres: checkpointer process
           ├─343 postgres: writer process
           ├─344 postgres: wal writer process
           ├─345 postgres: autovacuum launcher process
           └─346 postgres: stats collector process

Nov 21 16:39:43 stdb01 systemd[1]: Starting PostgreSQL database server...
Nov 21 16:39:43 stdb01 pg_ctl[337]: LOG:  could not bind IPv6 socket: Cannot assign reques...ess
Nov 21 16:39:43 stdb01 pg_ctl[337]: HINT:  Is another postmaster already running on port 5...ry.
Nov 21 16:39:44 stdb01 systemd[1]: Started PostgreSQL database server.
Hint: Some lines were ellipsized, use -l to show in full.
[root@stdb01 ~]#
[root@stdb01 ~]#
[root@stdb01 ~]# sudo -u postgres psql
could not change directory to "/root"
psql (9.2.24)
Type "help" for help.

postgres=#
postgres=# create user kodekloud_cap with encrypted password 'dCV3szSGNA';
CREATE ROLE
postgres=# create database kodekloud_db10 owner kodekloud_cap;
CREATE DATABASE
postgres=# grant all privileges on database kodekloud_db10 to kodekloud_cap ;
GRANT
postgres=# exit
postgres-#
postgres-# vi /var/lib/pgsql/data/postgresql.conf
postgres-# exit
postgres-# \q
[root@stdb01 ~]#
[root@stdb01 ~]#
[root@stdb01 ~]# vi /var/lib/pgsql/data/postgresql.conf
[root@stdb01 ~]# vi /var/lib/pgsql/data/postgresql.conf
[root@stdb01 ~]# vi /var/lib/pgsql/data/pg_hba.conf
[root@stdb01 ~]# vi /var/lib/pgsql/data/pg_hba.conf
[root@stdb01 ~]# sudo systemctl restart postgresql
[root@stdb01 ~]# systemctl enable postgresql && systemctl start postgresql && systemctl status postgresql
● postgresql.service - PostgreSQL database server
   Loaded: loaded (/usr/lib/systemd/system/postgresql.service; enabled; vendor preset: disabled)
   Active: active (running) since Sat 2020-11-21 16:46:37 UTC; 3s ago
 Main PID: 374 (postgres)
   CGroup: /docker/f50ded42785126a78bc46c5d5cd376b71aff7de94b79be4d0604af2932b6edb4/system.slice/postgresql.service
           ├─374 /usr/bin/postgres -D /var/lib/pgsql/data -p 5432
           ├─375 postgres: logger process
           ├─377 postgres: checkpointer process
           ├─378 postgres: writer process
           ├─379 postgres: wal writer process
           ├─380 postgres: autovacuum launcher process
           └─381 postgres: stats collector process

Nov 21 16:46:36 stdb01 systemd[1]: Starting PostgreSQL database server...
Nov 21 16:46:36 stdb01 pg_ctl[372]: LOG:  could not bind IPv6 socket: Cannot assign reques...ess
Nov 21 16:46:36 stdb01 pg_ctl[372]: HINT:  Is another postmaster already running on port 5...ry.
Nov 21 16:46:37 stdb01 systemd[1]: Started PostgreSQL database server.
Hint: Some lines were ellipsized, use -l to show in full.
[root@stdb01 ~]#
[root@stdb01 ~]#
[root@stdb01 ~]# psql -U kodekloud_cap  -d kodekloud_db10 -h 127.0.0.1 -W
Password for user kodekloud_cap:
psql (9.2.24)
Type "help" for help.

kodekloud_db10=>
kodekloud_db10=> \q
[root@stdb01 ~]#
[root@stdb01 ~]#
[root@stdb01 ~]# psql -U kodekloud_cap  -d kodekloud_db10 -h localhost -W
Password for user kodekloud_cap:
psql (9.2.24)
Type "help" for help.

kodekloud_db10=>
kodekloud_db10=> \q
[root@stdb01 ~]# Connection to host01 closed by remote host.
Connection to host01 closed.

The environment has expired.

Please refresh to get a new environment.