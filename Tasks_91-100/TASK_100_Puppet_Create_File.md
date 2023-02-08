
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-02-08 19:48:10  
Finished: &nbsp;&nbsp;2023-02-08 20:17:51

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 100: Puppet Create a FIle

## Requirements

The Puppet master and Puppet agent nodes have been set up by the Nautilus DevOps team so they can perform testing. In Stratos DC all app servers have been configured as Puppet agent nodes. Below are details about the testing scenario they want to proceed with.

- Use Puppet file resource and perform the below given task:

- Create a Puppet programming file **ecommerce.pp** under /etc/puppetlabs/code/environments/production/manifests directory on master node i.e Jump Server.

- Using /etc/puppetlabs/code/environments/production/manifests/ecommerce.pp create a file **media.txt** under **/opt/sysops** directory on **App Server 2**.

Notes: :- Please make sure to run the puppet agent test using sudo on agent nodes, otherwise you can face certificate issues. In that case you will have to clean the certificates first and then you will be able to run the puppet agent test.

:- Before clicking on the Check button please make sure to verify puppet server and puppet agent services are up and running on the respective servers, also please make sure to run puppet agent test to apply/test the changes manually first.

:- Please note that once lab is loaded, the puppet server service should start automatically on puppet master server, however it can take upto 2-3 minutes to start.

------------------------------

## Steps

Proeed to the specified directory.

```bash
cd /etc/puppetlabs/code/environments/production/manifests/ 
```


Create the Puppet programming file **ecommerce.pp** based on the requirements. You may need to switch to root to create the Puppet file. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```yaml
class file_creator {
  # Now create media.txt under /opt/sysops
  file { '/opt/sysops/media.txt':
    ensure => 'present',
  }
}
 node 'stapp02.stratos.xfusioncorp.com' {
  include file_creator
}
```


Validate the Puppet file.

```bash
puppet parser validate ecommerce.pp 
```

Log-in to the app server and switch to root.
```bash
sshpass -p  'Am3ric@' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
sudo su 
```

Run Puppet agent to pull the configuration from puppet server.

```bash
$ puppet agent -tv

Info: Using configured environment 'production'
Info: Retrieving pluginfacts
Info: Retrieving plugin
Info: Retrieving locales
Info: Caching catalog for stapp02.stratos.xfusioncorp.com
Info: Applying configuration version '1675858514'
Notice: /Stage[main]/File_creator/File[/opt/sysops/media.txt]/ensure: created
Notice: Applied catalog in 0.12 second


```

To verify that the task was correctly done, check the file **ecommerce.txt**.

```bash
[root@stapp02 steve]# ls -lrt /opt/sysops/media.txt

-rw-r--r-- 1 root root 0 Feb  8 12:15 /opt/sysops/media.txt
```

------------------------------

## Resources

- https://www.shawonruet.com/2022/08/puppet-create-file-kodekloud.html
- https://www.nbtechsupport.co.in/2021/07/puppet-create-file.html
