
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-06-11 20:58:49  
Finished: &nbsp;&nbsp;2023-06-11 21:08:04

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 132: Puppet Create Symlinks

## Requirements

Some directory structure in the Stratos Datacenter needs to be changed, there is a directory that needs to be linked to the default Apache document root. We need to accomplish this task using Puppet, as per the instructions given below:

Create a puppet programming file **blog.pp** under **/etc/puppetlabs/code/environments/production/manifests** directory on puppet master node i.e on Jump Server. Within that define a class symlink and perform below mentioned tasks:

Create a symbolic link through puppet programming code. The source path should be **/opt/security** and destination path should be **/var/www/html** on Puppet agents 1 i.e on App Servers 1.

Create a blank file **story.txt** under /opt/security directory on puppet agent 1 nodes i.e on App Servers 1.

Notes: 

- Please make sure to run the puppet agent test using sudo on agent nodes, otherwise you can face certificate issues. In that case you will have to clean the certificates first and then you will be able to run the puppet agent test.

- Before clicking on the Check button please make sure to verify puppet server and puppet agent services are up and running on the respective servers, also please make sure to run puppet agent test to apply/test the changes manually first.

- Please note that once lab is loaded, the puppet server service should start automatically on puppet master server, however it can take upto 2-3 minutes to start.

------------------------------

## Steps

In the jump host, switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
sudo su - 
```

Proceed to the specified directory.

```bash
cd  /etc/puppetlabs/code/environments/production/manifests
```

Create the **blog.pp** based on the requirements.

```bash
class symlink {
  # First create a symlink to /var/www/html
  file { '/opt/security':
    ensure => 'link',
    target => '/var/www/html',
  }

   # Now create story.txt under /opt/security
  file { '/opt/security/story.txt':
    ensure => 'present',
  }
}

node 'stapp01.stratos.xfusioncorp.com', 'stapp02.stratos.xfusioncorp.com', 'stapp03.stratos.xfusioncorp.com' {
  include symlink
}
```

Validate the Puppet file.

```bash
puppet parser validate blog.pp  
```

Login to the App server and switch to root.

```bash
sshpass -p  'Ir0nM@n' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo su -
```

Pull the configuration from the Puppet server.

```bash
[root@stapp01 ~]# puppet agent -tv  

Info: Using configured environment 'production'
Info: Retrieving pluginfacts
Info: Retrieving plugin
Info: Retrieving locales
Info: Caching catalog for stapp01.stratos.xfusioncorp.com
Info: Applying configuration version '1686488795'
Notice: /Stage[main]/Symlink/File[/opt/security]/ensure: created
Notice: /Stage[main]/Symlink/File[/opt/security/story.txt]/ensure: created
Notice: Applied catalog in 0.03 seconds
```

Verify that the file is created in the App server.

```bash
[root@stapp01 ~]# ls -lrt /var/www/html/
total 0
-rw-r--r-- 1 root root 0 Jun 11 13:06 story.txt
[root@stapp01 ~]# 
[root@stapp01 ~]#  ls -lrt /opt/security
lrwxrwxrwx 1 root root 13 Jun 11 13:06 /opt/security -> /var/www/html
```

------------------------------

## Resources