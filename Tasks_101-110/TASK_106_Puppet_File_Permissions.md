
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-03-16 21:05:37  
Finished: &nbsp;&nbsp;2023-03-16 21:15:02

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 106: Puppet Setup File Permissions	

## Requirements

The Nautilus DevOps team has put some data on all app servers in Stratos DC. jump host is configured as Puppet master server, and all app servers are already been configured as Puppet agent nodes. The team needs to update the content of some of the exiting files, as well as need to update their permissions etc. Please find below more details about the task:

- Create a Puppet programming file **beta.pp** under **/etc/puppetlabs/code/environments/production/manifests** directory on the master node i.e Jump Server. Using puppet file resource, perform the below mentioned tasks.

- A file named **beta.txt** already exists under **/opt/dba** directory on **App Server 1**.

- Add content in beta.txt file on App Server 1:

    ```bash
    Welcome to xFusionCorp Industries! 
    ```
        
- Set its permissions to **0777**.

Notes: :

- Please make sure to run the puppet agent test using sudo on agent nodes, otherwise you can face certificate issues. In that case you will have to clean the certificates first and then you will be able to run the puppet agent test.

- Before clicking on the Check button please make sure to verify puppet server and puppet agent services are up and running on the respective servers, also please make sure to run puppet agent test to apply/test the changes manually first.

- Please note that once lab is loaded, the puppet server service should start automatically on puppet master server, however it can take upto 2-3 minutes to start.

------------------------------

## Steps


Proceed to the specified directory and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)


```bash
cd /etc/puppetlabs/code/environments/production/manifests
```

Create **beta.pp** based on requirements.

```bash
class file_modifier {

   # Update beta.txt under /opt/finance
   file { '/opt/dba/beta.txt':
     ensure => 'present',
     content => 'Welcome to xFusionCorp Industries!',
     mode => '0777',
   }
 }

 node 'stapp01.stratos.xfusioncorp.com' {
   include file_modifier
 }  
```

Validate the Puppet file.

```bash
puppet parser validate beta.pp
```

Log-in to the app server and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
sshpass -p  '**********' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo su
```

Run Puppet agent to pull the configuration from puppet server.

```bash
[root@stapp01 tony]# puppet agent -tv

Info: Using configured environment 'production'
Info: Retrieving pluginfacts
Info: Retrieving plugin
Info: Retrieving locales
Info: Caching catalog for stapp01.stratos.xfusioncorp.com
Info: Applying configuration version '1678972341'
Notice: Applied catalog in 0.02 seconds
```

To verify that the task was correctly done, check the permissions of the file and content.

```bash
[root@stapp01 tony]# ls -la /opt/dba/

total 12
drwxr-xr-x 2 root root 4096 Mar 16 13:11 .
drwxr-xr-x 1 root root 4096 Mar 16 13:07 ..
-rwxrwxrwx 1 root root   34 Mar 16 13:11 beta.txt
```
```bash
[root@stapp01 tony]# cat /opt/dba/beta.txt 

Welcome to xFusionCorp Industries!  
```

------------------------------

## Resources

- https://www.nbtechsupport.co.in/2021/04/puppet-setup-file-permissions.html