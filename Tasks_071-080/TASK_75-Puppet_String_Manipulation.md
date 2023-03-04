
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2022-12-22 19:56:39  
Finished: &nbsp;&nbsp;2022-12-23 00:48:07

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 75: Puppet String Manipulation

## Requirements

There is some data on App Server 2 in Stratos DC. The Nautilus development team shared some requirement with the DevOps team to alter some of the data as per recent changes. The DevOps team is working to prepare a Puppet programming file to accomplish this. Below you can find more details about the task.

- Create a Puppet programming file blog.pp under /etc/puppetlabs/code/environments/production/manifests directory on Puppet master node i.e Jump Server and by using puppet **file_line** resource perform the following tasks.

- We have a file /opt/devops/blog.txt on App Server 2. Use the Puppet programming file mentioned above to replace line "Welcome to Nautilus Industries!" to "Welcome to xFusionCorp Industries!", no other data should be altered in this file.

**Notes**: 

- Please make sure to run the puppet agent test using sudo on agent nodes, otherwise you can face certificate issues. In that case you will have to clean the certificates first and then you will be able to run the puppet agent test.

- Before clicking on the Check button please make sure to verify puppet server and puppet agent services are up and running on the respective servers, also please make sure to run puppet agent test to apply/test the changes manually first.

Please note that once lab is loaded, the puppet server service should start automatically on puppet master server, however it can take upto 2-3 minutes to start.

------------------------------

## Steps

On the jumphost, switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
sudo su  
```

Proceed to the specified directory.

```bash
cd /etc/puppetlabs/code/environments/production/manifests/ 
```

Create the **blog.pp** file based on the requirements.

```bash
$ vi blog.pp

class data_replacer {
  file_line { 'line_replace':
    path => '/opt/devops/blog.txt',
    match => 'Welcome to Nautilus Industries!',
    line  => 'Welcome to xFusionCorp Industries!',
  }
}
node 'stapp02.stratos.xfusioncorp.com' {
  include data_replacer
}
```

Validate the Puppet file.

```bash
puppet parser validate blog.pp 
```

Log-in to the app server and switch to root.
```bash
sshpass -p  '*********' ssh -o StrictHostKeyChecking=no steve@172.16.238.11

sudo su 
```

Run Puppet agent to pull the configuration from puppet server.

```bash
$ puppet agent -tv

Info: Using configured environment 'production'
Info: Retrieving pluginfacts
Info: Retrieving plugin
Info: Retrieving locales
Info: Loading facts
Info: Caching catalog for stapp02.stratos.xfusioncorp.com
Info: Applying configuration version '1671727074'
Notice: Applied catalog in 0.07 seconds


```

To verify that the task was correctly done, check the file **ecommerce.txt**.

```bash
$ cat /opt/devops/blog.txt

This is  Nautilus sample file, created using Puppet!
Welcome to xFusionCorp Industries!
Please do not modify this file manually!
```

------------------------------

## Resources

- https://kodekloud.com/community/t/puppet-string-manipulation-puppetserver-service-not-starting-on-puppetmaster/28236

- https://kodekloud.com/community/t/puppet-string-manipulation-failed/7845

- https://www.nbtechsupport.co.in/2021/05/puppet-string-manipulation.html