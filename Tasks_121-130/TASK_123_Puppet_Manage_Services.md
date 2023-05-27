
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-05-27 15:02:27 
Finished: &nbsp;&nbsp;2023-05-27 15:57:05

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 123: Puppet Manage Services

## Requirements

New packages need to be installed on some of the app servers in Stratos Datacenter. The Nautilus DevOps team has decided to install the same using Puppet. Since jump host is already configured to run as Puppet master server and all app servers are already configured to work as puppet agent nodes, we need to create the required manifests on the Puppet master server so that it can be applied on the required Puppet agent node. Please find more details about the task below.

- Create a Puppet programming file **official.pp** under **/etc/puppetlabs/code/environments/production/manifests** directory on master node i.e Jump Host to perform the below given tasks.

- Install package **tomcat** using puppet package resource and start its service using puppet service resource on Puppet agent node 2 i.e App Server 2.

Notes: 

- Please make sure to run the puppet agent test using sudo on agent nodes, otherwise you can face certificate issues. In that case you will have to clean the certificates first and then you will be able to run the puppet agent test.

- Before clicking on the Check button please make sure to verify puppet server and puppet agent services are up and running on the respective servers, also please make sure to run puppet agent test to apply/test the changes manually first.

- Please note that once lab is loaded, the puppet server service should start automatically on puppet master server, however it can take upto 2-3 minutes to start.

------------------------------

## Steps

Before we proceed, login to the App server and switch to root. Then check if the package is still not installed. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
sshpass -p  '***********' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo su - 
```
```bash
rpm -qa | grep tomcat  
```

Exit out to return to jump host, switch to root, and go to the specified directory.

```bash
sudo su
cd /etc/puppetlabs/code/environments/production/manifests
```

Create the **official.pp**

```bash
class tomcat_installer {
    package {'tomcat':
        ensure => installed
    }
    service {'tomcat':
        ensure    => running,
        enable    => true,
    }
}

node 'stapp01.stratos.xfusioncorp.com', 'stapp02.stratos.xfusioncorp.com', 'stapp03.stratos.xfusioncorp.com' {
  include tomcat_installer
}
```

Validate the Puppet file.

```bash
puppet parser validate official.pp  
```

SSH onto the app server 1 again.

```bash
sshpass -p  '***********' ssh -o StrictHostKeyChecking=no tony@172.16.238.10
sudo su - 
```

Run Puppet agent to pull the configuration from puppet server.

```bash
[root@stapp01 ~]# puppet agent -tv
Info: Creating a new RSA SSL key for stapp01.stratos.xfusioncorp.com
Info: csr_attributes file loading from /etc/puppetlabs/puppet/csr_attributes.yaml
Info: Creating a new SSL certificate request for stapp01.stratos.xfusioncorp.com
Info: Certificate Request fingerprint (SHA256): B5:EA:F4:8E:42:15:2C:DD:DF:75:23:22:02:CC:E6:2E:7C:55:9F:A4:F2:99:B3:A7:21:DA:19:18:C1:85:BA:50
Info: Downloaded certificate for stapp01.stratos.xfusioncorp.com from https://puppet:8140/puppet-ca/v1
Info: Using configured environment 'production'
Info: Retrieving pluginfacts
Info: Retrieving plugin
Info: Retrieving locales
Info: Caching catalog for stapp01.stratos.xfusioncorp.com
Info: Applying configuration version '1685173779'
Notice: /Stage[main]/Tomcat_installer/Package[tomcat]/ensure: created
Notice: /Stage[main]/Tomcat_installer/Service[tomcat]/ensure: ensure changed 'stopped' to 'running'
Info: /Stage[main]/Tomcat_installer/Service[tomcat]: Unscheduling refresh on Service[tomcat]
Info: Creating state file /opt/puppetlabs/puppet/cache/state/state.yaml
Notice: Applied catalog in 100.10 seconds
```

If the command above returned this error:

```bash
Notice: Run of Puppet configuration client already in progress; skipping  (/opt/puppetlabs/puppet/cache/state/agent_catalog_run.lock exists)
```

then use this command instead.

```bash
puppet agent --test 
```

Now check if the package has been installed and is running.

```bash
[root@stapp01 ~]# sudo systemctl status tomcat 
● tomcat.service - Apache tomcat Web Application Container
   Loaded: loaded (/usr/lib/systemd/system/tomcat.service; enabled; vendor preset: disabled)
   Active: active (running) since Sat 2023-05-27 07:20:59 UTC; 48s ago
```

Repeat the same steps on App Server 2 and App Server 3.

```bash
sshpass -p  '***********' ssh -o StrictHostKeyChecking=no steve@172.16.238.11
sudo su -
*********** 
puppet agent -tv 
sudo systemctl status tomcat 
```
```bash
sshpass -p  '***********' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
sudo su -
***********
puppet agent -tv 
sudo systemctl status tomcat 
```


------------------------------

## Resources