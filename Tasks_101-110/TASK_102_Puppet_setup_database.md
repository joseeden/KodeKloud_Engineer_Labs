
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-03-04 20:55:55  
Finished: &nbsp;&nbsp;2023-03-04 22:07:58

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 102: Puppet Setup Database

## Requirements

The Nautilus DevOps team had a meeting with development team last week to discuss about some new requirements for an application deployment. Team is working on to setup a mariadb database server on Nautilus DB Server in Stratos Datacenter. They want to setup the same using Puppet. Below you can find more details about the requirements:

- Create a puppet programming file **news.pp** under **/etc/puppetlabs/code/environments/production/manifests** directory on puppet master node i.e on Jump Server. 

- Define a class **mysql_database** in puppet programming code and perform below mentioned tasks:

- Install package **mariadb-server** (whichever version is available by default in yum repo) on puppet agent node i.e on **DB Server** also start its service.

- Create a database **kodekloud_db7** , a database user **kodekloud_top** and set password **TmPcZjtRQx** for this new user. 

- Also remember host should be localhost. 

- Finally grant some usual permissions like **select, update (or full)** ect to this newly created user on newly created database.

Notes:
- Please make sure to run the puppet agent test using sudo on agent nodes, otherwise you can face certificate issues. In that case you will have to clean the certificates first and then you will be able to run the puppet agent test.

- Before clicking on the Check button please make sure to verify puppet server and puppet agent services are up and running on the respective servers, also please make sure to run puppet agent test to apply/test the changes manually first.

- Please note that once lab is loaded, the puppet server service should start automatically on puppet master server, however it can take upto 2-3 minutes to start.

------------------------------

## Steps

On the jumphost, switch to root and proceed to the specified directory. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
sudo su 
cd /etc/puppetlabs/code/environments/production/manifests/ 
```

Create the **news.pp** file based on the requirements.

```bash
cat >  news.pp

class mysql_database {
    package {'mariadb-server':
      ensure => installed
    }

    service {'mariadb':
        ensure    => running,
        enable    => true,
    }    

    mysql::db { 'kodekloud_db7':
      user     => 'kodekloud_top',
      password => 'TmPcZjtRQx',
      host     => 'localhost',
      grant    => ['ALL'],
    }
}

node 'stdb01.stratos.xfusioncorp.com' {
  include mysql_database
}
```

Validate the Puppet file.

```bash
puppet parser validate news.pp
```

Log-in to the app server and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
sshpass -p '*********' ssh -o StrictHostKeyChecking=no  peter@172.16.239.10
```

Run Puppet agent to pull the configuration from puppet server.

```bash
[root@stdb01 ~]# puppet agent -tv 

Info: Using configured environment 'production'
Info: Retrieving pluginfacts
Info: Retrieving plugin
Info: Retrieving locales
Info: Loading facts
Info: Caching catalog for stdb01.stratos.xfusioncorp.com
Info: Applying configuration version '1677938035'
Notice: Applied catalog in 0.60 seconds
```

To verify that the task was correctly done, check if the service is installed and running. We can also try to log in to the database using the created user and database.

```bash
systemctl status mariadb  
```

```bash
[root@stdb01 ~]# mysql -u kodekloud_top -p kodekloud_db7 -h localhost
Enter password: 
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 54
Server version: 5.5.68-MariaDB MariaDB Server

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [kodekloud_db7]> 
MariaDB [kodekloud_db7]> 
```

------------------------------

## Resources

- https://kodekloud.com/community/t/puppet-setup-database/7791
- https://kodekloud.com/community/t/puppet-setup-database-failed/28501
