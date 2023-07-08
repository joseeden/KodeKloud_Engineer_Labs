
------------------------------

Start: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2023-06-20 21:04:35  
Finished: &nbsp;&nbsp;2023-06-20 22:40:23

------------------------------

- [Requirements](#requirements)
- [Steps](#steps)
- [Resources](#resources)

------------------------------

# TASK 133: Puppet Setup NTP Server

## Requirements

While troubleshooting one of the issues on app servers in Stratos Datacenter DevOps team identified the root cause that the time isn't synchronized properly among the all app servers which causes issues sometimes. So team has decided to use a specific time server for all app servers, so that they all remain in sync. This task needs to be done using Puppet so as per details mentioned below please compete the task:

- Create a puppet programming file **official.pp** under **/etc/puppetlabs/code/environments/production/manifests** directory on puppet master node i.e on Jump Server. Within the programming file define a **custom class ntpconfig** to install and configure ntp server on **app server 3**.

- Add NTP Server **server 3.europe.pool.ntp.org** in default configuration file on **app server 3**, also remember to use **iburst** option for faster synchronization at startup.

- Please note that do not try to start/restart/stop ntp service, as we already have a scheduled restart for this service tonight and we don't want these changes to be applied right now..

Notes: 

- Please make sure to run the puppet agent test using sudo on agent nodes, otherwise you can face certificate issues. In that case you will have to clean the certificates first and then you will be able to run the puppet agent test.

- Before clicking on the Check button please make sure to verify puppet server and puppet agent services are up and running on the respective servers, also please make sure to run puppet agent test to apply/test the changes manually first.

- Please note that once lab is loaded, the puppet server service should start automatically on puppet master server, however it can take upto 2-3 minutes to start.

------------------------------

## Steps

First, switch to root and verify the module currently installed.
For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
sudo su - 
```

```bash
root@jump_host ~# puppet module list  

/etc/puppetlabs/code/environments/production/modules (no modules installed)
/etc/puppetlabs/code/modules (no modules installed)
/opt/puppetlabs/puppet/modules (no modules installed)
```

Install the Puppet module then verify.

```bash
root@jump_host ~# puppet module install puppetlabs-ntp  

Notice: Preparing to install into /etc/puppetlabs/code/environments/production/modules ...
Notice: Downloading from https://forgeapi.puppet.com ...
Notice: Installing -- do not interrupt ...
/etc/puppetlabs/code/environments/production/modules
└─┬ puppetlabs-ntp (v10.1.0)
  └── puppetlabs-stdlib (v9.1.0)
```
```bash
root@jump_host ~# puppet module list 
 
/etc/puppetlabs/code/environments/production/modules
├── puppetlabs-ntp (v10.1.0)
└── puppetlabs-stdlib (v9.1.0)
/etc/puppetlabs/code/modules (no modules installed)
/opt/puppetlabs/puppet/modules (no modules installed)
```

Proceed to the specified directory and create the **official.pp** .

```bash
cd /etc/puppetlabs/code/environments/production/manifests
```
```bash
class { 'ntp':
  servers => [ 'server 3.europe.pool.ntp.org iburst' ],                                               
}    

class ntpconfig {
  include ntp
}  

node 'stapp03.stratos.xfusioncorp.com' {
  include ntpconfig
}  
```

Validate the Puppet file.

```bash
puppet parser validate official.pp  
```


Next, login to the app server and switch to root. For the server credentials, check out the [Project Nautilus documentation.](https://kodekloudhub.github.io/kodekloud-engineer/docs/projects/nautilus)

```bash
sshpass -p  'xxxxxx' ssh -o StrictHostKeyChecking=no banner@172.16.238.12
sudo su -
```

Pull the configuration from the Puppet server. Note that it will return a lot of output.

```bash
puppet agent -tv  
```

Verify that NTP is running on the app server

```bash
[root@stapp03 ~]# puppet resource service ntpd

service { 'ntpd':
  ensure   => 'running',
  enable   => 'true',
  provider => 'systemd',
}
```


------------------------------

## Resources

- https://www.nbtechsupport.co.in/2021/07/puppet-setup-ntp-server.html?m=1
- https://kodekloud.com/community/t/failed-puppet-setup-ntp-server-task-buggy/7618/17


