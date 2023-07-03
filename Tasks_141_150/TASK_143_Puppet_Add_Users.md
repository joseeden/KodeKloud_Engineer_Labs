
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-07-03 16:24:13    
Finished: &nbsp;&nbsp;2023-07-03 16:36:35   

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 143: Puppet Add Users

## Requirements

A new teammate has joined the Nautilus application development team, the application development team has asked the DevOps team to create a new user account for the new teammate on application server 2 in Stratos Datacenter. The task needs to be performed using Puppet only. You can find more details below about the task.

- Create a Puppet programming file **demo.pp** under **/etc/puppetlabs/code/environments/production/manifests** directory on master node i.e Jump Server, and using Puppet user resource **add a user on all app servers** as mentioned below.

- Create a user **ravi** and set its **UID to 1851** on Puppet agent nodes 2 i.e App Servers 2.

Notes: :

- Please make sure to run the puppet agent test using sudo on agent nodes, otherwise you can face certificate issues. In that case you will have to clean the certificates first and then you will be able to run the puppet agent test.

- Before clicking on the Check button please make sure to verify puppet server and puppet agent services are up and running on the respective servers, also please make sure to run puppet agent test to apply/test the changes manually first.

- Please note that once lab is loaded, the puppet server service should start automatically on puppet master server, however it can take upto 2-3 minutes to start.


------------------------------

## Steps

From the jumphost, switch to root and proceed to the specified directory. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
sudo su -
cd /etc/puppetlabs/code/environments/production/manifests/
```

Create the Puppet file **demo.pp** based on the requirements.

```puppet
class user_creator {
    user { 'ravi':
            ensure   => present,
            uid => 1851,
        }
    }

node 'stapp01.stratos.xfusioncorp.com', 'stapp02.stratos.xfusioncorp.com', 'stapp03.stratos.xfusioncorp.com' {
include user_creator
}  
```

Validate the Puppet file.

```bash
puppet parser validate demo.pp 
```

Login to the app server and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

Pull the configuration from the Puppet server and then verify that the user was created. You need to do this on all three app server.

```bash
[thor@jumphost]$ sshpass -p  '*******' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo su  
*******

root@stapp01 tony]# puppet agent -tv
Info: Using configured environment 'production'
Info: Retrieving pluginfacts
Info: Retrieving plugin
Info: Retrieving locales
Info: Caching catalog for stapp01.stratos.xfusioncorp.com
Info: Applying configuration version '1688373192'
Notice: /Stage[main]/User_creator/User[ravi]/ensure: created
Notice: Applied catalog in 0.06 seconds
[root@stapp01 tony]# 
[root@stapp01 tony]# cat /etc/passwd | grep ravi
ravi:x:1851:1851::/home/ravi:/bin/bash  
```
```bash
[thor@jumphost]$ sshpass -p  '*******' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
sudo su  
*******

[root@stapp02 steve]# puppet agent -tv
Info: Using configured environment 'production'
Info: Retrieving pluginfacts
Info: Retrieving plugin
Info: Retrieving locales
Info: Caching catalog for stapp02.stratos.xfusioncorp.com
Info: Applying configuration version '1688373267'
Notice: /Stage[main]/User_creator/User[ravi]/ensure: created
Notice: Applied catalog in 0.07 seconds
[root@stapp02 steve]# 
[root@stapp02 steve]# cat /etc/passwd | grep ravi
ravi:x:1851:1851::/home/ravi:/bin/bash  
```
```bash
[thor@jumphost]$ sshpass -p  '*******' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
sudo su  
*******

[root@stapp03 banner]# puppet agent -tv
Info: Using configured environment 'production'
Info: Retrieving pluginfacts
Info: Retrieving plugin
Info: Retrieving locales
Info: Caching catalog for stapp03.stratos.xfusioncorp.com
Info: Applying configuration version '1688373310'
Notice: /Stage[main]/User_creator/User[ravi]/ensure: created
Notice: Applied catalog in 0.54 seconds
[root@stapp03 banner]# 
[root@stapp03 banner]# cat /etc/passwd | grep ravi
ravi:x:1851:1851::/home/ravi:/bin/bash
```

------------------------------

## Resources